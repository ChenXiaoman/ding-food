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

    func getHTML() {

    }
}
