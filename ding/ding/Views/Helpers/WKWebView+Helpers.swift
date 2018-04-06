//
//  WKWebView+Helpers.swift
//  ding
//
//  Created by Yunpeng Niu on 24/03/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import WebKit

/**
 Extension for `WKWebView`, which provides some handful helper methods ready-for-use.

 - Author: Group 3 @ CS3217
 - Date: March 2018
 */
extension WKWebView {
    /// Loads a certain webpage according to a given URL in the webview object.
    /// - Parameter url: The URL of the desired webpage.
    func load(with url: String) {
        guard let url = URL(string: url) else {
            fatalError("An invalid URL is provided.")
        }
        load(URLRequest(url: url))
    }

    /// Retrieves the body of HTML which is currently displayed on the webview and performs
    /// actions based on its content. It will simply do nothing if the retrieval is not
    /// successful.
    /// - Parameter onComplete: The handler to execute after the HTML has been retrieved.
    func evaluateHTMLBody(_ onComplete: @escaping (String) -> Void) {
        evaluateJavaScript("document.documentElement.outerHTML.toString()",
                           completionHandler: { (html: Any?, _: Error?) in
            guard let str = html as? String else {
                return
            }
            onComplete(self.getHtmlBody(str))
        })
    }

    /// Gets the body part of a complete HTML source code.
    /// - Parameter html: The string representing the complete HTML code.
    /// - Returns:
    private func getHtmlBody(_ html: String) -> String {
        return html.getTextBetween(prefix: "<body>", suffix: "</body>")
    }
}
