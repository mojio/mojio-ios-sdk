//
//  Request.swift
//  sdkv2.0.0
//
//  Created by Ashish Agarwal on 2016-02-29.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit

public class Request {
    
    var request:String?
    struct response{
        static var data:NSHTTPURLResponse?
        static var json:AnyObject?
        static var error:NSError?
    }
    
    init (request:String){
        self.request = request
    }
    
    public func responseJSON(options: NSJSONReadingOptions = .AllowFragments, completionHandler: (NSURLRequest, NSHTTPURLResponse?, AnyObject?, NSError?) -> Void) -> Self {
        
        completionHandler(NSURLRequest(URL: NSURL(string:self.request!)!), Request.response.data, Request.response.json, Request.response.error)
        return self
    }
}
