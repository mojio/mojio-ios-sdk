//
//  MojioAuth.swift
//  Swifty
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
        var urlScheme : String = self.redirectURL.stringByReplacingOccurrencesOfString("://", withString: "");
        urlScheme = urlScheme.lowercaseString;
        
        if url.scheme == urlScheme {
            print("extract auth token over here");
            let string = url.absoluteString;
            let accessToken = (string.componentsSeparatedByString("access_token="))[1].componentsSeparatedByString("&")[0];
            NSUserDefaults.standardUserDefaults().setObject(accessToken, forKey: "MojioAuthToken");
            NSUserDefaults.standardUserDefaults().synchronize();
            
            
            self.authController?.dismissViewControllerAnimated(true, completion: nil);
            self.loginCompletion();
        }
    }
    
}
