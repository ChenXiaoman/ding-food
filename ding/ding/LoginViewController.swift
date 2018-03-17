//
//  LoginViewController.swift
//  ding
//
//  Created by Yunpeng Niu on 16/03/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import UIKit
import WebKit

class LoginViewController: UIViewController, WKNavigationDelegate {
    @IBOutlet private var loginWebView: WKWebView!
    
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var emailLabel: UILabel!
    
    private let apiKey = "12DtcHnaCAae1ldMAwT5K"
    private let ivleLoginUrl = "https://ivle.nus.edu.sg/api/login/?apikey=12DtcHnaCAae1ldMAwT5K"
    private let loginSuccessUrl = "https://ivle.nus.edu.sg/api/login/login_result.ashx?apikey=12DtcHnaCAae1ldMAwT5K&r=0"
    private var token: String? // Token is used in IVLE API to retreive user data
    public var userName: String?
    public var email: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadPage(with: ivleLoginUrl)
    }
    
    /// Load a web page with given url
    private func loadPage(with url: String) {
        loginWebView.navigationDelegate = self
        guard let url = URL(string: url) else {
            fatalError("URL is invalid")
        }
        loginWebView.load(URLRequest(url: url))
    }
    
    /// Get user's information when a page is loaded
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        guard let resultUrl = webView.url?.absoluteString else {
            print("login failed")
            return
        }
        
        if resultUrl == ivleLoginUrl {
            return
        }
        
        // When log in is complete, we can hide the web page to perform fetching user info
        webView.isHidden = true
        getInfoFrom(webView: webView, url: resultUrl)
        
    }
    
    /// Get the information displayed in the webpage
    private func getInfoFrom(webView: WKWebView, url: String) {
        webView.evaluateJavaScript("document.documentElement.outerHTML.toString()", completionHandler: { (html: Any?, error: Error?) in
            guard let html = html as? String else {
                print("fail to get html string")
                return
            }
            let textInHtml = self.getTextFromHtml(html)
            switch WebPageInfoType.infoTypeOf(webPageUrl: url) {
            case .token:
                self.token = textInHtml
                self.loadUserNameFromToken()
            case .name:
                self.userName = self.getUserNameFromText(textInHtml)
                self.nameLabel.text = "Hi, \(self.getUserNameFromText(textInHtml))!"
                self.loadEmailFromToken()
            case .email:
                self.email = self.getUserEmailFromText(textInHtml)
                self.emailLabel.text = "Your email is \(self.getUserEmailFromText(textInHtml))"
            }
        })
        
    }

    /// Get the text between "<body>" and "</body>" in html file
    private func getTextFromHtml(_ html: String) -> String {
        return html.getTextBetween(prefix: "<body>", suffix: "</body>")
    }
    
    private func getUserNameFromText(_ text: String) -> String {
        return text.getTextBetween(prefix: ">\"", suffix: "\"<")
    }
    
    private func getUserEmailFromText(_ text: String) -> String {
        return text.getTextBetween(prefix: "0\">", suffix: "</a>")
    }
    
    private func loadUserNameFromToken() {
        guard let token = self.token else {
            return
        }
        loadPage(with: "https://ivle.nus.edu.sg/api/Lapi.svc/UserName_Get?APIKey=\(apiKey)&Token=\(token)")
    }
    
    private func loadEmailFromToken() {
        guard let token = self.token else {
            return
        }
        loadPage(with: "https://ivle.nus.edu.sg/api/Lapi.svc/UserEmail_Get?APIKey=\(apiKey)&Token=\(token)")
    }
    
}

enum WebPageInfoType {
    case token
    case name
    case email
    
    static func infoTypeOf(webPageUrl: String) -> WebPageInfoType {
        if webPageUrl.contains(subString: "UserName_Get") {
            return WebPageInfoType.name
        } else if webPageUrl.contains(subString: "UserEmail_Get") {
            return WebPageInfoType.email
        }
        return WebPageInfoType.token
    }
}
