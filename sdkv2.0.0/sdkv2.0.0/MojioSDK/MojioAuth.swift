//
//  MojioAuth.swift
//  MOJIOSDK
//
//  Created by Ashish Agarwal on 2016-02-05.
//  Copyright © 2016 Ashish. All rights reserved.
//

import UIKit
import KeychainSwift
import Alamofire
import SwiftyJSON

enum MojioAuthEndpoints : String {
    case Authorize = "oauth2/authorize"
    case Token = "oauth2/token"
    case Next = "oauth2/next/"
}

class MojioAuth: NSObject, AuthControllerDelegate {

    var clientId : String
    var clientRedirectURL : String
    var clientSecretKey : String
    var loginURL : NSURL!
    var loginCompletion : (Void) -> (Void)
    var authController : AuthViewController?
        
    init(clientId : String, clientSecretKey : String, clientRedirectURI : String) {
        self.clientId = clientId
        self.clientRedirectURL = clientRedirectURI
        self.clientSecretKey = clientSecretKey
        
        // TODO: make this accounts endpoint
        self.loginURL = NSURL(string: MojioAuth.getAuthorizeUrl(self.clientRedirectURL, clientId: self.clientId))
        self.loginCompletion = {};
    }
    
    
    func login (completion : () -> Void) {
        NSURLCache.sharedURLCache().removeAllCachedResponses();
        
        self.loginCompletion = completion;
        self.authController = AuthViewController(nibName : "AuthViewController", bundle: nil);
        self.authController?.delegate = self;
        
        self.authController?.loginURL = self.loginURL
        UIApplication.sharedApplication().delegate?.window!!.rootViewController = self.authController;
    }
    
    func mojioAuthControllerLoadURLRequest(request: NSURLRequest) {
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
            
            self.saveAuthenticationToken(accessToken, refreshToken: "", expiresIn: expiresIn.doubleValue, environmentEndpoint: MojioClientEnvironment.sharedInstance.getApiEndpoint())
            
            self.authController?.dismissViewControllerAnimated(true, completion: nil);
            self.loginCompletion();

        }
    }
    
    func isUserLoggedIn () -> Bool {
        
        let token = self.getAuthToken()
        let authToken : String? = token.0
        let expiryDate : NSString? = token.2
        let environmentEndpoint : String? = token.3
        
        if authToken == nil || expiryDate == nil || environmentEndpoint == nil {
            return false;
        }
        
        // Check to see if the environment endpoint in the keychain is the same as the current endpoint
        // If they are different, return false right away
        if MojioClientEnvironment.sharedInstance.getApiEndpoint() != environmentEndpoint {
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
    
    private func refreshAuthToken (completion : (() -> ())?) {
        let keychain = KeychainSwift()
        
        let authorizeEndpoint = MojioAuth.getAuthorizeUrl()
        let refreshToken = keychain.get(MojioKeychain.REFRESH_TOKEN.rawValue)
        
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
                    MojioKeychainManager().saveAuthenticationToken(token, refreshToken: refreshToken, expiresIn: exp, environmentEndpoint: MojioClientEnvironment.sharedInstance.getApiEndpoint())
                })
            }
        }
    }
    
    func logout() {
        MojioKeychainManager().deleteTokenFromKeychain()
    }
    
    func getAuthToken () -> (String?, String?, NSString?, String?) {
        return MojioKeychainManager().getAuthToken()
    }
    
    func saveAuthenticationToken (token : String, refreshToken : String, expiresIn : Double, environmentEndpoint : String) -> Void {
        MojioKeychainManager().saveAuthenticationToken(token, refreshToken: refreshToken, expiresIn: expiresIn, environmentEndpoint: environmentEndpoint)
    }
    
    static func getTokenUrl() -> String {
        return MojioClientEnvironment.sharedInstance.getAccountsEndpoint() + MojioAuthEndpoints.Token.rawValue
    }
    
    static func getTokenUrl(redirectUri : String, clientId : String) -> String {
        return String(format: "%@%@?response_type=token&redirect_uri=%@&client_id=%@&scope=full", MojioClientEnvironment.sharedInstance.getAccountsEndpoint(), MojioAuthEndpoints.Token.rawValue, redirectUri.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!, clientId.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!)
    }
    
    static func getAuthorizeUrl() -> String {
        return MojioClientEnvironment.sharedInstance.getAccountsEndpoint() + MojioAuthEndpoints.Authorize.rawValue
    }
    
    static func getAuthorizeUrl (redirectUri : String, clientId : String) -> String {
        return String(format: "%@%@?response_type=token&redirect_uri=%@&client_id=%@&scope=full", MojioClientEnvironment.sharedInstance.getAccountsEndpoint(), MojioAuthEndpoints.Authorize.rawValue, redirectUri.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!, clientId.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!)
    }
}
