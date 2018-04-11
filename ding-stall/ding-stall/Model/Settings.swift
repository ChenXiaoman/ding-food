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
    }

    let defaults: UserDefaults

    // setting isRinging to true will cause the device to
    // ring for every new order received.
    private var isRinging: Bool = false

    // Automatically load attributes values if set previously.
    // Otherwise, set attributes values to default values.
    init() {
        self.defaults = UserDefaults.standard
        isRinging = defaults.bool(forKey: Key.isRinging)
    }

    func getIsRinging() -> Bool {
        return isRinging
    }

    mutating func setIsRinging(to newRingingStatus: Bool) {
        isRinging = newRingingStatus
        defaults.set(isRinging, forKey: Key.isRinging)
    }

}
