//
//  Settings.swift
//  ding
//
//  Created by Yunpeng Niu on 14/04/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import Foundation

/**
 An abstract representation for the settings in the application.

 - Author: Group 3 @ CS3217
 - Date: March 2018
 */
struct Settings {
    /// A shared instance of `Settings`.
    static let standard = Settings()

    /// The key for volume setting.
    private static let volumeKey = "volume"
    
    /// Returns true if the user set the volume on or the user neve sets the
    /// volume before.
    var isVolumeOn: Bool {
        guard UserDefaults.standard.object(forKey: Settings.volumeKey) != nil else {
            return true
        }
        return UserDefaults.standard.bool(forKey: Settings.volumeKey)
    }

    /// Sets the volume on/off for the application.
    /// - Parameter flag: The flag indicating whether the volume is on / off.
    func setVolume(_ flag: Bool) {
        UserDefaults.standard.set(flag, forKey: Settings.volumeKey)
    }
}
