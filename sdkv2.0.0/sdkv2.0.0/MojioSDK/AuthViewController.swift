//
//  AuthViewController.swift
//  MojioSDK
//
//  Created by Ashish Agarwal on 2016-02-05.
//  Copyright © 2016 Ashish. All rights reserved.
//

import UIKit

protocol AuthControllerDelegate {
    func mojioAuthControllerLoadURLRequest (request : NSURLRequest);
}

class AuthViewController: UIViewController, UIWebViewDelegate {
    
    var loginURL : NSURL!
    var delegate : AuthControllerDelegate?
    @IBOutlet var webview: UIWebView?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil);
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let request : NSURLRequest = NSURLRequest(URL: self.loginURL);
        self.webview?.loadRequest(request);        
    }
    
    //MARK: webview delegate methods
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        self.delegate?.mojioAuthControllerLoadURLRequest(request);
        return true;
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
