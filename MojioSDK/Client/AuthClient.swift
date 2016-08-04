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
public class AuthToken  {
    public dynamic var accessToken : String? = nil
    public dynamic var expiry : String? = nil
    public dynamic var refreshToken : String? = nil
    public dynamic var uniqueId : String? = nil
    
    init() {

    }
    
    init(accessToken: String?, expiry: String?, refreshToken: String?, uniqueId: String) {

        self.accessToken = accessToken
        self.expiry = expiry
        self.refreshToken = refreshToken
        self.uniqueId = uniqueId
    }
    
    public func expiryTimestamp() -> Double? {
        if let timestamp : Double = Double.init(self.expiry!) {
            return timestamp
        }
        
        return nil
    }
    
    public func expiryDate() -> NSDate? {
        if let date : NSDate = NSDate.init(timeIntervalSince1970: self.expiryTimestamp()!) {
            return date
        }
        
        return nil
    }
    
    public func isValid() -> Bool {
        if self.accessToken == nil || self.expiry == nil || self.uniqueId == nil {
            return false
        }
        
        // Check if the token is expired
        guard let timestamp : Double = self.expiryTimestamp()! else {
            return false
        }
        
        let currentTime : Double = NSDate().timeIntervalSince1970
        
        // Check for expiry
        if currentTime > timestamp {
            return false
        }
        
        return true
    }
}

public class AuthClientEndpoints : NSObject {
    public static let Authorize : String = "oauth2/authorize"
    public static let Token : String = "oauth2/token"
    public static let Next : String = "oauth2/next/"
}

public class AccountClientEndpoints : NSObject {
    public static let Register : String = "account/register"
    public static let Forgot : String = "account/forgot-password"
    public static let Reset : String = "account/reset-password"
    public static let ResendPin : String = "account/signin/phone"
}

public class RegisterErrors : NSObject {
    // Phone Number Error
    public static let PhoneNumberMessage : String = "PhoneNumberMessage"
    
    // Email Error
    public static let EmailErrorMessage : String = "EmailErrorMessage"
    
    // Password Error
    public static let PasswordRequired : String = "PasswordRequired"
    
    // Confirmation Password Required
    public static let ConfirmationPasswordRequired : String = "ConfirmationPasswordRequired"
    
    // Password does not match Confirmation Password
    public static let PasswordsDoNotMatch : String = "PasswordsDoNotMatch"
}


public class ForgotPasswordErrors : NSObject {
    // User not found
    public static let NoUserFoundByIdentifier : String = "NoUserFoundByIdentifier"
    
    // Maximum hourly reset limit reached
    public static let ResetAlreadySent : String = "ResetAlreadySent"
    
    // Error sending SMS
    public static let TextSendError : String = "TextSendError"
    
    // Invalid email address
    public static let InvalidEmailContactMojio : String = "InvalidEmailContactMojio"
    
    // Email address was rejected
    public static let IRejectedEmailContactMojio : String = "IRejectedEmailContactMojio"
    
    // Invalid phone number
    public static let InvalidPhoneContactMojio : String = "InvalidPhoneContactMojio"
}

public class ResetPasswordErrors : NSObject {
    // Reset link invalid (or expired)
    public static let InvalidResetLink : String = "InvalidResetLink"

    // Password Required
    public static let PasswordRequired : String = "PasswordRequired"
    
    // Confirmation Password Required
    public static let ConfirmationPasswordRequired : String = "ConfirmationPasswordRequired"
    
    // Password does not match Confirmation Password
    public static let PasswordsDoNotMatch : String = "PasswordsDoNotMatch"
    
    // TODO: Handle Password Too Short/Too Long???
}

public class AuthClient: NSObject, AuthControllerDelegate {

    public var clientId: String
    public var clientRedirectURL: String
    public var clientSecretKey: String
    
    // TODO: Move controller to a consumer role
    public var loginURL: NSURL!
    public var loginCompletion: ((authToken: AuthToken) -> Void)? = nil
    public var loginFailure: ((response: AnyObject?) -> Void)? = nil
    public var authController: AuthViewController?
        
    public init(clientId : String, clientSecretKey : String, clientRedirectURI : String) {
        self.clientId = clientId
        self.clientRedirectURL = clientRedirectURI
        self.clientSecretKey = clientSecretKey
        
        // TODO: make this accounts endpoint
        self.loginURL = NSURL(string: AuthClient.getAuthorizeUrl(self.clientRedirectURL, clientId: self.clientId))
    }
    
