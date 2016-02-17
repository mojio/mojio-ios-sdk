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
        
        
        
        /* For the resource owner flow
            grant_type=password&password=Test123&username=ashisha@moj.io&client_id=9692e2af-07f6-46ed-b384-1831b739ebf6&client_secret=b463050d-86b3-4c9c-b47b-924addb6e321
        */
        
        let loginString = String (format: "https://staging-accounts.moj.io/oauth2/authorize?response_type=token&redirect_uri=%@&client_id=%@&scope=full", self.redirectURL, self.appId);
//        let loginString = String (format: "https://staging-accounts.moj.io/oauth2/authorize?response_type=token&redirect_uri=%@&client_id=%@&scope=full", self.redirectURL, self.appId);
//        let loginString = String (format: "https://staging-accounts.moj.io/oauth2/authorize?grant_type=password&password=%@&username=%@&client_id=%@&secret_key=%@", "Test123", "ashisha@moj.io", self.appId, "b463050d-86b3-4c9c-b47b-924addb6e321");
        
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
            NSUserDefaults.standardUserDefaults().setObject(accessToken, forKey: "MojioAuthToken");
            NSUserDefaults.standardUserDefaults().synchronize();
            
            
            self.authController?.dismissViewControllerAnimated(true, completion: nil);
            self.loginCompletion();
        }
    }
    
    func isUserLoggedIn () -> Bool {
        // TODO: Check expiry of token and refresh token if needed
        let authToken : String? = NSUserDefaults.standardUserDefaults().objectForKey("MojioAuthToken") as? String;
        if authToken != nil {
            return true;
        }
        return false;
    }
    
}
