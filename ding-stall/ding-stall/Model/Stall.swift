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
    public var menu: [String: Food]?
    private var menuSequence: [Food]? {
        guard let allFood = menu?.values else {
            return nil
        }
        return Array(allFood)
    }
    public var queue: [Order]?

    public var filters: Set<FilterIdentifier>?

    /// Add the a new kind of food into menu
    /// - Parameter:
    ///    - addedFood: The food to be added in menu
    public mutating func addFood(_ addedFood: Food) {
        if menu == nil {
            menu = [String: Food]()
        }
        menu?[addedFood.id] = addedFood
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
        return menuSequence?[index]
    }
}
