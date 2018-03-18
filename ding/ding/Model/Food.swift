//
//  Food.swift
//  ding
//
//  Created by Calvin Tantio on 17/3/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import UIKit

public struct Food: Codable {
    var name: String
    var price: Double
    var description: String
    var type: FoodType
    var isSoldOut: Bool
    
    public mutating func soldOut() {
        isSoldOut = false
    }
}

extension Food: Hashable {
    public var hashValue: Int {
        return "\(name)\(price)\(description)\(type)\(isSoldOut)".hashValue
    }
    
    public static func == (lhs: Food, rhs: Food) -> Bool {
        return lhs.name == rhs.name &&
               lhs.price == rhs.price &&
               lhs.description == rhs.description &&
               lhs.type == rhs.type &&
               lhs.isSoldOut == rhs.isSoldOut
    }
}
