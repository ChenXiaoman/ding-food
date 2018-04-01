//
//  UIView+Utility.swift
//  ding
//
//  Created by Yunpeng Niu on 01/04/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import UIKit

/**
 Extension for `UIView`, which provides some utility methods ready-for-use.
 */
extension UIView {
    /// Returns whether the device is currently on a iPhone.
    static var onPhone: Bool {
        return UIDevice.current.userInterfaceIdiom == .phone
    }
}
