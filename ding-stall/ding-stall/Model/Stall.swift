//
//  Stall.swift
//  ding
//
//  Created by Calvin Tantio on 17/3/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import Foundation

/**
 Represents a food stall registered in the application.
 */
public struct Stall: FirebaseObject {
    public static var currentStall: Stall {
        get {
            return self.currentStall
        }
    }

    public static var path = "/stall"

    public let id: String

    public var name: String
    public var location: String
    public var openingHour: String
    public var description: String
    public var menu: [Food]?
    public var queue: [Order]?

    public var filters: Set<FilterIdentifier>?

    /// Add the a new kind of food into menu
    /// - Parameters:
    ///    - name: Food Name
    ///    - price: Food Price (must be a non-negative decimal number)
    ///    - type: Food Type
    ///    - description: Food Description
    ///    - photoPath: The path that store the food picture
    public mutating func addFood(id: String, name: String, price: Double, type: FoodType, description: String?,
                                 photoPath: String?) {
        guard price > 0 else {
            return
        }
        let newFood = Food(id: id, name: name, price: price, description: description,
                           type: type, isSoldOut: false, photoPath: photoPath)
        if menu == nil {
            menu = [Food]()
        }
        menu?.append(newFood)
        self.save()
    }

    public func deleteFood(id: String) {

    }

    /// Return the food object at a specified position in menu,
    /// nil if the index is out of bound
    /// - Parameter:
    ///     - index: the position in the menu array
    public func getFood(at index: Int) -> Food? {
        guard
            let maxIndex = menu?.count,
            index < maxIndex else {
            return nil
        }
        return menu?[index]
    }
}
