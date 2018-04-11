//
//  Settings.swift
//  ding-stall
//
//  Created by Calvin Tantio on 11/4/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import UIKit

/**
 `Settings` represents the configuration of the application that
 is saved locally instead of in the cloud.

 - Author: Group 3 @ CS3217
 - Date: March 2018
 */
struct Settings {
    private struct Key {
        static let isRinging = "Ring"
        static let isAutomaticAcceptOrder = "Accept"
    }

    let defaults: UserDefaults

    // Setting isRinging to true will cause the device to
    // ring for every new order received.
    // Default value is false.
    private(set) var isRinging: Bool

    // Setting isAutomaticAcceptOrder to true will cause
    // every new order to be accepted automaticlly.
    // Otherwise, user can choose whether to accept or reject
    // every time an order comes.
    // Default value is false.
    private(set) var isAutomaticAcceptOrder: Bool

    // Automatically load attributes values if set previously.
    // Otherwise, set attributes values to default values.
    init() {
        self.defaults = UserDefaults.standard
        isRinging = defaults.bool(forKey: Key.isRinging)
        isAutomaticAcceptOrder = defaults.bool(forKey: Key.isAutomaticAcceptOrder)
    }

    mutating func setIsRinging(to newRingingStatus: Bool) {
        isRinging = newRingingStatus
        defaults.set(isRinging, forKey: Key.isRinging)
    }

    mutating func setIsAutomaticAcceptOrder(to newAcceptOrderStatus: Bool) {
        isAutomaticAcceptOrder = newAcceptOrderStatus
        defaults.set(isAutomaticAcceptOrder, forKey: Key.isAutomaticAcceptOrder)
    }

}
