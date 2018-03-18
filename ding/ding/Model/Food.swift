//
//  Food.swift
//  ding
//
//  Created by Calvin Tantio on 17/3/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

public struct Food: FirebaseObject {
    public var name: String
    public var price: Double
    public var description: String
    public var type: FoodType
    public var isSoldOut: Bool
    public let id: String

    public mutating func soldOut() {
        isSoldOut = true
    }

    public var hashValue: Int {
        return id.hashValue
    }

    public static func == (lhs: Food, rhs: Food) -> Bool {
        return lhs.id == rhs.id &&
            lhs.name == rhs.name &&
            lhs.price == rhs.price &&
            lhs.description == rhs.description &&
            lhs.type == rhs.type &&
            lhs.isSoldOut == rhs.isSoldOut
    }
}
