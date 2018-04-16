//
//  Food.swift
//  ding
//
//  Created by Calvin Tantio on 17/3/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import DingBase

/**
 Represents an atomic unit of a menu and everything that can be consumed.
 This includes drinks.
 */
public struct Food: DatabaseObject {
    public static var path = "/menu"

    public let id: String
    public var name: String
    public var price: Double
    public var description: String?
    public var type: FoodType
    public var isSoldOut: Bool
    public var photoPath: String?
    public var options: [String: [String]]?

    /// Provide a new path for the stall photo if it has changed
    public static var newPhotoPath: String {
        return Food.path + "/\(Account.stallId)" + "/\(Food.getAutoId)"
    }
}

/**
 Enumeration of food type.
 The raw value is the text that is displayed on the picker.
 */
public enum FoodType: String, Codable {
    case main = "Main"
    case side = "Side"
    case drink = "Drink"
}
