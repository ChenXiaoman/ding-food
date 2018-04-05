//
//  UIViewController+Permission.swift
//  ding
//
//  Created by Yunpeng Niu on 05/04/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import UIKit

/**
 Extension for `UIViewController` which provides some utlities for permission
 control.

 - Author: Group 3 @ CS3217
 - Date: March 2018
 */
extension UIViewController {
    /// Used to handle all logics related to Firebase Auth.
    private static let currentAuthorizer = Authorizer()

    /// An adapter to access authorizer object.
    var authorizer: Authorizer {
        return UIViewController.currentAuthorizer
    }

    /// Pop up warning when the user is not logged in or
    /// the account is not verify
    private func handleUserNotLogin() {
        // stopLoading()
        if authorizer.didLogin {
            popUpNeedToLogin()
        }
        if authorizer.isEmailVerified {
            popUpNeedToVerityEmail()
        }
    }

    /// Pop up an alert warning user to verify email
    func popUpNeedToVerityEmail() {
        DialogHelpers.showAlertMessage(in: self, title: "Oops",
                                       message: "Please verify your account in email in order to check your orders")
    }

    /// Pop up an alert warning user to log in first
    func popUpNeedToLogin() {
        DialogHelpers.showAlertMessage(in: self, title: "Oops",
                                       message: "Please log in first in order to check your orders")
    }
}
