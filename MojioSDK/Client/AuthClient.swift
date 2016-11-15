//
//  AuthClient.swift
//  MojioSDK
//
//  Created by Ashish Agarwal on 2016-02-05.
//  Copyright © 2016 Ashish. All rights reserved.
//

import UIKit
import KeychainSwift
import Alamofire
import SwiftyJSON

// OAuth 2.0 Object - RFC 6749
open class AuthToken  {
    open dynamic var accessToken : String? = nil
    open dynamic var expiry : String? = nil
    open dynamic var refreshToken : String? = nil
    open dynamic var uniqueId : String? = nil
    
    init() {

    }
    
    init(accessToken: String?, expiry: String?, refreshToken: String?, uniqueId: String) {

        self.accessToken = accessToken
        self.expiry = expiry
        self.refreshToken = refreshToken
        self.uniqueId = uniqueId
    }
    
    open func expiryTimestamp() -> Double? {
        if let timestamp : Double = Double.init(self.expiry!) {
            return timestamp
        }
        
        return nil
    }
    
    open func expiryDate() -> Date? {
        if let expiry = self.expiryTimestamp() {
            return Date(timeIntervalSince1970: expiry)
        }
        
        return nil
    }
    
    open func isValid() -> Bool {
        if self.accessToken == nil || self.expiry == nil || self.uniqueId == nil {
            return false
        }
        
        // Check if the token is expired
        guard let timestamp : Double = self.expiryTimestamp() else {
            return false
        }
        
        let currentTime : Double = Date().timeIntervalSince1970
        
        // Check for expiry
        if currentTime > timestamp {
            return false
        }
        
        return true
    }
}

open class AuthClientEndpoints : NSObject {
    open static let Authorize : String = "oauth2/authorize"
    open static let Token : String = "oauth2/token"
    open static let Next : String = "oauth2/next/"
}

open class AccountClientEndpoints : NSObject {
    open static let Register : String = "account/register"
    open static let Forgot : String = "account/forgot-password"
    open static let Reset : String = "account/reset-password"
    open static let ResendPin : String = "account/signin/phone"
}

open class RegisterErrors : NSObject {
    // Phone Number Error
    open static let PhoneNumberMessage : String = "PhoneNumberMessage"
    
    // Email Error
    open static let EmailErrorMessage : String = "EmailErrorMessage"
    
    // Password Error
    open static let PasswordRequired : String = "PasswordRequired"
    
    // Confirmation Password Required
    open static let ConfirmationPasswordRequired : String = "ConfirmationPasswordRequired"
    
    // Password does not match Confirmation Password
    open static let PasswordsDoNotMatch : String = "PasswordsDoNotMatch"
}


open class ForgotPasswordErrors : NSObject {
    // User not found
    open static let NoUserFoundByIdentifier : String = "NoUserFoundByIdentifier"
    
    // Maximum hourly reset limit reached
    open static let ResetAlreadySent : String = "ResetAlreadySent"
    
    // Error sending SMS
    open static let TextSendError : String = "TextSendError"
    
    // Invalid email address
    open static let InvalidEmailContactMojio : String = "InvalidEmailContactMojio"
    
    // Email address was rejected
    open static let IRejectedEmailContactMojio : String = "IRejectedEmailContactMojio"
    
    // Invalid phone number
    open static let InvalidPhoneContactMojio : String = "InvalidPhoneContactMojio"
}

open class ResetPasswordErrors : NSObject {
    // Reset link invalid (or expired)
    open static let InvalidResetLink : String = "InvalidResetLink"

    // Password Required
    open static let PasswordRequired : String = "PasswordRequired"
    
    // Confirmation Password Required
    open static let ConfirmationPasswordRequired : String = "ConfirmationPasswordRequired"
    
    // Password does not match Confirmation Password
    open static let PasswordsDoNotMatch : String = "PasswordsDoNotMatch"
    
    // TODO: Handle Password Too Short/Too Long???
}

open class AuthClient: NSObject, AuthControllerDelegate {

    open var clientId: String
    open var clientRedirectURL: String
    open var clientSecretKey: String
    
    // TODO: Move controller to a consumer role
    open var loginURL: URL!
    open var loginCompletion: ((_ authToken: AuthToken) -> Void)? = nil
    open var loginFailure: ((_ response: AnyObject?) -> Void)? = nil
    open var authController: AuthViewController?
        
    public init(clientId : String, clientSecretKey : String, clientRedirectURI : String) {
        self.clientId = clientId
        self.clientRedirectURL = clientRedirectURI
        self.clientSecretKey = clientSecretKey
        
        // TODO: make this accounts endpoint
        self.loginURL = URL(string: AuthClient.getAuthorizeUrl(self.clientRedirectURL, clientId: self.clientId))
    }
    
