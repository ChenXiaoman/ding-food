//
//  UIColor+RGB.swift
//  ding-stall
//
//  Created by Jiang Chunhui on 04/04/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import UIKit

extension UIColor {
    /// Creates a `UIColor` from a 6-bit hexadecimal representation of RGB value.
    /// - Parameter rgbValue: The RGB value in 6-bit hexadecimal.
    /// - Returns: The `UIColor` created.
    static func fromRGB(_ rgbValue: UInt) -> UIColor {
        return UIColor(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                       green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                       blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                       alpha: CGFloat(1.0))
    }
}