    public func loginViewController(completion : ((authToken: AuthToken) -> Void)?, failure: ((response: AnyObject?) -> Void)?) {
        NSURLCache.sharedURLCache().removeAllCachedResponses();
        
        self.loginCompletion = completion;
        self.loginFailure = failure
        self.authController = AuthViewController(nibName : "AuthViewController", bundle: nil);
        self.authController?.delegate = self;
        
        self.authController?.loginURL = self.loginURL
        UIApplication.sharedApplication().delegate?.window!!.rootViewController = self.authController;
    }
    
    public func authControllerLoadURLRequest(request: NSURLRequest) {
        let url : NSURL = request.URL!;
        let urlComponents : NSURLComponents = NSURLComponents(URL: url, resolvingAgainstBaseURL: false)!
        let authToken : AuthToken = AuthToken()
        
        if let queryItems = urlComponents.queryItems {
            for queryItem in queryItems {
                if queryItem.name == "access_token" {
                    authToken.accessToken = queryItem.value
                }
                else if queryItem.name == "expires_in" {
                    if queryItem.value != nil {
                        if let expiry : Double = Double(queryItem.value!) {
                            authToken.expiry = String(NSDate.init(timeIntervalSinceNow: expiry).timeIntervalSince1970)
                        }
                    }
                }
                else if queryItem.name == "refresh_token" {
                    authToken.refreshToken = queryItem.value
                }
            }
        }
        
        self.authController?.dismissViewControllerAnimated(true, completion: {
            self.loginCompletion?(authToken: authToken)
        });
    }
    
    // Returns immediately
    public func isUserLoggedIn() -> Bool {
        let authToken = self.getAuthToken()
        
        if authToken.accessToken == nil || authToken.expiry == nil || authToken.uniqueId == nil {
            return false
        }
        
        // Check to see if the environment endpoint in the keychain is the same as the current endpoint
        if ClientEnvironment.SharedInstance.getRegion() != authToken.uniqueId {
            return false
        }
        
        // Check if the token is expired
        guard let timestamp : Double = authToken.expiryTimestamp()! else {
            return false
        }
        
        let currentTime : Double = NSDate().timeIntervalSince1970
        
        // Check for expiry
        if currentTime > timestamp {
            return false
        }
        
        return true
    }

    // Returns on main thread when complete - refreshes if needed
    public func isUserLoggedInRefresh(completion: (authToken: AuthToken) -> Void, failure : (response: NSDictionary?) -> Void) {

        let authToken = self.getAuthToken()
        
        if authToken.accessToken == nil || authToken.expiry == nil || authToken.uniqueId == nil {
            dispatch_async(dispatch_get_main_queue(), {failure(response: nil)})
            return
        }

        // Check to see if the environment endpoint in the keychain is the same as the current endpoint
        // If they are different, return false right away
        if ClientEnvironment.SharedInstance.getRegion() != authToken.uniqueId {
            dispatch_async(dispatch_get_main_queue(), {failure(response: nil)})
            return
        }
        
        // Always attempt to refresh
        if authToken.refreshToken != nil {
            self.refreshAuthToken(completion, failure: failure)
        }
        else {
            // Check if the token is expired
            dispatch_async(dispatch_get_main_queue(), {
                guard let timestamp : Double = authToken.expiryTimestamp()! else {
                    failure(response: nil)
                }
                
                let currentTime : Double = NSDate().timeIntervalSince1970
                
                // Check for expiry
                if currentTime > timestamp {
                    failure(response: nil)
                }
                
                completion(authToken: authToken)
            })
        }
    }
    
