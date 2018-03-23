//
//  Constants.swift
//  ding-stall
//
//  Created by Yunpeng Niu on 23/03/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import UIKit

/**
 Defines some global-level constants ready-to-use.

 - Author: Group 3 @ CS3217
 - Date: March 2018
 */
class Constants {
    /// The identifier for main tab bar controller.
    static let tabBarControllerId = "mainTabBar"
    /// The width of the current device's screen.
    static let screenWidth = UIScreen.main.bounds.width
    /// The height of the current device's screen.
    static let screenHeight = UIScreen.main.bounds.height

    /// The border width for `SettingMenuCell`.
    static let settingMenuCellBorderWidth = CGFloat(0.5)
    /// The suggested height for `SettingMenuCell`.
    static let settingMenuCellHeight = CGFloat(50)
    /// The suggested font size for `SettingMenuCell`.
    static let settingMenuCellFontSize = CGFloat(20)
    /// The suggested inset for `SettingMenuCell`.
    static let settingMenuCellInset = CGFloat(5)
}
