//
//  AuthViewController.swift
//  MojioSDK
//
//  Created by Ashish Agarwal on 2016-02-05.
//  Copyright © 2016 Ashish. All rights reserved.
//

import UIKit

public protocol AuthControllerDelegate {
    func authControllerLoadURLRequest (_ request : URLRequest);
}

open class AuthViewController: UIViewController, UIWebViewDelegate {
    
    open var loginURL : URL!
    open var delegate : AuthControllerDelegate?

    @IBOutlet open var webview: UIWebView?
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil);
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()

        let request : URLRequest = URLRequest(url: self.loginURL);
        self.webview?.loadRequest(request);        
    }
    
    //MARK: webview delegate methods
    
    open func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        self.delegate?.authControllerLoadURLRequest(request);
        return true;
    }

    
    open override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
