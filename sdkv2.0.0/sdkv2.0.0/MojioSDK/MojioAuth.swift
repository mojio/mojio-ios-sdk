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
    
    var appId : String?
    var redirectURL : String?
    var loginURL : NSURL!
    var loginCompletion : (Void) -> (Void)
    var authController : AuthViewController?
        
    init(appId : String, redirectURI : String) {
        self.appId = appId
        self.redirectURL = redirectURI
        
        let accountsEndpoint = MojioClientEnvironment.clientEnvironment.getAccountsEndpoint()
        
        //TODO: make this accounts endpoint
        let loginString = String (format: "%@?response_type=token&redirect_uri=%@&client_id=%@&scope=full", accountsEndpoint.0, self.redirectURL!, self.appId!);
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
        // loading the url request
        let url : NSURL = request.URL!;
        let urlScheme : String? = url.absoluteString.componentsSeparatedByString("#")[0];
        
        if urlScheme != nil && urlScheme == self.redirectURL {
            print("extract auth token over here");
            let string = url.absoluteString;
            let accessToken = (string.componentsSeparatedByString("access_token="))[1].componentsSeparatedByString("&")[0];
            let expiresIn : NSString = (string.componentsSeparatedByString("expires_in="))[1]
            let refreshToken = (string.componentsSeparatedByString("refresh_token="))[1].componentsSeparatedByString("&")[0];
            
            self.saveAuthenticationToken(accessToken, refreshToken: refreshToken, expiresIn: expiresIn.doubleValue)
            
            self.authController?.dismissViewControllerAnimated(true, completion: nil);
            self.loginCompletion();
        }
    }
    
    func isUserLoggedIn () -> Bool {
        
        let token = self.getAuthToken()
        let authToken : String? = token.0
        let expiryDate : NSString? = token.2
        
        if authToken == nil || expiryDate == nil {
            return false;
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
        let refreshToken = keychain.get("MojioAuthRefreshToken")
        
        // TODO: check for expiry of refresh token as well
        if refreshToken == nil {
            return
        }
        
        Alamofire.request(.POST, accountsEndpoint.1, parameters: [:], encoding: .Custom({
            (convertible, params) in
            let mutableRequest = convertible.URLRequest.copy() as! NSMutableURLRequest
            let postRequest : NSString = NSString(format: "grant_type=refresh_token&refresh_token=%@&client_id=%@&client_secret=%@&redirect_uri=%@", refreshToken!, AppConfig.AppId, AppConfig.AppSecretKey, AppConfig.AppRedirectUrl)
            mutableRequest.HTTPBody = postRequest.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
            return (mutableRequest, nil)
        })).responseJSON{ response in
            let json : JSON = JSON(response.result.value ?? [])
            if json != nil {
                let token : String = json["access_token"].string!
                let exp : Double = json["expires_in"].double!
                let refreshToken : String = json["refresh_token"].string!
                
                dispatch_async(dispatch_get_main_queue(), {
                    MojioKeychainManager().saveAuthenticationToken(token, refreshToken: refreshToken, expiresIn: exp)
                })
            }
        }
        
    }
    
    func logout() {
        MojioKeychainManager().deleteTokenFromKeychain()
    }
    
    func getAuthToken () -> (String?, String?, NSString?) {
        return MojioKeychainManager().getAuthToken()
    }
    
    func saveAuthenticationToken (token : String, refreshToken : String, expiresIn : Double) -> Void {
        
        MojioKeychainManager().saveAuthenticationToken(token, refreshToken: refreshToken, expiresIn: expiresIn)
        
    }
}
