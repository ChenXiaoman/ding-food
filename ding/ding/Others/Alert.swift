//
//  Alert.swift
//  ding
//
//  Created by Chen Xiaoman on 4/4/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//
import UIKit

class Alert {
    
    /// Pop up an alert window
    static func popUpWindow(with title: String, and message: String, in viewController: UIViewController, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default)  { (_) in
            if let completion = completion {
                completion()
            }
        })
        viewController.present(alert, animated: true, completion: nil)
    }
    
    /// Pop up an alert warning user to verify email
    static func popUpNeedToVerityEmail(in controller: UIViewController) {
        Alert.popUpWindow(with: "Oops", and: "Please verify your account in email in order to check your orders", in: controller)
    }
    
    /// Pop up an alert warning user to log in first
    static func popUpNeedToLogin(in controller: UIViewController) {
        Alert.popUpWindow(with: "Oops", and: "Please log in first in order to check your orders", in: controller)
    }
}
