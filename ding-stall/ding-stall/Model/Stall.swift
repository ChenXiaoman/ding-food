//
//  Stall.swift
//  ding
//
//  Created by Calvin Tantio on 17/3/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

/**
 Represents a food stall registered in the application.
 */
public struct Stall: FirebaseObject {
    public static var path = "/stall"

    public let id: String
    public var name = "valid name"
    public var location = "valid location"
    public var openingHour = "0800-2100"
    public var description = "valid desc"
    public var menu: [Food]?
    public var queue: [Order]?
    public var filters: Set<FilterIdentifier>?

    public init(id: String) {
        self.id = id
        self.save()
    }

    /// Add the s
    public mutating func addFood(name: String, price: Double, description: String?, type: FoodType) {
        let id = Food.getAutoId
        let newFood = Food(id: id, name: name, price: price, description: description,
                           type: type, isSoldOut: false)
        if menu == nil {
            menu = [Food]()
        }
        menu?.append(newFood)
        //newFood.save()
        self.save()
    }

    public func deleteFood(id: String) {

    }

    public func getFood(at index: Int) -> Food? {
        guard
            let maxIndex = menu?.count,
            index < maxIndex else {
            return nil
        }
        return menu?[index]
    }
}
