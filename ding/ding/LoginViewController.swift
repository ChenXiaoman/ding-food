//
//  ViewController.swift
//  ding
//
//  Created by Yunpeng Niu on 16/03/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import UIKit
import WebKit

class LoginViewController: UIViewController, WKNavigationDelegate {
    @IBOutlet private var loginWebView: WKWebView!
    
    private let ivleLoginUrl = "https://ivle.nus.edu.sg/api/login/?apikey=12DtcHnaCAae1ldMAwT5K"
    private let loginSuccessUrl = "https://ivle.nus.edu.sg/api/login/login_result.ashx?apikey=12DtcHnaCAae1ldMAwT5K&r=0"
    private var token: String? // Token is used in IVLE API to retreive user data
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginWebView.navigationDelegate = self
        guard let url = URL(string: ivleLoginUrl) else {
            fatalError("URL is invalid")
        }
        loginWebView.load(URLRequest(url: url))
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        guard let resultUrl = webView.url,
            resultUrl.absoluteString == loginSuccessUrl else {
            print("login failed")
            return
        }
        
        webView.evaluateJavaScript("document.documentElement.outerHTML.toString()", completionHandler: { (html: Any?, error: Error?) in
            guard let html = html as? String else {
                print("fail to get html string")
                return
            }
                                    
            self.token = getUserTokenFromHtml(html)
                                    
        })
    }
    
    /*
     Get the token between "<body>" and "</body>" in html file
     by chopping the redundant characters on the two sides.
     */
    private func getUserTokenFromHtml(_ html: String) -> String {
        let stringChopTokenLeft = html.components(separatedBy: "<body>")[1]
        return stringChopTokenLeft.components(separatedBy: "</body>")[0]
    }
    
}
