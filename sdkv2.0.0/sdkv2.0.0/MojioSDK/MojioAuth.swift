//
//  MojioAuth.swift
//  MOJIOSDK
//
//  Created by Ashish Agarwal on 2016-02-05.
//  Copyright © 2016 Ashish. All rights reserved.
//

import UIKit

class MojioAuth: NSObject, AuthControllerDelegate {
    
    var appId : String
    var redirectURL : String
    var loginURL : NSURL!
    var loginCompletion : (Void) -> (Void)
    var authController : AuthViewController?
    
    init(appId : String, redirectURI : String) {
        self.appId = appId;
        self.redirectURL = redirectURI;
        
        let loginString = String (format: "https://staging-accounts.moj.io/oauth2/authorize?response_type=token&redirect_uri=%@&client_id=%@&scope=full", self.redirectURL, self.appId);
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
            
            self.saveAuthenticationToken(accessToken, expiresIn: expiresIn.doubleValue)
            
            self.authController?.dismissViewControllerAnimated(true, completion: nil);
            self.loginCompletion();
        }
    }
    
    
    func isUserLoggedIn () -> Bool {
        
        let keychainWrapper = KeychainWrapper()
        let authToken : String? = keychainWrapper.myObjectForKey("v_Data") as? String

        let expiryDate : NSString? = NSUserDefaults.standardUserDefaults().objectForKey("MojioAuthTokenExpiresIn") as? NSString
        if authToken == nil || expiryDate == nil {
            return false;
        }
        
        // Check if the token is expired
        let expiresAt : Double = (expiryDate?.doubleValue)!
        let currentTimeInMS : Double = NSDate().timeIntervalSince1970
        
        if currentTimeInMS < expiresAt {
            return true
        }
        
        return false;
    }
    
    func saveAuthenticationToken (token : String, expiresIn : Double) -> Void {
        
        // Save the expiry date of the token in milliseconds since 1970 as it is timezone independent
        
        let currentTimeInMS : Double = NSDate().timeIntervalSince1970
        let expiryDateTimeInMS : Double = currentTimeInMS + (expiresIn * 1000)
        let expiryTime : NSString = String(format: "%f", expiryDateTimeInMS) as NSString
        
        let keychainWrapper = KeychainWrapper()
        keychainWrapper.mySetObject(token, forKey: kSecValueData)
        keychainWrapper.writeToKeychain()

        NSUserDefaults.standardUserDefaults().setObject(expiryTime, forKey: "MojioAuthTokenExpiresIn")
        NSUserDefaults.standardUserDefaults().synchronize();
    }
}
