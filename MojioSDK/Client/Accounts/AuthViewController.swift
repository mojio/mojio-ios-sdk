/******************************************************************************
 * Moj.io Inc. CONFIDENTIAL
 * 2021 Copyright Moj.io Inc.
 * All Rights Reserved.
 *
 * NOTICE:  All information contained herein is, and remains, the property of
 * Moj.io Inc. and its suppliers, if any.  The intellectual and technical
 * concepts contained herein are proprietary to Moj.io Inc. and its suppliers
 * and may be covered by Patents, pending patents, and are protected by trade
 * secret or copyright law.
 *
 * Dissemination of this information or reproduction of this material is strictly
 * forbidden unless prior written permission is obtained from Moj.io Inc.
 *******************************************************************************/

import UIKit
import WebKit

public protocol AuthControllerDelegate {
    func authControllerLoadURLRequest (_ request: URLRequest);
}

open class AuthViewController: UIViewController, WKNavigationDelegate {
    
    open var loginURL: URL!
    open var delegate: AuthControllerDelegate?

    @IBOutlet open var webview: WKWebView?
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()

        self.webview?.navigationDelegate = self
        let request: URLRequest = URLRequest(url: self.loginURL)
        self.webview?.load(request)
    }
    
    //MARK: webview delegate methods
    
    open func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        self.delegate?.authControllerLoadURLRequest(navigationAction.request);
        decisionHandler(.allow)
    }

    
    open override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
