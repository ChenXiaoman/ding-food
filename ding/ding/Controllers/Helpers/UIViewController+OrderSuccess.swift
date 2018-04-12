//
//  UIView + orderSuccess.swift
//  ding
//
//  Created by Chen Xiaoman on 8/4/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import UIKit

/**
 Extension for `UIViewController` which shows the order success
 dialog.
 
 - Author: Group 3 @ CS3217
 - Date: March 2018
 */
extension UIViewController {
    /// The message for order successful alert.
    private static let orderSuccessfulTitle = "Order successful!"
    private static let orderSuccessfulMessage = "View your on-going orders?"
    private static let orderSuccessfulCancelText = "Stay Here"
    
    /// Show alert telling the user the order is successfully submited.
    /// And direct the user to the ongoing order page if he or she wants.
    func alertOrderSuccessful() {
        DialogHelpers.promptConfirm(in: self,
                                    title: UIViewController.orderSuccessfulTitle,
                                    message: UIViewController.orderSuccessfulMessage,
                                    cancelButtonText: UIViewController.orderSuccessfulCancelText,
                                    onConfirm: toOngoingOrderView)
    }
    
    /// Directs the user to `OngoingOrderController` view.
    private func toOngoingOrderView() {
        let id = Constants.ongoingOrderControllerId
        guard let controller = storyboard?.instantiateViewController(withIdentifier: id)
            as? OngoingOrderController else {
                return
        }
        
        navigationController?.pushViewController(controller, animated: true)
    }
}
