//
//  Constants.swift
//  ding
//
//  Created by Yunpeng Niu on 24/03/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import UIKit

/**
 Defines some global-level constants ready-to-use.

 - Author: Group 3 @ CS3217
 - Date: March 2018
 */
struct Constants {
    /// The identifier for `VerifyNUSController` scene.
    static let verifyNUSControllerId = "verifyNUSController"
    /// The identifier for the main tab bar.
    static let mainTabBarId = "mainTabBarController"
    /// The identifier for the stall details view controller.
    static let stallDetailControllerId = "stallDetailController"
    /// The identifier for the segue from ongoing orders to shopping cart.
    static let ongoingOrderToShoppingCartId = "ongoingOrderToShoppingCart"

    /// The constant coefficient for menu corner radius.
    static let menuButtonCornerRadiusCoefficient = CGFloat(0.15)
    /// The border width for menu buttons
    static let menuButtonBorderWidth = CGFloat(1)

    /// The width of the current device's screen.
    static let screenWidth = UIScreen.main.bounds.width
    /// The height of the current device's screen.
    static let screenHeight = UIScreen.main.bounds.height

    /// The identifier for me setting menu cells.
    static let meSettingCellId = "meSettingMenuCell"
    /// The height for me setting menu cells.
    static let meSettingCellHeight = CGFloat(60)
}
