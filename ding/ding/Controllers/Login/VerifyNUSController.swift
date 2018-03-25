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
    /// Indicate webpage is loading
    @IBOutlet var loadingIndicator: UIActivityIndicatorView!
    /// The delegate for `LoginViewController`.
    weak var parentController: PasswordSignUpControllerDelegate?

    /// A token used to retrieve data from IVLE API schema, which will be provided
    /// after the user has signed in successfully.
    var token: String?
    /// The user's real name, retrieved from IVLE API.
    var name: String?
    /// The user's NUS email address, retrieved from IVLE API.
    var email: String?
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    /// Handle when user tap the button "Why I need to key in
    /// NUSNET ID here?"
    @IBAction func popUpInfoWindow(_ sender: UIButton) {
        popUpWindow(with: popUpWindowMessage.windowTitle, and: popUpWindowMessage.content)
    }
    
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
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        // Stop loading indicator
        loadingIndicator.stopAnimating()
        
        // Nothing to do for the login page.
        guard let resultUrl = webView.url?.absoluteString, resultUrl != URLs.ivleLoginURL else {
            return
        }

        // When log in is complete, we can hide the web page to perform fetching user info.
        webView.isHidden = true
        webView.evaluateHTMLBody { body in
            // Retrieves information based on the URL.
            switch WebPageInfoType.infoTypeOf(webPageUrl: resultUrl) {
            case .token:
                self.token = body
                webView.load(with: URLs.queryNameURL(token: body))
            case .name:
                self.name = self.retrieveName(from: body)
                if let token = self.token {
                    webView.load(with: URLs.queryEmailURL(token: token))
                }
            case .email:
                self.email = self.retrieveEmail(from: body)
                if let name = self.name, let email = self.email {
                    self.parentController?.receiveCredentialsFromNUS(name: name, email: email)
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
    }

    private func retrieveName(from body: String) -> String {
        return body.getTextBetween(prefix: ">\"", suffix: "\"<")
    }

    private func retrieveEmail(from body: String) -> String {
        return body.getTextBetween(prefix: "0\">", suffix: "</a>")
    }
    
    private func popUpWindow(with title: String, and message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default)  { (_) in
        })
        self.present(alert, animated: true, completion: nil)
    }
}

/**
 An enum defining the type of the webpage.
 */
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

/**
 String for message in pop up window
 */
private struct popUpWindowMessage {
    static let windowTitle = "NUSNET ID"
    static let content = "This is to verify that you are a NUS student. \nDing! will retrieve your name as username and NUS email as the account email."
}
