/******************************************************************************
 * Moj.io Inc. CONFIDENTIAL
 * 2017 Copyright Moj.io Inc.
 * All Rights Reserved.
 *
 * NOTICE:  All information contained herein is, and remains, the property of
 * Moj.io Inc. and its suppliers, if any.  The intellectual and technical
 * concepts contained herein are proprietary to Moj.io Inc. and its suppliers
 * and may be covered by Patents, pending patents, and are protected by trade
 * secret or copyright law.
 *
 * Dissemination of this information or reproduction of this material is strictly
 * forbidden unless prior written permission is obtained from Moj.io Inc.
 *******************************************************************************/

import UIKit
import KeychainSwift
import Alamofire
import SwiftyJSON
import ObjectMapper

// OAuth 2.0 Object - RFC 6749

public struct AuthToken: Mappable  {
    public var accessToken: String? = nil
    public var expiry: String? = nil
    public var refreshToken: String? = nil
    public var uniqueId: String? = nil
    
    init() {}
    
    init(accessToken: String?, expiry: String?, refreshToken: String?, uniqueId: String) {
        self.accessToken = accessToken
        self.expiry = expiry
        self.refreshToken = refreshToken
        self.uniqueId = uniqueId
    }
    
    public init?(map: Map) {
        self.init()
    }
    
    public func expiryTimestamp() -> Double? {
        if let timestamp: Double = Double.init(self.expiry!) {
            return timestamp
        }
        
        return nil
    }
    
    public func expiryDate() -> Date? {
        if let expiry = self.expiryTimestamp() {
            return Date(timeIntervalSince1970: expiry)
        }
        
        return nil
    }
    
    public func isValid() -> Bool {
        if self.accessToken == nil || self.expiry == nil || self.uniqueId == nil {
            return false
        }
        
        // Check if the token is expired
        guard let timestamp: Double = self.expiryTimestamp() else {
            return false
        }
        
        let currentTime: Double = Date().timeIntervalSince1970
        
        // Check for expiry
        if currentTime > timestamp {
            return false
        }
        
        return true
    }
    
    public mutating func mapping(map: Map) {
        accessToken <- map["accessToken"]
        expiry <- map["expiry"]
        refreshToken <- map["refreshToken"]
        uniqueId <- map["uniqueId"]
    }
}

public enum AuthClientEndpoint: String {
    case authorize = "oauth2/authorize"
    case token = "oauth2/token"
    case next = "oauth2/next/"
}

public enum AccountClientEndpoint: String {
    case register = "account/register"
    case forgot = "account/forgot-password"
    case reset = "account/reset-password"
    case resendPin = "account/signin/phone"
}

public enum RegisterError: String {
    // Phone Number Error
    case phoneNumberMessage = "PhoneNumberMessage"
    
    // Email Error
    case emailErrorMessage = "EmailErrorMessage"
    
    // Password Error
    case passwordRequired = "PasswordRequired"
    
    // Confirmation Password Required
    case confirmationPasswordRequired = "ConfirmationPasswordRequired"
    
    // Password does not match Confirmation Password
    case passwordsDoNotMatch = "PasswordsDoNotMatch"
}


public enum ForgotPasswordError: String {
    // User not found
    case noUserFoundByIdentifier = "NoUserFoundByIdentifier"
    
    // Maximum hourly reset limit reached
    case resetAlreadySent = "ResetAlreadySent"
    
    // Error sending SMS
    case textSendError = "TextSendError"
    
    // Invalid email address
    case invalidEmailContactMojio = "InvalidEmailContactMojio"
    
    // Email address was rejected
    case rejectedEmailContactMojio = "IRejectedEmailContactMojio"
    
    // Invalid phone number
    case invalidPhoneContactMojio = "InvalidPhoneContactMojio"
}

public enum ResetPasswordError: String {
    // Reset link invalid (or expired)
    case invalidResetLink = "InvalidResetLink"
    
    // Password Required
    case passwordRequired = "PasswordRequired"
    
    // Confirmation Password Required
    case confirmationPasswordRequired = "ConfirmationPasswordRequired"
    
    // Password does not match Confirmation Password
    case passwordsDoNotMatch = "PasswordsDoNotMatch"
    
    // TODO: Handle Password Too Short/Too Long???
}

open class AuthClient: AuthControllerDelegate {
    
    open var clientId: String
    open var clientRedirectURL: String
    open var clientSecretKey: String
    
    // TODO: Move controller to a consumer role
    open var loginURL: URL!
    open var loginCompletion: ((_ authToken: AuthToken) -> Void)? = nil
    open var loginFailure: ((_ response: Any?) -> Void)? = nil
    open var authController: AuthViewController?
    
    public dynamic var requestHeaders: [String:String] = ClientHeaders.defaultRequestHeaders
    
