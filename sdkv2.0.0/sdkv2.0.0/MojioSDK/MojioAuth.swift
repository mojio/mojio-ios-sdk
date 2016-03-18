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

class MojioAuth: NSObject, AuthControllerDelegate {
    
    var appId : String
    var redirectURL : String
    var secretKey : String
    var loginURL : NSURL!
    var loginCompletion : (Void) -> (Void)
    var authController : AuthViewController?
        
    init(appId : String, secretKey : String, redirectURI : String) {
        self.appId = appId
        self.redirectURL = redirectURI
        self.secretKey = secretKey
        
        let accountsEndpoint = MojioClientEnvironment.clientEnvironment.getAccountsEndpoint()
        
        //TODO: make this accounts endpoint
        let loginString = String (format: "%@?response_type=token&redirect_uri=%@&client_id=%@&scope=full", accountsEndpoint.0, self.redirectURL, self.appId);
        self.loginURL = NSURL (string: loginString);
        self.loginCompletion = {};
    }
    
    
    func login (completion : () -> Void) {
        NSURLCache.sharedURLCache().removeAllCachedResponses();
        
        self.loginCompletion = completion;
        self.authController = AuthViewController(nibName : "AuthViewController", bundle: nil);
        self.authController?.delegate = self;
        
        self.authController?.loginURL = self.loginURL;
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
            
            self.saveAuthenticationToken(accessToken, refreshToken: "", expiresIn: expiresIn.doubleValue, environmentEndpoint: MojioClientEnvironment.clientEnvironment.getApiEndpoint())
            
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
        if MojioClientEnvironment.clientEnvironment.getApiEndpoint() != environmentEndpoint {
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
        
        let accountsEndpoint = MojioClientEnvironment.clientEnvironment.getAccountsEndpoint()
        let refreshToken = keychain.get(MojioKeychain.REFRESH_TOKEN.rawValue)
        
        // TODO: check for expiry of refresh token as well
        if refreshToken == nil {
            return
        }
        
        Alamofire.request(.POST, accountsEndpoint.1, parameters: [:], encoding: .Custom({
            (convertible, params) in
            let mutableRequest = convertible.URLRequest.copy() as! NSMutableURLRequest
            let postRequest : NSString = NSString(format: "grant_type=refresh_token&refresh_token=%@&client_id=%@&client_secret=%@&redirect_uri=%@", refreshToken!, self.appId, self.secretKey, self.redirectURL)
            mutableRequest.HTTPBody = postRequest.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
            return (mutableRequest, nil)
        })).responseJSON{ response in
            let json : JSON = JSON(response.result.value ?? [])
            if json != nil {
                let token : String = json["access_token"].string!
                let exp : Double = json["expires_in"].double!
                let refreshToken : String = json["refresh_token"].string!
                
                dispatch_async(dispatch_get_main_queue(), {
                    MojioKeychainManager().saveAuthenticationToken(token, refreshToken: refreshToken, expiresIn: exp, environmentEndpoint: MojioClientEnvironment.clientEnvironment.getApiEndpoint())
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
}