    open func loginViewController(_ completion : ((_ authToken: AuthToken) -> Void)?, failure: ((_ response: AnyObject?) -> Void)?) {
        URLCache.shared.removeAllCachedResponses();
        
        self.loginCompletion = completion;
        self.loginFailure = failure
        self.authController = AuthViewController(nibName : "AuthViewController", bundle: nil);
        self.authController?.delegate = self;
        
        self.authController?.loginURL = self.loginURL
        UIApplication.shared.delegate?.window!!.rootViewController = self.authController;
    }
    
    open func authControllerLoadURLRequest(_ request: URLRequest) {
        let url : URL = request.url!;
        let urlComponents : URLComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        let authToken : AuthToken = AuthToken()
        
        if let queryItems = urlComponents.queryItems {
            for queryItem in queryItems {
                if queryItem.name == "access_token" {
                    authToken.accessToken = queryItem.value
                }
                else if queryItem.name == "expires_in" {
                    if queryItem.value != nil {
                        if let expiry : Double = Double(queryItem.value!) {
                            authToken.expiry = String(Date.init(timeIntervalSinceNow: expiry).timeIntervalSince1970)
                        }
                    }
                }
                else if queryItem.name == "refresh_token" {
                    authToken.refreshToken = queryItem.value
                }
            }
        }
        
        self.authController?.dismiss(animated: true, completion: {
            self.loginCompletion?(authToken)
        });
    }
    
    // Returns immediately
    open func isUserLoggedIn() -> Bool {
        let authToken = self.getAuthToken()
        
        if authToken.accessToken == nil || authToken.expiry == nil || authToken.uniqueId == nil {
            return false
        }
        
        // Check to see if the environment endpoint in the keychain is the same as the current endpoint
        if ClientEnvironment.SharedInstance.getRegion() != authToken.uniqueId {
            return false
        }
        
        // Check if the token is expired
        guard let timestamp : Double = authToken.expiryTimestamp() else {
            return false
        }
        
        let currentTime : Double = Date().timeIntervalSince1970
        
        // Check for expiry
        if currentTime > timestamp {
            return false
        }
        
        return true
    }

    // Returns on main thread when complete - refreshes if needed
    open func isUserLoggedInRefresh(_ completion: @escaping (_ authToken: AuthToken) -> Void, failure : @escaping (_ response: NSDictionary?) -> Void) {

        let authToken = self.getAuthToken()
        
        if authToken.accessToken == nil || authToken.expiry == nil || authToken.uniqueId == nil {
            DispatchQueue.main.async(execute: {failure(nil)})
            return
        }

        // Check to see if the environment endpoint in the keychain is the same as the current endpoint
        // If they are different, return false right away
        if ClientEnvironment.SharedInstance.getRegion() != authToken.uniqueId {
            DispatchQueue.main.async(execute: {failure(nil)})
            return
        }
        
        // Always attempt to refresh
        if authToken.refreshToken != nil {
            self.refreshAuthToken(completion, failure: failure)
        }
        else {
            // Check if the token is expired
            DispatchQueue.main.async(execute: {
                guard let timestamp : Double = authToken.expiryTimestamp() else {
                    failure(nil)
                    return
                }
                
                let currentTime : Double = Date().timeIntervalSince1970
                
                // Check for expiry
                if currentTime > timestamp {
                    failure(nil)
                }
                
                completion(authToken)
            })
        }
    }
    
    open func generateBasicAuthHeader() -> String {
        let authString = (self.clientId + ":" + self.clientSecretKey).data(using: String.Encoding.utf8, allowLossyConversion: false)!
        let base64AuthString = authString.base64EncodedString(options: NSData.Base64EncodingOptions.lineLength76Characters).replacingOccurrences(of: "\r\n", with: "")
        return "Basic " + base64AuthString
    }
    
