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

public class AuthClientEndpoints : NSObject {
    public static let Authorize : String = "oauth2/authorize"
    public static let Token : String = "oauth2/token"
    public static let Next : String = "oauth2/next/"
}

public class AuthClient: NSObject, AuthControllerDelegate {

    public var clientId : String
    public var clientRedirectURL : String
    public var clientSecretKey : String
    public var loginURL : NSURL!
    public var loginCompletion : (Void) -> (Void)
    public var authController : AuthViewController?
        
    public init(clientId : String, clientSecretKey : String, clientRedirectURI : String) {
        self.clientId = clientId
        self.clientRedirectURL = clientRedirectURI
        self.clientSecretKey = clientSecretKey
        
        // TODO: make this accounts endpoint
        self.loginURL = NSURL(string: AuthClient.getAuthorizeUrl(self.clientRedirectURL, clientId: self.clientId))
        self.loginCompletion = {};
    }
    
    
    public func login(completion : () -> Void) {
        NSURLCache.sharedURLCache().removeAllCachedResponses();
        
        self.loginCompletion = completion;
        self.authController = AuthViewController(nibName : "AuthViewController", bundle: nil);
        self.authController?.delegate = self;
        
        self.authController?.loginURL = self.loginURL
        UIApplication.sharedApplication().delegate?.window!!.rootViewController = self.authController;
    }
    
    public func authControllerLoadURLRequest(request: NSURLRequest) {
        let url : NSURL = request.URL!;
        
        let urlComponents : NSURLComponents = NSURLComponents(URL: url, resolvingAgainstBaseURL: false)!
        let urlFragment : String? = urlComponents.fragment
        
        if urlFragment != nil {

            let dict : NSMutableDictionary = NSMutableDictionary()
            
            let pathComponents : [String] = urlFragment!.componentsSeparatedByString("&")
            var accessToken : String
            var expiresIn : NSString

            for component in pathComponents {
                if component.containsString("access_token") {
                    dict.setObject((component.componentsSeparatedByString("="))[1] as String, forKey: "access_token")
                }
                if component.containsString("expires_in") {
                    dict.setObject((component.componentsSeparatedByString("="))[1], forKey: "expires_in")
                }
            }
            
            accessToken = dict.objectForKey("access_token") as! String
            expiresIn = dict.objectForKey("expires_in") as! String
            
            self.saveAuthenticationToken(accessToken, refreshToken: "", expiresIn: expiresIn.doubleValue, environmentEndpoint: ClientEnvironment.SharedInstance.getApiEndpoint())
            
            self.authController?.dismissViewControllerAnimated(true, completion: nil);
            self.loginCompletion();

        }
    }
    
    public func isUserLoggedIn() -> Bool {
        
        let authTokens = self.getAuthTokens()
        let authToken : String? = authTokens.authToken
        let expiryDate : NSString? = authTokens.expiryDate
        let environmentEndpoint : String? = authTokens.endpoint
        
        if authToken == nil || expiryDate == nil || environmentEndpoint == nil {
            return false;
        }
        
        // Check to see if the environment endpoint in the keychain is the same as the current endpoint
        // If they are different, return false right away
        if ClientEnvironment.SharedInstance.getApiEndpoint() != environmentEndpoint {
            return false
        }
        
        // Check if the token is expired
        let expiresAt : Double = (expiryDate?.doubleValue)!
        let currentTimeInMS : Double = NSDate().timeIntervalSince1970
        
        if currentTimeInMS < expiresAt {
            
            // refresh the app's authentication token on a background thread to reduce the number of occassions when the user gets automatically logged out
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
                self.refreshAuthToken(nil)
            })
            return true
        }
        else { // the auth token may have expired, but the refresh token may still be valid
            
        }
        
        return false;
    }
    
    private func refreshAuthToken(completion : (() -> ())?) {
        let keychain = KeychainSwift()
        
        let authorizeEndpoint = AuthClient.getAuthorizeUrl()
        let refreshToken = keychain.get(KeychainKeys.RefreshToken)
        
        // TODO: check for expiry of refresh token as well
        if refreshToken == nil {
            return
        }
        
        Alamofire.request(.POST, authorizeEndpoint, parameters: [:], encoding: .Custom({
            (convertible, params) in
            let mutableRequest = convertible.URLRequest.copy() as! NSMutableURLRequest
            let postRequest : NSString = NSString(format: "grant_type=refresh_token&refresh_token=%@&client_id=%@&client_secret=%@&redirect_uri=%@", refreshToken!, self.clientId.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!, self.clientSecretKey.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!, self.clientRedirectURL.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!)
            mutableRequest.HTTPBody = postRequest.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
            return (mutableRequest, nil)
        })).responseJSON{ response in
            let json : JSON = JSON(response.result.value ?? [])
            if json != nil {
                let token : String = json["access_token"].string!
                let exp : Double = json["expires_in"].double!
                let refreshToken : String = json["refresh_token"].string!
                
                dispatch_async(dispatch_get_main_queue(), {
                    KeychainManager().saveAuthenticationToken(token, refreshToken: refreshToken, expiresIn: exp, environmentEndpoint: ClientEnvironment.SharedInstance.getApiEndpoint())
                })
            }
        }
    }
    
    public func logout() {
        KeychainManager().deleteTokenFromKeychain()
    }
    
    public func getAuthTokens() -> AuthTokens {
        return KeychainManager().getAuthTokens()
    }
    
    public func saveAuthenticationToken(token : String, refreshToken : String, expiresIn : Double, environmentEndpoint : String) -> Void {
        KeychainManager().saveAuthenticationToken(token, refreshToken: refreshToken, expiresIn: expiresIn, environmentEndpoint: environmentEndpoint)
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
