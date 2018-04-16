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

 - Author: Group 3 @ CS3217
 - Date: March 2018
 */
public struct Food: DatabaseObject {
    public static let path = "/menu"
    public static let menuPath = "/stalls/%@\(Food.path)"
    
    public let id: String
    public var name: String
    public var price: Double
    public var description: String?
    public var type: FoodType
    public var isSoldOut: Bool
    public var photoPath: String?
    public var options: [String: [String]]?
}

/**
 The type of a `Food`, whose raw value is the text that is displayed on
 the picker view.
 */
public enum FoodType: String, Codable {
    case main = "Main"
    case side = "Side"
    case drink = "Drink"
}