    // Default to global concurrent queue with default priority
    public static var defaultDispatchQueue = DispatchQueue.global()
    private var dispatchQueue = AuthClient.defaultDispatchQueue
    
    public init(clientId: String, clientSecretKey: String, clientRedirectURI: String) {
        self.clientId = clientId
        self.clientRedirectURL = clientRedirectURI
        self.clientSecretKey = clientSecretKey
        
        // TODO: make this accounts endpoint
        self.loginURL = URL(string: AuthClient.getAuthorizeUrl(self.clientRedirectURL, clientId: self.clientId))
    }
    
    public func dispatch(queue: DispatchQueue) {
        self.dispatchQueue = queue
    }
    
    open func loginViewController(_ completion: ((_ authToken: AuthToken) -> Void)?, failure: ((_ response: Any?) -> Void)?) {
        URLCache.shared.removeAllCachedResponses();
        
        self.loginCompletion = completion;
        self.loginFailure = failure
        self.authController = AuthViewController(nibName: "AuthViewController", bundle: nil);
        self.authController?.delegate = self;
        
        self.authController?.loginURL = self.loginURL
        UIApplication.shared.delegate?.window!!.rootViewController = self.authController;
    }
    
    open func authControllerLoadURLRequest(_ request: URLRequest) {
        let url: URL = request.url!;
        let urlComponents: URLComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        var authToken: AuthToken = AuthToken()
        
        if let queryItems = urlComponents.queryItems {
            for queryItem in queryItems {
                if queryItem.name == "access_token" {
                    authToken.accessToken = queryItem.value
                }
                else if queryItem.name == "expires_in" {
                    if queryItem.value != nil {
                        if let expiry: Double = Double(queryItem.value!) {
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
        if ClientEnvironment.SharedInstance.getRegion().rawValue != authToken.uniqueId {
            return false
        }
        
        // Check if the token is expired
        guard let timestamp: Double = authToken.expiryTimestamp() else {
            return false
        }
        
        let currentTime: Double = Date().timeIntervalSince1970
        
        // Check for expiry
        if currentTime > timestamp {
            return false
        }
        
        return true
    }
    
    // Returns on main thread when complete - refreshes if needed
    open func isUserLoggedInRefresh(_ completion: @escaping (_ authToken: AuthToken) -> Void, failure: @escaping (_ response: [String: Any]?) -> Void) {
        
        let authToken = self.getAuthToken()
        
        if authToken.accessToken == nil || authToken.expiry == nil || authToken.uniqueId == nil {
            DispatchQueue.main.async(execute: {failure(nil)})
            return
        }
        
        // Check to see if the environment endpoint in the keychain is the same as the current endpoint
        // If they are different, return false right away
        if ClientEnvironment.SharedInstance.getRegion().rawValue != authToken.uniqueId {
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
                guard let timestamp: Double = authToken.expiryTimestamp() else {
                    failure(nil)
                    return
                }
                
                let currentTime: Double = Date().timeIntervalSince1970
                
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
    open func login(_ username: String, password: String, completion: @escaping (_ authToken: AuthToken) -> Void, failure: @escaping (_ response: [String: Any]?) -> Void) {
        
        // The token endpoint is used for the resource owner flow
        let loginEndpoint = AuthClient.getTokenUrl()
        
        self.requestHeaders.update(["Accept": "application/json", "Authorization": self.generateBasicAuthHeader()])
        
        let request = Alamofire.request(loginEndpoint, method: .post, parameters: ["grant_type": "password", "password": password, "username": username, "client_id": self.clientId, "client_secret": self.clientSecretKey], encoding: URLEncoding(destination: .methodDependent), headers: ["Accept": "application/json", "Authorization": self.generateBasicAuthHeader()]).responseJSON { response in
            
            if response.response?.statusCode == 200 {
                
                guard let responseJSON = response.result.value as? [String: Any] else {
                    failure(nil)
                    return
                }
                
                if let expiry: Double = responseJSON["expires_in"] as? Double {
                    let authToken = AuthToken(accessToken: (responseJSON["access_token"] as? String), expiry: String(Date.init(timeIntervalSinceNow: expiry).timeIntervalSince1970), refreshToken: (responseJSON["refresh_token"] as? String), uniqueId: ClientEnvironment.SharedInstance.getRegion().rawValue)
                    
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
                if let dictionary = response.result.value as? [String: Any] {
                    failure(dictionary)
                }
                    /*else if let error = response.result.error {
                     failure(response: error.userInfo)
                     }*/
                else {
                    failure(nil)
                }
            }
        }
        
        #if DEBUG
            debugPrint(request)
        #endif
    }
    
    open func refreshAuthToken(_ completion: @escaping (_ authToken: AuthToken) -> Void, failure: @escaping (_ response: [String: Any]?) -> Void) {
        let keychain = KeychainSwift()
        
        let authorizeEndpoint = AuthClient.getTokenUrl()
        
        guard let refreshToken: String = keychain.get(KeychainKey.refreshToken.rawValue) else {
            DispatchQueue.main.async(execute: {failure(nil)})
            return
        }
        
        let request = Alamofire.request(authorizeEndpoint,
                                        method: .post,
                                        parameters: ["grant_type": "refresh_token",
                                                     "refresh_token": refreshToken,
                                                     "client_id": self.clientId,
                                                     "client_secret": self.clientSecretKey,
                                                     "redirect_uri": self.clientRedirectURL],
                                        encoding: URLEncoding(destination: .methodDependent))
            .responseJSON { response in
                
                DispatchQueue.main.async(execute: {
                    if response.response?.statusCode == 200 {
                        
                        guard let responseJSON = response.result.value as? [String: Any] else {
                            failure(nil)
                            return
                        }
                        
                        if let expiry: Double = responseJSON["expires_in"] as? Double {
                            let authToken: AuthToken = AuthToken(accessToken: (responseJSON["access_token"] as? String), expiry: String(Date.init(timeIntervalSinceNow: expiry).timeIntervalSince1970), refreshToken: (responseJSON["refresh_token"] as? String), uniqueId: ClientEnvironment.SharedInstance.getRegion().rawValue)
                            
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
                        if let dictionary = response.result.value as? [String: Any] {
                            failure(dictionary)
                        }
                            /*else if let error = response.result.error {
                             failure(error.userInfo)
                             }*/
                        else {
                            failure(nil)
                        }
                    }
                })
        }
        
        #if DEBUG
            debugPrint(request)
        #endif
    }
    
    open func logout() {
        KeychainManager().deleteTokenFromKeychain()
    }
    
    // Register
    open func register(_ mobile: String, email: String, password: String, completion: @escaping (_ authToken: AuthToken) -> Void, failure: @escaping (_ response: [String: Any]?) -> Void) {
        
        let registerEndpoint = ClientEnvironment.SharedInstance.getAccountsEndpoint() + AccountClientEndpoint.register.rawValue
        self.requestHeaders.update(["Authorization": self.generateBasicAuthHeader(), "Content-Type": "application/json", "Accept": "application/json"])
        
        // Step 1: Create an account for the user
        let request = Alamofire.request(registerEndpoint, method: .post, parameters: ["PhoneNumber": mobile, "Email": email, "Password": password, "ConfirmPassword": password], encoding: JSONEncoding.default, headers: self.requestHeaders).responseJSON { response in
            
            if response.response?.statusCode == 200 {
                
                // Step 2: If account creation was successful, log the user in
                self.login(email, password: password, completion: {authToken in
                    
                    completion(authToken)
                    
                }, failure: {response in
                    failure(response)
                })
                
            }
            else {
                if let dictionary = response.result.value as? [String: Any] {
                    failure(dictionary)
                }
                    /*else if let error = response.result.error {
                     failure(error.userInfo)
                     }*/
                else {
                    failure(nil)
                }
            }
        }
        
        #if DEBUG
            debugPrint(request)
        #endif
    }
    
    // Verify Phone
    open func verifyMobilePhone(_ mobile: String, pin: String, completion: @escaping (_ authToken: AuthToken) -> Void, failure: @escaping (_ response: [String: Any]?) -> Void) {
        
        let verifyEndpoint = AuthClient.getTokenUrl()
        
        self.requestHeaders.update(["Accept": "application/json", "Authorization": self.generateBasicAuthHeader()])
        
        let request = Alamofire.request(verifyEndpoint, method: .post, parameters: ["client_id": self.clientId, "client_secret": self.clientSecretKey, "grant_type": "phone", "phone_number": mobile, "pin": pin], encoding: URLEncoding(destination: .methodDependent), headers: ["Accept": "application/json", "Authorization": self.generateBasicAuthHeader()]).responseJSON { response in
            
            if response.response?.statusCode == 200 {
                
                guard let responseJSON = response.result.value as? [String: Any] else {
                    failure(nil)
                    return
                }
                
                if let expiry: Double = responseJSON["expires_in"] as? Double {
                    let authToken: AuthToken = AuthToken(accessToken: (responseJSON["access_token"] as! String), expiry: String(Date.init(timeIntervalSinceNow: expiry).timeIntervalSince1970), refreshToken: (responseJSON["refresh_token"] as! String), uniqueId: ClientEnvironment.SharedInstance.getRegion().rawValue)
                    
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
                if let dictionary = response.result.value as? [String: Any] {
                    failure(dictionary)
                }
                    /*else if let error = response.result.error {
                     failure(error.userInfo)
                     }*/
                else {
                    failure(nil)
                }
            }
        }
        
        #if DEBUG
            debugPrint(request)
        #endif
    }
    
    // Resend Verification Pin
    open func resendPhonePin(_ mobile: String, completion: (() -> Void)?, failure: (() -> Void)?) {
        
        let verifyEndpoint = ClientEnvironment.SharedInstance.getAccountsEndpoint() + AccountClientEndpoint.resendPin.rawValue
        
        self.requestHeaders.update(["Accept": "application/json", "Authorization": self.generateBasicAuthHeader()])
        
        let request = Alamofire.request(verifyEndpoint, method: .post, parameters: ["PhoneNumber": mobile, "grant_type": "phone"], encoding: JSONEncoding.default, headers: ["Accept": "application/json", "Authorization": self.generateBasicAuthHeader()]).responseJSON { response in
            
            if response.response?.statusCode == 200 {
                completion?()
            }
            else {
                failure?()
            }
        }
        
        #if DEBUG
            debugPrint(request)
        #endif
    }
    
    // Forgot/Reset Password
    open func forgotPassword(_ emailOrPhoneNumber: String, completion: @escaping (_ response: [String: Any]?) -> Void, failure: @escaping (_ response: [String: Any]?) -> Void) {
        
        let forgotEndpoint = ClientEnvironment.SharedInstance.getAccountsEndpoint() + AccountClientEndpoint.forgot.rawValue
        
        self.requestHeaders.update(["Accept": "application/json", "Authorization": self.generateBasicAuthHeader()])
        
        let request = Alamofire.request(forgotEndpoint,
                                        method: .post,
                                        parameters: ["UserNameEmailOrPhone": emailOrPhoneNumber],
                                        encoding: JSONEncoding.default,
                                        headers: ["Accept": "application/json", "Authorization": self.generateBasicAuthHeader()])
            .responseJSON { response in
                
                if response.response?.statusCode == 200 {
                    completion(response.result.value as? [String: Any])
                } else {
                    if let dictionary = response.result.value as? [String: Any] {
                        failure(dictionary)
                    }
                        /*else if let error = response.result.error {
                         failure(error.userInfo)
                         }*/
                    else {
                        failure(nil)
                    }
                }
        }
        
        #if DEBUG
            debugPrint(request)
        #endif
    }
    
    open func resetPassword(_ resetToken: String, password: String, completion: @escaping (_ response: [String: Any]?) -> Void, failure: @escaping (_ response: [String: Any]?) -> Void) {
        
        let resetEndpoint = ClientEnvironment.SharedInstance.getAccountsEndpoint() + AccountClientEndpoint.reset.rawValue
        
        self.requestHeaders.update(["Accept": "application/json", "Authorization": self.generateBasicAuthHeader()])
        
        let request = Alamofire.request(resetEndpoint,
                                        method: .post,
                                        parameters: ["ResetToken": resetToken, "Password": password, "ConfirmPassword": password],
                                        encoding: JSONEncoding.default,
                                        headers: ["Accept": "application/json", "Authorization": self.generateBasicAuthHeader()])
            .responseJSON { response in
                
                if response.response?.statusCode == 200 {
                    completion(response.result.value as? [String: Any])
                }
                else {
                    if let dictionary = response.result.value as? [String: Any] {
                        failure(dictionary)
                    }
                        /*else if let error = response.result.error {
                         failure(error.userInfo)
                         }*/
                    else {
                        failure(nil)
                    }
                }
        }
        
        #if DEBUG
            debugPrint(request)
        #endif
    }
    
    open func getAuthToken() -> AuthToken {
        return KeychainManager().getAuthToken()
    }
    
    open func saveAuthToken(_ authToken: AuthToken) -> Void {
        KeychainManager().saveAuthToken(authToken)
    }
    
    open static func getTokenUrl() -> String {
        return ClientEnvironment.SharedInstance.getAccountsEndpoint() + AuthClientEndpoint.token.rawValue
    }
    
    open static func getTokenUrl(_ redirectUri: String, clientId: String) -> String {
        return String(
            format: "%@%@?response_type=token&redirect_uri=%@&client_id=%@&scope=full",
            ClientEnvironment.SharedInstance.getAccountsEndpoint(),
            AuthClientEndpoint.token.rawValue,
            redirectUri.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!,
            clientId.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)
    }
    
    open static func getAuthorizeUrl() -> String {
        return ClientEnvironment.SharedInstance.getAccountsEndpoint() + AuthClientEndpoint.authorize.rawValue
    }
    
    open static func getAuthorizeUrl(_ redirectUri: String, clientId: String) -> String {
        return String(
            format: "%@%@?response_type=token&redirect_uri=%@&client_id=%@&scope=full",
            ClientEnvironment.SharedInstance.getAccountsEndpoint(),
            AuthClientEndpoint.authorize.rawValue,
            redirectUri.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!,
            clientId.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)
    }
}
