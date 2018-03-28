//
//  Food.swift
//  ding
//
//  Created by Calvin Tantio on 17/3/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

/**
 Represents an atomic unit of a menu and everything that can be consumed.
 This includes drinks.
 */
public struct Food: FirebaseObject {
    public static let path = "/foods"

    public let id: String
    public var name: String
    public var price: Double
    public var description: String
    public var type: FoodType
    public var isSoldOut: Bool

    public mutating func soldOut() {
        isSoldOut = true
    }
}
