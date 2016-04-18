//
//  AuthViewController.swift
//  MojioSDK
//
//  Created by Ashish Agarwal on 2016-02-05.
//  Copyright © 2016 Ashish. All rights reserved.
//

import UIKit

public protocol AuthControllerDelegate {
    func authControllerLoadURLRequest (request : NSURLRequest);
}

public class AuthViewController: UIViewController, UIWebViewDelegate {
    
    public var loginURL : NSURL!
    public var delegate : AuthControllerDelegate?

    @IBOutlet public var webview: UIWebView?
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil);
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()

        let request : NSURLRequest = NSURLRequest(URL: self.loginURL);
        self.webview?.loadRequest(request);        
    }
    
    //MARK: webview delegate methods
    
    public func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        self.delegate?.authControllerLoadURLRequest(request);
        return true;
    }

    
    public override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
