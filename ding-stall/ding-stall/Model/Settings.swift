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
    // Default value when the user is created is false.
    var isRinging: Bool {
        return defaults.bool(forKey: Key.isRinging)
    }

    // Setting isAutomaticAcceptOrder to true will cause
    // every new order to be accepted automaticlly.
    // Otherwise, user can choose whether to accept or reject
    // every time an order comes.
    // Default value when the user is created is false.
    var isAutomaticAcceptOrder: Bool {
        return defaults.bool(forKey: Key.isAutomaticAcceptOrder)
    }

    // Automatically load attributes values if set previously.
    // Otherwise, set attributes values to default values.
    init() {
        self.defaults = UserDefaults.standard
    }

    func setIsRinging(to newRingingStatus: Bool) {
        defaults.set(newRingingStatus, forKey: Key.isRinging)
    }

    mutating func setIsAutomaticAcceptOrder(to newAcceptOrderStatus: Bool) {
        defaults.set(newAcceptOrderStatus, forKey: Key.isAutomaticAcceptOrder)
    }

}