    // Login
    open func login(_ username: String, password: String, completion: @escaping (_ authToken: AuthToken) -> Void, failure : @escaping (_ response: NSDictionary?) -> Void) {
        
        // The token endpoint is used for the resource owner flow
        let loginEndpoint = AuthClient.getTokenUrl()
        
        Alamofire.request(loginEndpoint, method: .post, parameters: ["grant_type" : "password", "password" : password, "username" : username, "client_id" : self.clientId, "client_secret" : self.clientSecretKey], encoding: URLEncoding(destination: .methodDependent), headers: ["Accept" : "application/json", "Authorization" : self.generateBasicAuthHeader()]).responseJSON{response in
            
            if response.response?.statusCode == 200 {
                
                guard let responseJSON : [String : AnyObject] = response.result.value as? [String : AnyObject] else {
                    failure(nil)
                    return
                }
                
                if let expiry : Double = responseJSON["expires_in"] as? Double {
                    let authToken = AuthToken(accessToken: (responseJSON["access_token"] as? String), expiry: String(NSDate.init(timeIntervalSinceNow: expiry).timeIntervalSince1970), refreshToken: (responseJSON["refresh_token"] as? String), uniqueId: ClientEnvironment.SharedInstance.getRegion())
                    
                    if authToken.isValid() {
                        completion(authToken)
                    }
                    else {
                        failure(nil)
                    }
                }
                else {
                    failure(nil)
                }
            }
            else {
                failure(response.result.value as? NSDictionary)
            }
        }
    }
    
    open func refreshAuthToken(_ completion: @escaping (_ authToken: AuthToken) -> Void, failure : @escaping (_ response: NSDictionary?) -> Void) {
        let keychain = KeychainSwift()
        
        let authorizeEndpoint = AuthClient.getTokenUrl()

        guard let refreshToken : String = keychain.get(KeychainKeys.RefreshToken) else {
            DispatchQueue.main.async(execute: {failure(nil)})
            return
        }
        
        Alamofire.request(authorizeEndpoint, method: .post, parameters: ["grant_type" : "refresh_token", "refresh_token" : refreshToken, "client_id" : self.clientId, "client_secret" : self.clientSecretKey, "redirect_uri" : self.clientRedirectURL], encoding: URLEncoding(destination: .methodDependent)).responseJSON(completionHandler: {response in
            
            DispatchQueue.main.async(execute: {
                if response.response?.statusCode == 200 {
                    
                    guard let responseJSON : [String : AnyObject] = response.result.value as? [String : AnyObject] else {
                        failure(nil)
                        return
                    }
                    
                    if let expiry : Double = responseJSON["expires_in"] as? Double {
                        let authToken: AuthToken = AuthToken(accessToken: (responseJSON["access_token"] as? String), expiry: String(NSDate.init(timeIntervalSinceNow: expiry).timeIntervalSince1970), refreshToken: (responseJSON["refresh_token"] as? String), uniqueId: ClientEnvironment.SharedInstance.getRegion())
                        
                        if authToken.isValid() {
                            completion(authToken)
                        }
                        else {
                            failure(nil)
                        }
                    }
                    else {
                        failure(nil)
                    }
                }
                else {
                    // TODO: Return error?
                    // var resultObj = String.init(data: response.data!, encoding: NSUTF8StringEncoding)
                    failure(nil)
                }
            })
        })
    }
    
    open func logout() {
        KeychainManager().deleteTokenFromKeychain()
    }
    
    // Register
    open func register(_ mobile: String, email: String, password: String, completion: @escaping (_ authToken: AuthToken) -> Void, failure: @escaping (_ response : NSDictionary?) -> Void) {
        
        let registerEndpoint = ClientEnvironment.SharedInstance.getAccountsEndpoint() + AccountClientEndpoints.Register
        let headers = ["Authorization" : self.generateBasicAuthHeader(), "Content-Type" : "application/json", "Accept" : "application/json"]

        // Step 1: Create an account for the user
        Alamofire.request(registerEndpoint, method: .post, parameters: ["PhoneNumber" : mobile, "Email" : email, "Password" : password, "ConfirmPassword" : password], encoding: JSONEncoding.default, headers: headers).responseJSON { response in

            if response.response?.statusCode == 200 {
                
                // Step 2: If account creation was successful, log the user in
                self.login(email, password: password, completion: {authToken in
                    
                    completion(authToken)
                    
                    }, failure: {response in
                        failure(response)
                })
                
            }
            else {
                failure(response.result.value as? NSDictionary)
            }
        }
    }
    
