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

    let defaults = UserDefaults.standard

    // Setting isRinging to true will cause the device to
    // ring for every new order received.
    // Default value when the user is created is false.
    var isRinging: Bool {
        get {
            return defaults.bool(forKey: Key.isRinging)
        }

        set(newRingingStatus) {
            defaults.set(newRingingStatus, forKey: Key.isRinging)
        }
    }

    // Setting isAutomaticAcceptOrder to true will cause
    // every new order to be accepted automaticlly.
    // Otherwise, user can choose whether to accept or reject
    // every time an order comes.
    // Default value when the user is created is false.
    var isAutomaticAcceptOrder: Bool {
        get {
            return defaults.bool(forKey: Key.isAutomaticAcceptOrder)
        }

        set(newAcceptOrderStatus) {
            defaults.set(newAcceptOrderStatus, forKey: Key.isAutomaticAcceptOrder)
        }
    }
}
