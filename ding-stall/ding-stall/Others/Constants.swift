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
struct Constants {
    /// The identifier for main tab bar controller.
    static let tabBarControllerId = "mainTabBar"
    /// The identifier for about view controller.
    static let aboutControllerId = "aboutViewController"
    /// The identifier for profile view controller.
    static let profileControllerId = "profileViewController"
    /// The identifier for order history view controller.
    static let orderHistoryControllerId = "orderHistoryController"
    /// The identifier for settings view controller.
    static let settingsControllerId = "settingsController"

    /// The width of the current device's screen.
    static let screenWidth = UIScreen.main.bounds.width
    /// The height of the current device's screen.
    static let screenHeight = UIScreen.main.bounds.height
    /// The padding for each screen
    static let screenPadding = screenWidth * 0.1

    /// The identifier for me setting menu cells.
    static let meSettingCellId = "meSettingMenuCell"
    /// The height for me setting menu cells.
    static let meSettingCellHeight = CGFloat(60)

    /// The standard image size in KB
    static let standardImageSize = 1_024
    static let bytesPerKiloByte = 1_024
}

/**
 Define constants for MenuCollectionView.
 */
struct MenuViewConstants {

    /// Number of food cells in one row.
    static let numCellsPerRow = 3

    /// The ratio between cell size and inset.
    static let cellRatio = 0.9

    /// The ratio between the cell height and width
    static let heightWidthRatio = 1.25
}
