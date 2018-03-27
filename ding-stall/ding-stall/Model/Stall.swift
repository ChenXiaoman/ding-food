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
    public var name: String
    public var location: String
    public var openingHour: String
    public var description: String
    public var queue: [Order]
    public var menu: [Food]
    public var filters: Set<FilterIdentifier>

    public mutating func addFood(name: String, price: Double, description: String?, type: FoodType) {
        let id = Food.getAutoId()
        let newFood = Food(id: id, name: name, price: price, description: description,
                           type: type, isSoldOut: false)
        menu.append(newFood)
        newFood.save()
        self.save()
    }

    public func deleteFood(id: String) {

    }

}
