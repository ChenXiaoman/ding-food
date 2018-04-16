//
//  UIViewController+Permission.swift
//  ding
//
//  Created by Yunpeng Niu on 05/04/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import DingBase
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
    /// The title for alert box.
    private static let alertTitle = "Oops"
    /// The message to require login.
    private static let loginMessage = "Please log in first to proceed."
    /// The message to require email verification.
    private static let verifyEmailMessage = "Please verify your email address and then log in back."

    /// An adapter to access authorizer object.
    var authorizer: Authorizer {
        return UIViewController.currentAuthorizer
    }

    /// Performs permission control and decides whether to allow the user to
    /// access the ongoing order listing.
    /// - Returns: true if the permission check passes; false otherwise.
    func checkPermission() -> Bool {
        guard authorizer.didLogin else {
            alertLoginRequired()
            return false
        }
        guard authorizer.isEmailVerified else {
            alertVerifyEmail()
            return false
        }
        return true
    }

    /// Shows an alert message to ask the user to log in first and brings the user to login.
    private func alertLoginRequired() {
        DialogHelpers.showAlertMessage(in: self, title: UIViewController.alertTitle,
                                       message: UIViewController.loginMessage,
                                       onConfirm: toMeTabBarView)
    }

    /// Shows an alert message to ask the user to verify the account  and pops to the
    /// login view.
    private func alertVerifyEmail() {
        DialogHelpers.showAlertMessage(in: self, title: UIViewController.alertTitle,
                                       message: UIViewController.verifyEmailMessage,
                                       onConfirm: toMeTabBarView)
    }

    /// Brings the user to the me view (i.e, the last index in the tab bar).
    private func toMeTabBarView() {
        tabBarController?.selectedIndex = Constants.meViewTabBarIndex
    }
}