    // Verify Phone
    open func verifyMobilePhone(_ mobile: String, pin: String, completion: @escaping (_ authToken: AuthToken) -> Void, failure : @escaping (_ response: NSDictionary?) -> Void) {
        
        let verifyEndpoint = AuthClient.getTokenUrl()
        
        Alamofire.request(verifyEndpoint, method: .post, parameters: ["client_id" : self.clientId, "client_secret" : self.clientSecretKey, "grant_type" : "phone", "phone_number" : mobile, "pin" : pin], encoding: URLEncoding(destination: .methodDependent), headers: ["Accept" : "application/json", "Authorization" : self.generateBasicAuthHeader()]).responseJSON { response in
            
            if response.response?.statusCode == 200 {
                
                guard let responseJSON : [String : AnyObject] = response.result.value as? [String : AnyObject] else {
                    failure(nil)
                    return
                }
                
                if let expiry : Double = responseJSON["expires_in"] as? Double {
                    let authToken: AuthToken = AuthToken(accessToken: (responseJSON["access_token"] as! String), expiry: String(NSDate.init(timeIntervalSinceNow: expiry).timeIntervalSince1970), refreshToken: (responseJSON["refresh_token"] as! String), uniqueId: ClientEnvironment.SharedInstance.getRegion())
                    
                    if authToken.isValid() {
                        completion(authToken)
                    }
                    else {
                        failure(nil)
                    }
                }
                else {
                    failure(nil)
                }
            }
            else {
                failure(response.result.value as? NSDictionary)
            }
        }
    }
    
    // Resend Verification Pin
    open func resendPhonePin(_ mobile : String, completion : (() -> Void)?, failure : (() -> Void)?) {
        
        let verifyEndpoint = ClientEnvironment.SharedInstance.getAccountsEndpoint() + AccountClientEndpoints.ResendPin
        
        // ["PhoneNumber" : mobile]
        
        Alamofire.request(verifyEndpoint, method: .post, parameters: ["PhoneNumber" : mobile, "grant_type" : "phone"], encoding: JSONEncoding.default, headers: ["Accept" : "application/json", "Authorization" : self.generateBasicAuthHeader()]).responseJSON { response in
            
            if response.response?.statusCode == 200 {
                completion?()
            }
            else {
                failure?()
            }
        }
    }
    
    // Forgot/Reset Password
    open func forgotPassword(_ emailOrPhoneNumber : String, completion : @escaping (_ response : NSDictionary?) -> Void, failure : @escaping (_ response : NSDictionary?) -> Void) {
        
        let forgotEndpoint = ClientEnvironment.SharedInstance.getAccountsEndpoint() + AccountClientEndpoints.Forgot
        
        Alamofire.request(forgotEndpoint, method: .post, parameters: ["UserNameEmailOrPhone" : emailOrPhoneNumber], encoding: JSONEncoding.default, headers: ["Accept" : "application/json", "Authorization" : self.generateBasicAuthHeader()]).responseJSON(completionHandler: { response in

            if response.response?.statusCode == 200 {
                completion(response.result.value as? NSDictionary)
            }
            else {
                failure(response.result.value as? NSDictionary)
            }
        })
    }
    
    open func resetPassword(_ resetToken : String, password : String, completion : @escaping (_ response : NSDictionary?) -> Void, failure : @escaping (_ response : NSDictionary?) -> Void) {
        
        let resetEndpoint = ClientEnvironment.SharedInstance.getAccountsEndpoint() + AccountClientEndpoints.Reset

        Alamofire.request(resetEndpoint, method: .post, parameters: ["ResetToken" : resetToken, "Password" : password, "ConfirmPassword" : password], encoding: JSONEncoding.default, headers: ["Accept" : "application/json", "Authorization" : self.generateBasicAuthHeader()]).responseJSON(completionHandler: { response in

            if response.response?.statusCode == 200 {
                completion(response.result.value as? NSDictionary)
            }
            else {
                failure(response.result.value as? NSDictionary)
            }
        })
    }
    
    open func getAuthToken() -> AuthToken {
        return KeychainManager().getAuthToken()
    }
    
    open func saveAuthToken(_ authToken: AuthToken) -> Void {
        KeychainManager().saveAuthToken(authToken)
    }
    
    open static func getTokenUrl() -> String {
        return ClientEnvironment.SharedInstance.getAccountsEndpoint() + AuthClientEndpoints.Token
    }
    
    open static func getTokenUrl(_ redirectUri : String, clientId : String) -> String {
        return String(format: "%@%@?response_type=token&redirect_uri=%@&client_id=%@&scope=full", ClientEnvironment.SharedInstance.getAccountsEndpoint(), AuthClientEndpoints.Token, redirectUri.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!, clientId.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)
    }
    
    open static func getAuthorizeUrl() -> String {
        return ClientEnvironment.SharedInstance.getAccountsEndpoint() + AuthClientEndpoints.Authorize
    }
    
    open static func getAuthorizeUrl(_ redirectUri : String, clientId : String) -> String {
        return String(format: "%@%@?response_type=token&redirect_uri=%@&client_id=%@&scope=full", ClientEnvironment.SharedInstance.getAccountsEndpoint(), AuthClientEndpoints.Authorize, redirectUri.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!, clientId.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)
    }
}
