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
import MojioCore

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
    case sendVerifictionPhone = "devices"
    case devicesVerify = "devices/verify"
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
    
    open var defaultHeaders: HTTPHeaders {
        var headers = ClientHeaders().defaultRequestHeaders
        headers.update(.accept("application/json"))
        headers.update(.contentType("application/json"))
        return headers
    }
    
    // Default to global concurrent queue with default priority
    public static var defaultDispatchQueue = DispatchQueue.global()
    fileprivate var dispatchQueue = AuthClient.defaultDispatchQueue
    
    fileprivate var clientEnvironment: ClientEnvironment
    internal let sessionManager: Session
    
    private var keychainManager: KeychainManager
    
    public init(clientEnvironment: ClientEnvironment, clientId: String, clientSecretKey: String, clientRedirectURI: String, sessionManager: Session = Session.default, keychainManager: KeychainManager = KeychainManager.sharedInstance) {
        self.clientEnvironment = clientEnvironment
        self.sessionManager = sessionManager
        
        self.clientId = clientId
        self.clientRedirectURL = clientRedirectURI
        self.clientSecretKey = clientSecretKey
        self.keychainManager = keychainManager
        
        // TODO: make this accounts endpoint
        self.loginURL = URL(string: self.getAuthorizeUrl(self.clientRedirectURL, clientId: self.clientId))
    }
    
    open func dispatch(queue: DispatchQueue) {
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
        var authToken = AuthToken()
        
        if let queryItems = urlComponents.queryItems {
            for queryItem in queryItems {
                if let value = queryItem.value, queryItem.name == "access_token" {
                    authToken.accessToken = value
                }
                else if queryItem.name == "expires_in" {
                    if queryItem.value != nil {
                        if let expiry: Double = Double(queryItem.value!) {
                            authToken.expiry = Date(timeIntervalSinceNow: expiry)
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
        guard let authToken = self.authToken, authToken.isValid else {
            return false
        }
        
        // Check to see if the environment endpoint in the keychain is the same as the current endpoint
        if self.clientEnvironment.getRegion().regionType.rawValue != authToken.uniqueId {
            return false
        }
        
        return true
    }
    
    // Returns on main thread when complete - refreshes if needed
    open func isUserLoggedInRefresh(_ completion: @escaping (_ authToken: AuthToken) -> Void, failure: @escaping (_ response: [String: Any]?) -> Void) {
        
        guard let authToken = self.authToken else {
            failure(nil)
            return
        }
        
        // Check to see if the environment endpoint in the keychain is the same as the current endpoint
        // If they are different, return false right away
        if self.clientEnvironment.getRegion().regionType.rawValue != authToken.uniqueId {
            failure(nil)
            return
        }
        
        let currentTime = Date().timeIntervalSince1970
        let hourInterval : Double = 60 * 60
        let almostOrAlreadyExpired = currentTime > (authToken.expiryTimestamp - hourInterval)
        
        // Attempt to refresh when almost (1 hour left) or already expired
        if let _ = authToken.refreshToken, almostOrAlreadyExpired {
            self.refreshAuthToken(completion, failure: failure)
        }
        else if !almostOrAlreadyExpired {
            completion(authToken)
        }
        else {
            failure(nil)
        }
    }
    
    open func generateBasicAuthHeader() -> String {
        let authString = (self.clientId + ":" + self.clientSecretKey).data(using: String.Encoding.utf8, allowLossyConversion: false)!
        let base64AuthString = authString.base64EncodedString(options: NSData.Base64EncodingOptions.lineLength76Characters).replacingOccurrences(of: "\r\n", with: "")
        return "Basic " + base64AuthString
    }
    
    // Login
    open func login(_ username: String, password: String, debug: ((_ request: Request?, _ response: AFDataResponse<Any>?) -> Void)? = nil, completion: @escaping (_ authToken: AuthToken) -> Void, failure: @escaping (_ response: [String: Any]?) -> Void) {
        
        // The token endpoint is used for the resource owner flow
        let loginEndpoint = self.tokenUrl
        
        var headers = self.defaultHeaders
        headers.update(.authorization(self.generateBasicAuthHeader()))

        let parameters = [
            "grant_type": "password",
            "password": password,
            "username": username,
            "client_id": self.clientId,
            "client_secret": self.clientSecretKey,
            "scope": "full offline_access"
        ]

        let request = self.sessionManager
            .request(loginEndpoint, method: .post, parameters: parameters, encoding: URLEncoding(destination: .methodDependent), headers: headers)
            
        request
            .responseJSON(queue: self.dispatchQueue, options: .allowFragments) { response in
                debug?(request, response) // PHIOS-5207: post request notification for any loggers
                self.postLogin(response: response, completion: completion, failure: failure)
            }
        print(request)
    }
    
    // Login
    open func login(_ token: String, firstName: String? = nil, lastName: String? = nil, email: String? = nil, customParameters: [String: Any]? = nil, debug: ((_ request: Request?, _ response: AFDataResponse<Any>?) -> Void)? = nil, completion: @escaping (_ authToken: AuthToken) -> Void, failure: @escaping (_ response: [String: Any]?) -> Void) {
        
        // The token endpoint is used for the resource owner flow
        let loginEndpoint = self.tokenUrl
        
        var headers = self.defaultHeaders
        headers.update(.authorization(self.generateBasicAuthHeader()))

        var parameters: Parameters = [:]
        if let extraParams = customParameters {
            extraParams.forEach { parameters.updateValue($1, forKey: $0) }
        }
        parameters["token"] = token
        parameters["client_id"] = self.clientId
        parameters["client_secret"] = self.clientSecretKey
        
        if let first = firstName {
            parameters["first_name"] = first
        }
        if let last = lastName {
            parameters["last_name"] = last
        }
        if let eml = email {
            parameters["email"] = eml
        }
        
        let request = self.sessionManager
            .request(loginEndpoint, method: .post, parameters: parameters, encoding: URLEncoding(destination: .methodDependent), headers: headers)
            
        request
            .responseJSON(queue: self.dispatchQueue, options: .allowFragments) { response in
                debug?(request, response) // PHIOS-5207: post request notification for any loggers
                self.postLogin(response: response, completion: completion, failure: failure)
            }
        
        print(request)
    }
    
    fileprivate func postLogin(response: AFDataResponse<Any>, completion: @escaping (_ authToken: AuthToken) -> Void, failure: @escaping (_ response: [String: Any]?) -> Void) {
        
        if response.response?.statusCode == 200 {
            
            guard
                case .success(let value) = response.result,
                let responseJSON = value as? [String: AnyObject],
                let expiry: Double = responseJSON["expires_in"] as? Double,
                let accessToken = responseJSON["access_token"] as? String else {
                    
                    failure(Errors.wrongResponseFormat)
                    return
            }
            
            let authToken = AuthToken(
                accessToken: accessToken,
                expiry: Date(timeIntervalSinceNow: expiry),
                refreshToken: (responseJSON["refresh_token"] as? String),
                uniqueId: self.clientEnvironment.getRegion().regionType.rawValue)
            
            if authToken.isValid {
                self.authToken = authToken
                completion(authToken)
            }
            else {
                failure(nil)
            }
        }
        else {
            if case .success(let value) = response.result, let dictionary = value as? [String: Any] {
                failure(dictionary)
            }
            else if case .failure(let error) = response.result, let responseError = error as NSError? {
                failure(responseError.userInfo)
            }
            else {
                failure(nil)
            }
        }
    }
    
    open func refreshAuthToken(with deviceToken: String, debug: ((_ request: Request?, _ response: AFDataResponse<Any>?) -> Void)? = nil, _ completion: @escaping (_ authToken: AuthToken) -> Void, failure: @escaping (_ response: [String: Any]?) -> Void) {
        let parameters = ["device": deviceToken]
        
        self.refreshAuthToken(additionalParameters: parameters, debug: debug, completion, failure: failure)
    }
    
    open func refreshAuthToken(additionalParameters: [String: Any] = [:], debug: ((_ request: Request?, _ response: AFDataResponse<Any>?) -> Void)? = nil, _ completion: @escaping (_ authToken: AuthToken) -> Void, failure: @escaping (_ response: [String: Any]?) -> Void) {
        let authorizeEndpoint = self.tokenUrl
        
        guard let refreshToken = self.keychainManager.authToken?.refreshToken else {
            failure(nil)
            return
        }
        
        var parameters: [String: Any] = [
            "grant_type": "refresh_token",
            "refresh_token": refreshToken,
            "client_id": self.clientId,
            "client_secret": self.clientSecretKey,
            "redirect_uri": self.clientRedirectURL]
        
        additionalParameters.forEach { parameters[$0] = $1 }
        
        let request = self.sessionManager
            .request(authorizeEndpoint, method: .post, parameters: parameters, encoding: URLEncoding(destination: .methodDependent))
            
        request
            .responseJSON(queue: self.dispatchQueue, options: .allowFragments) { response in
                debug?(request, response) // PHIOS-5207: post request notification for any loggers
                if response.response?.statusCode == 200 {
                    guard
                        case .success(let value) = response.result,
                        let responseJSON = value as? [String: AnyObject],
                        let expiry: Double = responseJSON["expires_in"] as? Double,
                        let accessToken = responseJSON["access_token"] as? String else {
                            
                        failure(Errors.wrongResponseFormat)
                        return
                    }
                    
                    let authToken = AuthToken(
                        accessToken: accessToken,
                        expiry: Date(timeIntervalSinceNow: expiry),
                        refreshToken: (responseJSON["refresh_token"] as? String),
                        uniqueId: self.clientEnvironment.getRegion().regionType.rawValue)
                    
                    if authToken.isValid {
                        completion(authToken)
                    }
                    else {
                        failure(nil)
                    }
                }
                else {
                    if case .success(let value) = response.result, let responseDict = value as? [String : Any] {
                        failure(responseDict)
                    }
                    else if case .failure(let error) = response.result, let responseError = error as NSError? {
                        failure(responseError.userInfo)
                    }
                    else {
                        return failure(nil)
                    }
                }
            }
        
        print(request)
    }
     
    open func logout() {
        KeychainManager.sharedInstance.authToken = nil
    }
    
    // Register
    open func register(_ mobile: String, email: String, password: String, debug: ((_ request: Request?, _ response: AFDataResponse<Any>?) -> Void)? = nil, completion: @escaping (_ authToken: AuthToken) -> Void, failure: @escaping (_ response: [String: Any]?) -> Void) {
        
        let registerEndpoint = self.clientEnvironment.getIdentityEndpoint() + AccountClientEndpoint.register.rawValue
        
        var headers = self.defaultHeaders
        headers.update(.authorization(self.generateBasicAuthHeader()))

        var param = ["Email": email, "Password": password, "ConfirmPassword": password]
        
        if mobile != "" {
            param["PhoneNumber"] = mobile
        }
        
        // Step 1: Create an account for the user
        let request = self.sessionManager
            .request(registerEndpoint, method: .post, parameters: param, encoding: JSONEncoding.default, headers: headers)
        request
            .responseJSON(queue: self.dispatchQueue, options: .allowFragments) { response in
                debug?(request, response) // PHIOS-5207: post request notification for any loggers
                if response.response?.statusCode == 200 {
                    
                    // Step 2: If account creation was successful, log the user in
                    self.login(
                        email,
                        password: password,
                        completion: { completion($0) },
                        failure: { failure($0) }
                    )
                }
                else {
                    if case .success(let value) = response.result, let responseDict = value as? [String : Any] {
                        failure(responseDict)
                    }
                    else if case .failure(let error) = response.result, let responseError = error as NSError? {
                        failure(responseError.userInfo)
                    }
                    else {
                        return failure(nil)
                    }
                }
            }
        
        print(request)
    }
    
    // Verify Phone
    open func verifyMobilePhone(_ mobile: String, pin: String, debug: ((_ request: Request?, _ response: AFDataResponse<Any>?) -> Void)? = nil, completion: @escaping (_ authToken: AuthToken) -> Void, failure: @escaping (_ response: [String: Any]?) -> Void) {
        
        let verifyEndpoint = self.tokenUrl
        
        var headers = self.defaultHeaders
        headers.update(.authorization(self.generateBasicAuthHeader()))

        let parameters = ["client_id": self.clientId, "client_secret": self.clientSecretKey, "grant_type": "phone", "phone_number": mobile, "pin": pin]
        
        let request = self.sessionManager
            .request(verifyEndpoint, method: .post, parameters: parameters, encoding: URLEncoding(destination: .methodDependent), headers: headers)
        request
            .responseJSON(queue: self.dispatchQueue, options: .allowFragments) { response in
                debug?(request, response) // PHIOS-5207: post request notification for any loggers
                if response.response?.statusCode == 200 {
                    guard
                        case .success(let value) = response.result,
                        let responseJSON = value as? [String: AnyObject],
                        let expiry: Double = responseJSON["expires_in"] as? Double,
                        let accessToken = responseJSON["access_token"] as? String else {
                            
                        failure(Errors.wrongResponseFormat)
                        return
                    }
                    
                    let authToken = AuthToken(
                        accessToken: accessToken,
                        expiry: Date(timeIntervalSinceNow: expiry),
                        refreshToken: (responseJSON["refresh_token"] as? String),
                        uniqueId: self.clientEnvironment.getRegion().regionType.rawValue)
                    
                    if authToken.isValid {
                        completion(authToken)
                    }
                    else {
                        failure(nil)
                    }
                }
                else {
                    if case .success(let value) = response.result, let dictionary = value as? [String: Any] {
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
        
        print(request)
    }
    
    // Resend Verification Pin
    open func resendPhonePin(_ mobile: String, debug: ((_ request: Request?, _ response: AFDataResponse<Any>?) -> Void)? = nil, completion: (() -> Void)?, failure: (() -> Void)?) {
        
        let verifyEndpoint = self.clientEnvironment.getIdentityEndpoint() + AccountClientEndpoint.resendPin.rawValue
        
        var headers = self.defaultHeaders
        headers.update(.authorization(self.generateBasicAuthHeader()))

        let parameters = ["PhoneNumber": mobile, "grant_type": "phone"]
        
        let request = self.sessionManager
            .request(verifyEndpoint, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
        request
            .responseJSON(queue: self.dispatchQueue, options: .allowFragments) {response in
                debug?(request, response) // PHIOS-5207: post request notification for any loggers
                if response.response?.statusCode == 200 {
                    completion?()
                }
                else {
                    failure?()
                }
            }
        
        print(request)
    }
    
    // Forgot/Reset Password
    open func forgotPassword(_ emailOrPhoneNumber: String, debug: ((_ request: Request?, _ response: AFDataResponse<Any>?) -> Void)? = nil, completion: @escaping (_ response: [String: Any]?) -> Void, failure: @escaping (_ response: [String: Any]?) -> Void) {
        
        let forgotEndpoint = self.clientEnvironment.getIdentityEndpoint() + AccountClientEndpoint.forgot.rawValue
        
        var headers = self.defaultHeaders
        headers.update(.authorization(self.generateBasicAuthHeader()))

        let parameters = ["UserNameEmailOrPhone": emailOrPhoneNumber]
        
        let request = self.sessionManager
            .request(forgotEndpoint, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
        request
            .responseJSON(queue: self.dispatchQueue, options: .allowFragments) { response in
                debug?(request, response) // PHIOS-5207: post request notification for any loggers
                if response.response?.statusCode == 200 {
                    completion((try? response.result.get()) as? [String: Any])
                }
                else {
                    failure((try? response.result.get()) as? [String: Any])
                }
            }
        
        print(request)
    }
    
    open func resetPassword(_ resetToken: String, password: String, debug: ((_ request: Request?, _ response: AFDataResponse<Any>?) -> Void)? = nil, completion: @escaping (_ response: [String: Any]?) -> Void, failure: @escaping (_ response: [String: Any]?) -> Void) {
        
        let resetEndpoint = self.clientEnvironment.getIdentityEndpoint() + AccountClientEndpoint.reset.rawValue
        
        var headers = self.defaultHeaders
        headers.update(.authorization(self.generateBasicAuthHeader()))

        let parameters = ["ResetToken": resetToken, "Password": password, "ConfirmPassword": password]
        
        let request = self.sessionManager
            .request(resetEndpoint, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
        request
            .responseJSON(queue: self.dispatchQueue, options: .allowFragments) { response in
                debug?(request, response) // PHIOS-5207: post request notification for any loggers
                if response.response?.statusCode == 200 {
                    completion((try? response.result.get()) as? [String: Any])
                }
                else {
                    failure((try? response.result.get()) as? [String: Any])
                }
            }
        
        print(request)
    }
    
    open var authToken: AuthToken? {
        get {
            return self.keychainManager.authToken
        }
        set {
            self.keychainManager.authToken = newValue
        }
    }
    
    open var tokenUrl: String {
        return self.clientEnvironment.getIdentityEndpoint() + AuthClientEndpoint.token.rawValue
    }
    
    open func getTokenUrl(_ redirectUri: String, clientId: String) -> String {
        return String(
            format: "%@%@?response_type=token&redirect_uri=%@&client_id=%@&scope=full",
            self.clientEnvironment.getIdentityEndpoint(),
            AuthClientEndpoint.token.rawValue,
            redirectUri.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!,
            clientId.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)
    }
    
    open var authorizeUrl: String {
        return self.clientEnvironment.getIdentityEndpoint() + AuthClientEndpoint.authorize.rawValue
    }
    
    open func getAuthorizeUrl(_ redirectUri: String, clientId: String) -> String {
        return String(
            format: "%@%@?response_type=token&redirect_uri=%@&client_id=%@&scope=full",
            self.clientEnvironment.getIdentityEndpoint(),
            AuthClientEndpoint.authorize.rawValue,
            redirectUri.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!,
            clientId.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)
    }
    
    struct Errors {
        static var wrongResponseFormat: [String: Any] {
            return ["Error": "WrongResponseFormat"];
        }
        static var invalidAuthToken: [String: Any] {
            return ["Error": "InvalidAuthToken"];
        }
        static var expiryFieldIsMissing: [String: Any] {
            return ["Error": "ExpiryFieldIsMissing"];
        }
    }
}

extension AuthClient {
    public func deleteUserToken(with userName: String, password: String, debug: ((_ request: Request?, _ response: AFDataResponse<Any>?) -> Void)? = nil, completion: @escaping (AuthToken) -> Void, failure: @escaping (_ response: [String: Any]?) -> Void)  {
        
        let endPoint = self.clientEnvironment.getIdentityEndpoint() + AuthClientEndpoint.token.rawValue
        
        let parameters = [
            "username": userName,
            "password": password,
            "client_id": self.clientId,
            "client_secret": self.clientSecretKey,
            "scope": "full restricted,delete:user",
            "grant_type": "password"
        ]
        
        var headers = self.defaultHeaders
        if let accessToken = self.authToken?.accessToken {
            headers.update(.authorization(bearerToken: accessToken))
        }

        self.sessionManager
            .request(endPoint, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: headers)
        request
            .responseJSON(queue: self.dispatchQueue, options: .allowFragments) { response in
                debug?(request, response) // PHIOS-5207: post request notification for any loggers
                if response.response?.statusCode == 200 {
                    if case .success(let value) = response.result, let dict = value as? [String: Any],
                        let expiry: Double = dict["expires_in"] as? Double {
                        let authToken = AuthToken(
                            accessToken: (dict["access_token"] as? String) ?? String.empty,
                            expiry: Date.init(timeIntervalSinceNow: expiry),
                            refreshToken: String(Date.init(timeIntervalSinceNow: expiry).timeIntervalSince1970),
                            uniqueId: self.clientEnvironment.getRegion().regionType.rawValue)
                        
                        if authToken.isValid {
                            completion(authToken)
                        }
                        else {
                            failure(nil)
                        }
                    }
                }
                else if case .success(let value) = response.result, let responseDict = value as? [String : Any] {
                    failure(responseDict)
                }
                else if case .failure(let error) = response.result, let responseError = error as NSError? {
                    failure(responseError.userInfo)
                }
                else {
                    return failure(nil)
                }
        }
    }
}

extension AuthClient {
    public func sendVerificationCode(to phoneNumber: String, debug: ((_ request: Request?, _ response: AFDataResponse<Any>?) -> Void)? = nil, completion: (() -> Void)?, failure: @escaping (_ response: [String: Any]?) -> Void) {
        
        let verifyEndpoint = self.clientEnvironment.getIdentityEndpoint() + AccountClientEndpoint.sendVerifictionPhone.rawValue + "?phone=\(phoneNumber)"
        
        var headers = self.defaultHeaders
        if let accessToken = self.authToken?.accessToken {
            headers.update(.authorization(bearerToken: accessToken))
        }
        
        let request = self.sessionManager
            .request(verifyEndpoint, method: .post, headers: headers)
        request
            .responseJSON(queue: self.dispatchQueue, options: .allowFragments) { response in
                debug?(request, response) // PHIOS-5207: post request notification for any loggers
                if response.response?.statusCode == 200 {
                    completion?()
                }
                else if case .success(let value) = response.result, let responseDict = value as? [String : Any] {
                    failure(responseDict)
                }
                else if case .failure(let error) = response.result, let responseError = error as NSError? {
                    failure(responseError.userInfo)
                }
                else {
                    return failure(nil)
                }
            }
        
        print(request)
    }
    
    public func deviceVerify(with pin: String, phoneNumber: String, deviceToken: String, debug: ((_ request: Request?, _ response: AFDataResponse<Any>?) -> Void)? = nil, completion: (() -> Void)?,  failure: @escaping (_ response: [String: Any]?) -> Void) {
        
        let endPoint =  self.clientEnvironment.getIdentityEndpoint() + AccountClientEndpoint.devicesVerify.rawValue
        
        var headers = self.defaultHeaders
        if let accessToken = self.authToken?.accessToken {
            headers.update(.authorization(bearerToken: accessToken))
        }
        
        let parameters = [
            "pin" : pin,
            "phoneNumber": phoneNumber,
            "deviceToken": deviceToken
        ]
        
        let request = self.sessionManager
            .request(endPoint, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
        request
            .responseJSON(queue: self.dispatchQueue, options: .allowFragments) { response in
                debug?(request, response) // PHIOS-5207: post request notification for any loggers
                if response.response?.statusCode == 200 {
                    completion?()
                }
                else if case .success(let value) = response.result, let responseDict = value as? [String : Any] {
                    failure(responseDict)
                }
                else if case .failure(let error) = response.result, let responseError = error as NSError? {
                    failure(responseError.userInfo)
                }
                else {
                    return failure(nil)
                }
            }
        
        print(request)
    }
}