    public func generateBasicAuthHeader() -> String {
        let authString = (self.clientId + ":" + self.clientSecretKey).dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)!
        let base64AuthString = authString.base64EncodedStringWithOptions(NSDataBase64EncodingOptions.Encoding76CharacterLineLength).stringByReplacingOccurrencesOfString("\r\n", withString: "")
        return "Basic " + base64AuthString
    }
    
    // Login
    public func login(username: String, password: String, completion: (authToken: AuthToken) -> Void, failure : (response: NSDictionary?) -> Void) {
        
        // The token endpoint is used for the resource owner flow
        let loginEndpoint = AuthClient.getTokenUrl()
        
        Alamofire.request(.POST, loginEndpoint, parameters: ["grant_type" : "password", "password" : password, "username" : username, "client_id" : self.clientId, "client_secret" : self.clientSecretKey], encoding: .URL, headers: ["Accept" : "application/json", "Authorization" : self.generateBasicAuthHeader()]).responseJSON{ response in
            
            if response.response?.statusCode == 200 {
                
                guard let responseJSON : [String : AnyObject] = response.result.value as? [String : AnyObject] else {
                    failure(response: nil)
                    return
                }
                
                if let expiry : Double = responseJSON["expires_in"] as? Double {
                    guard let authToken: AuthToken = AuthToken(accessToken: (responseJSON["access_token"] as! String), expiry: String(NSDate.init(timeIntervalSinceNow: expiry).timeIntervalSince1970), refreshToken: (responseJSON["refresh_token"] as! String), uniqueId: ClientEnvironment.SharedInstance.getRegion()) else {
                        failure(response: nil)
                        return
                    }
                    
                    if authToken.isValid() {
                        completion(authToken: authToken)
                    }
                    else {
                        failure(response: nil)
                    }
                }
                else {
                    failure(response: nil)
                }
            }
            else {
                failure(response: response.result.value as? NSDictionary)
            }
        }
    }
    
    public func refreshAuthToken(completion: (authToken: AuthToken) -> Void, failure : (response: NSDictionary?) -> Void) {
        let keychain = KeychainSwift()
        
        let authorizeEndpoint = AuthClient.getTokenUrl()

        guard let refreshToken : String = keychain.get(KeychainKeys.RefreshToken) else {
            dispatch_async(dispatch_get_main_queue(), {failure(response: nil)})
            return
        }
        
        Alamofire.request(.POST, authorizeEndpoint, parameters: ["grant_type" : "refresh_token", "refresh_token" : refreshToken, "client_id" : self.clientId, "client_secret" : self.clientSecretKey, "redirect_uri" : self.clientRedirectURL], encoding: ParameterEncoding.URL).responseJSON(completionHandler: {response in
            
            dispatch_async(dispatch_get_main_queue(), {
                if response.response?.statusCode == 200 {
                    
                    guard let responseJSON : [String : AnyObject] = response.result.value as? [String : AnyObject] else {
                        failure(response: nil)
                        return
                    }
                    
                    if let expiry : Double = responseJSON["expires_in"] as? Double {
                        guard let authToken: AuthToken = AuthToken(accessToken: (responseJSON["access_token"] as! String), expiry: String(NSDate.init(timeIntervalSinceNow: expiry).timeIntervalSince1970), refreshToken: (responseJSON["refresh_token"] as! String), uniqueId: ClientEnvironment.SharedInstance.getRegion()) else {
                            failure(response: nil)
                            return
                        }
                        
                        if authToken.isValid() {
                            completion(authToken: authToken)
                        }
                        else {
                            failure(response: nil)
                        }
                    }
                    else {
                        failure(response: nil)
                    }
                }
                else {
                    // TODO: Return error?
                    // var resultObj = String.init(data: response.data!, encoding: NSUTF8StringEncoding)
                    failure(response: nil)
                }
            })
        })
    }
    
    public func logout() {
        KeychainManager().deleteTokenFromKeychain()
    }
    
    // Register
    public func register(mobile: String, email: String, password: String, completion: () -> Void, failure: (response : NSDictionary?) -> Void) {
        
        let registerEndpoint = ClientEnvironment.SharedInstance.getAccountsEndpoint() + AccountClientEndpoints.Register
        let headers = ["Authorization" : self.generateBasicAuthHeader(), "Content-Type" : "application/json", "Accept" : "application/json"]

        Alamofire.request(.POST, registerEndpoint, parameters: ["PhoneNumber" : mobile, "Email" : email, "Password" : password, "ConfirmPassword" : password], encoding: .JSON, headers: headers).responseJSON { response in

            if response.response?.statusCode == 200 {
                completion()
            }
            else {
                failure(response: response.result.value as? NSDictionary)
            }
        }
    }
    
    // Verify Phone
    public func verifyMobilePhone(mobile: String, pin: String, completion: (authToken: AuthToken) -> Void, failure : (response: NSDictionary?) -> Void) {
        
        let verifyEndpoint = AuthClient.getTokenUrl()
        
        Alamofire.request(.POST, verifyEndpoint, parameters: ["client_id" : self.clientId, "client_secret" : self.clientSecretKey, "grant_type" : "phone", "phone_number" : mobile, "pin" : pin], encoding: .URL, headers: ["Accept" : "application/json", "Authorization" : self.generateBasicAuthHeader()]).responseJSON { response in
            
            if response.response?.statusCode == 200 {
                
                guard let responseJSON : [String : AnyObject] = response.result.value as? [String : AnyObject] else {
                    failure(response: nil)
                    return
                }
                
                if let expiry : Double = responseJSON["expires_in"] as? Double {
                    guard let authToken: AuthToken = AuthToken(accessToken: (responseJSON["access_token"] as! String), expiry: String(NSDate.init(timeIntervalSinceNow: expiry).timeIntervalSince1970), refreshToken: (responseJSON["refresh_token"] as! String), uniqueId: ClientEnvironment.SharedInstance.getRegion()) else {
                        failure(response: nil)
                        return
                    }
                    
                    if authToken.isValid() {
                        completion(authToken: authToken)
                    }
                    else {
                        failure(response: nil)
                    }
                }
                else {
                    failure(response: nil)
                }
            }
            else {
                failure(response: response.result.value as? NSDictionary)
            }
        }
    }
    
    // Resend Verification Pin
    public func resendPhonePin(mobile : String, completion : (() -> Void)?, failure : (() -> Void)?) {
        
        let verifyEndpoint = ClientEnvironment.SharedInstance.getAccountsEndpoint() + AccountClientEndpoints.ResendPin
        
        // ["PhoneNumber" : mobile]
        
        Alamofire.request(.POST, verifyEndpoint, parameters: ["PhoneNumber" : mobile, "grant_type" : "phone"], encoding: .JSON, headers: ["Accept" : "application/json", "Authorization" : self.generateBasicAuthHeader()]).responseJSON { response in
            
            if response.response?.statusCode == 200 {
                completion?()
            }
            else {
                failure?()
            }
        }
    }
    
    // Forgot/Reset Password
    public func forgotPassword(emailOrPhoneNumber : String, completion : (response : NSDictionary?) -> Void, failure : (response : NSDictionary?) -> Void) {
        
        let forgotEndpoint = ClientEnvironment.SharedInstance.getAccountsEndpoint() + AccountClientEndpoints.Forgot
        
        Alamofire.request(.POST, forgotEndpoint, parameters: ["UserNameEmailOrPhone" : emailOrPhoneNumber], encoding: .JSON, headers: ["Accept" : "application/json", "Authorization" : self.generateBasicAuthHeader()]).responseJSON(completionHandler: { response in

            if response.response?.statusCode == 200 {
                completion(response: response.result.value as? NSDictionary)
            }
            else {
                failure(response: response.result.value as? NSDictionary)
            }
        })
    }
    
    public func resetPassword(resetToken : String, password : String, completion : (response : NSDictionary?) -> Void, failure : (response : NSDictionary?) -> Void) {
        
        let resetEndpoint = ClientEnvironment.SharedInstance.getAccountsEndpoint() + AccountClientEndpoints.Reset

        Alamofire.request(.POST, resetEndpoint, parameters: ["ResetToken" : resetToken, "Password" : password, "ConfirmPassword" : password], encoding: .JSON, headers: ["Accept" : "application/json", "Authorization" : self.generateBasicAuthHeader()]).responseJSON(completionHandler: { response in

            if response.response?.statusCode == 200 {
                completion(response: response.result.value as? NSDictionary)
            }
            else {
                failure(response: response.result.value as? NSDictionary)
            }
        })
    }
    
    public func getAuthToken() -> AuthToken {
        return KeychainManager().getAuthToken()
    }
    
    public func saveAuthToken(authToken: AuthToken) -> Void {
        KeychainManager().saveAuthToken(authToken)
    }
    
    public static func getTokenUrl() -> String {
        return ClientEnvironment.SharedInstance.getAccountsEndpoint() + AuthClientEndpoints.Token
    }
    
    public static func getTokenUrl(redirectUri : String, clientId : String) -> String {
        return String(format: "%@%@?response_type=token&redirect_uri=%@&client_id=%@&scope=full", ClientEnvironment.SharedInstance.getAccountsEndpoint(), AuthClientEndpoints.Token, redirectUri.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!, clientId.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!)
    }
    
    public static func getAuthorizeUrl() -> String {
        return ClientEnvironment.SharedInstance.getAccountsEndpoint() + AuthClientEndpoints.Authorize
    }
    
    public static func getAuthorizeUrl(redirectUri : String, clientId : String) -> String {
        return String(format: "%@%@?response_type=token&redirect_uri=%@&client_id=%@&scope=full", ClientEnvironment.SharedInstance.getAccountsEndpoint(), AuthClientEndpoints.Authorize, redirectUri.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!, clientId.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!)
    }
}
