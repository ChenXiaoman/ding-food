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
    /// The identifier for the food details view controller.
    static let foodDetailViewControllerId = "foodDetailViewController"
    /// The identifier for the about view controller.
    static let aboutViewControllerId = "aboutViewController"
    /// The identifier for the profile view controller.
    static let profileViewControllerId = "profileViewController"
    /// The identifier for the setting view controller.
    static let settingViewControllerId = "settingViewController"
    /// The identifier for the order detail view controller.
    static let orderDetailControllerId = "orderDetailViewController"
    /// The identifier for the ongoing order view controller.
    static let ongoingOrderControllerId = "ongoingOrderController"
    /// The identifier for the shopping cart view controller.
    static let shoppingCartControllerId = "shoppingCartController"
    /// The identifier for the OrderFoodTableViewController.
    static let orderFoodTableViewControllerId = "OrderFoodTableViewController"
    /// The identifier for the segue from ongoing orders to shopping cart.
    static let ongoingOrderToShoppingCartId = "ongoingOrderToShoppingCart"
    /// The identifier for review table view controller.
    static let reviewTableViewControllerId = "reviewTableViewControllerId"

    /// The tab bar index for search view.
    static let searchViewTabBarIndex = 0
    /// The tab bar index for ongoing order view.
    static let ongoingOrderTabBarIndex = 1
    /// The tab bar index for me view.
    static let meViewTabBarIndex = 2

    /// The constant coefficient for menu corner radius.
    static let menuButtonCornerRadiusCoefficient = CGFloat(0.05)
    /// The border width for menu buttons.
    static let menuButtonBorderWidth = CGFloat(1)

    /// The width of the current device's screen.
    static let screenWidth = UIScreen.main.bounds.width
    /// The height of the current device's screen.
    static let screenHeight = UIScreen.main.bounds.height

    /// The identifier for me setting menu cells.
    static let meSettingCellId = "meSettingMenuCell"
    /// The height for me setting menu cells.
    static let meSettingCellHeight = CGFloat(60)

    /// The time interval to define timeout.
    static let timeoutInterval = 10.0
    
    /// The default amount of 'OrderImmediately' method.
    static let orderDefaultAmount = 1
    
    /// The text on the sold out button.
    static let soldOutButtonText = "Sold out"
    
    /// The text on the section of food option.
    static let foodOptionSectionText = "Choose your favourite option(s)"
    
    /// The text on the header of review section.
    static let reviewSectionHeaderText = "How's the service?"
    /// The text on review text field row.
    static let reviewSectionRowText = "Write a review! (optional)"
    /// The text on the header of a written review.
    static let writtenReviewSectionHeaderText = "My review"
    /// The text for submit review successfully.
    static let reviewSubmitedAlertText = "Review submitted successfully!"
    /// The text in edit review button
    static let editReviewButtonText = "Edit my review"
}
