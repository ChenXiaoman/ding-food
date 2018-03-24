//
//  LoginViewController.swift
//  ding
//
//  Created by Yunpeng Niu on 16/03/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import UIKit
import WebKit

/**
 The `WebView` controller to manage IVLE API login. It will verify whether a
 user is affiliated with NUS using the NUSNET ID and password. If so, the user's
 real name, email address will be retrieved.

 - Author: Group 3 @ CS3217
 - Date: March 2018
 */
class VerifyNUSController: UIViewController {
    /// The web view to display webpage.
    @IBOutlet private var webView: WKWebView!

    /// A token used to retrieve data from IVLE API schema, which will be provided
    /// after the user has signed in successfully.
    var token: String?
    /// The user's real name, retrieved from IVLE API.
    var name: String?
    /// The user's NUS email address, retrieved from IVLE API.
    var email: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.navigationDelegate = self
        webView.load(with: URLs.ivleLoginURL)
    }
}

/**
 Extension for `VerifyNUSController` so as to work as the navigation delegate for the
 web view object.
 */
extension VerifyNUSController: WKNavigationDelegate {
    /// Get user's information when a page is loaded
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        // Only fetch user info
        guard let resultUrl = webView.url?.absoluteString, resultUrl != URLs.ivleLoginURL else {
            return
        }

        // When log in is complete, we can hide the web page to perform fetching user info
        webView.isHidden = true
        getInfoFrom(webView: webView, url: resultUrl)
    }

    /// Get the information displayed in the webpage
    private func getInfoFrom(webView: WKWebView, url: String) {
        webView.evaluateJavaScript("document.documentElement.outerHTML.toString()",
                                   completionHandler: { (html: Any?, _: Error?) in
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
                                        self.name = self.getUserNameFromText(textInHtml)
                                        self.loadEmailFromToken()
                                    case .email:
                                        self.email = self.getUserEmailFromText(textInHtml)
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
        webView.load(with: URLs.queryNameURL(token: token))
    }

    private func loadEmailFromToken() {
        guard let token = self.token else {
            return
        }
        webView.load(with: URLs.queryEmailURL(token: token))
    }
}

private enum WebPageInfoType {
    case token
    case name
    case email

    static func infoTypeOf(webPageUrl: String) -> WebPageInfoType {
        if webPageUrl.contains(subString: "UserName_Get") {
            return .name
        } else if webPageUrl.contains(subString: "UserEmail_Get") {
            return .email
        } else {
            return .token
        }
    }
}

/**
 Defines some URLs used when interacting with IVLE API.
 */
private struct URLs {
    private static let apiKey = "12DtcHnaCAae1ldMAwT5K"

    static let ivleLoginURL = "https://ivle.nus.edu.sg/api/login/?apikey=\(URLs.apiKey)"
    static let loginSuccessURL = "https://ivle.nus.edu.sg/api/login/login_result.ashx?apikey=\(URLs.apiKey)&r=0"

    static let nameBaseURL = "https://ivle.nus.edu.sg/api/Lapi.svc/UserName_Get?APIKey=\(URLs.apiKey)&Token="
    static let emailBaseURL = "https://ivle.nus.edu.sg/api/Lapi.svc/UserEmail_Get?APIKey=\(URLs.apiKey)&Token="

    /// Creates a URL used to query the user's real name.
    /// - Parameter token: The token for authentication.
    static func queryNameURL(token: String) -> String {
        return nameBaseURL + token
    }

    /// Creates a URL used to query the user's NUS email address.
    /// - Parameter token: The token for authentication.
    static func queryEmailURL(token: String) -> String {
        return emailBaseURL + token
    }
}
