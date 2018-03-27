//
//  ArithmeticExtensions.swift
//  ding-stall
//
//  Created by Jiang Chunhui on 26/03/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

/// This file includes extension of some data types
/// to make them flexible to take different input parameter types

import UIKit

extension CGFloat {
    static func / (_ lhs: CGFloat, _ rhs: Int) -> CGFloat {
        return lhs / CGFloat(rhs)
    }
}

extension CGSize {
    static func * (_ lhs: CGFloat, _ rhs: CGSize) -> CGSize {
        return CGSize(width: lhs * rhs.width, height: lhs * rhs.height)
    }
}
