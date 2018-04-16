//
//  UIViewController+Dispatch.swift
//  ding
//
//  Created by Yunpeng Niu on 06/04/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import UIKit

/**
 Extension for `UIViewController` which provides some utlities for dispatch
 queue. This provides us with the ability of multi-thread programming. However,
 great power comes with great responsibility. Multi-thread can be very error-
 prone.

 - Author: Group 3 @ CS3217
 - Date: March 2018
 */
extension UIViewController {
    /// The title for alert box.
    private static let alertTitle = "Timout"
    /// The title for alert box.
    private static let alertMessage = "Please check your Internet connection."

    /// Checks whether the loading has completed after a certain interval. This is done
    /// by opening a new thread to better utilize CPU resources.
    /// - Parameters:
    ///    - indicator: An `ActivityIndicator` to indicate whether loading has completed.
    /// You should stop this indicator immediately after the loading has completed.
    ///    - interval: The time given before timeout checking is done.
    ///    - onTimeout: The function to be called when the loading has not completed even
    /// after the given time interval.
    func checkLoadingTimeout(indicator: UIActivityIndicatorView?, interval: Double, onTimeout: (() -> Void)?) {
        dispatch(for: interval) {
            guard let handler = onTimeout else {
                return
            }
            
            if let indicator = indicator {
                if indicator.isAnimating {
                    handler()
                }
            } else {
                handler()
            }
        }
    }

    /// Dispatches a certain task to happen after an amount of time. The underlying
    /// scheduler will handle this.
    /// - Parameters:
    ///    - for: The difference between the time when the task is executed and
    /// the time this function is called, which must be a non-negative number. This
    /// time should be expressed in the unit of seconds.
    ///    - task: The task being dispatched.
    func dispatch(for seconds: Double, task: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds, execute: task)
    }

    /// Shows an alert box to the user indicating that timeout is detected. After the
    /// user clicks "OK", he/she will be prompted to the settings to check Internet
    /// connection.
    func alertTimeout() {
        DialogHelpers.promptConfirm(in: self, title: UIViewController.alertTitle,
                                    message: UIViewController.alertMessage, cancelButtonText: "Cancel") {
            guard let settings = URL(string: UIApplicationOpenSettingsURLString) else {
                return
            }
            UIApplication.shared.open(settings, options: [:], completionHandler: nil)
        }
    }
}
