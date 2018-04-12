//
//  UIViewController+Keyboard.swift
//  ding
//
//  Created by Yunpeng Niu on 06/04/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import UIKit

/**
 Extension for `UIViewController` which provides some utlities for keyboard control.
 Any testing for this extension must be verified on real devices.

 - Author: Group 3 @ CS3217
 - Date: March 2018
 */
extension UIViewController {
    /// Asks the keyboard to be automatically hidden when the user taps anywhere else.
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    /// Forces the `endEditing` attribute to be true and thus collapse the keyboard.
    @objc
    func dismissKeyboard() {
        view.endEditing(true)
    }
}

