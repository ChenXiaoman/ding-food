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

    public static var path = "/JCHstall"

    public let id: String

    public var location: String
    public var openingHour: String
    public var description: String
    public var menu: [String: Food]?
    public var queue: [Order]?

    public var filters: Set<FilterIdentifier>?
    private var menuPath: String {
        return Stall.path + "/\(Account.stallId)" + Food.path
    }

    /// Add the a new kind of food into menu
    /// - Parameter:
    ///    - addedFood: The food to be added in menu
    public mutating func addFood(_ addedFood: Food) {
        if menu == nil {
            menu = [String: Food]()
        }
        menu?[addedFood.id] = addedFood
        self.save()
        //DatabaseRef.setChildNode(of: menuPath, to: addedFood)
    }

    /// Delete the certain food by its id. If the food has photo, it will also be removed from storage
    /// do nothing if the food id does not exist in menu.
    /// - Parameter: id: the food id
    public mutating func deleteFood(by id: String) {
        guard let foodToDelete = menu?[id] else {
            return
        }
        // Remove the food photo from storage if applicable
        if let photoPath = foodToDelete.photoPath {
            StorageRef.delete(at: photoPath)
        }
        menu?[id] = nil
        self.save()
        //DatabaseRef.deleteChildNode(of: menuPath + "/\(id)")
    }

    public mutating func updateFood(to food: Food) {
        menu?[food.id] = food
        DatabaseRef.setChildNode(of: menuPath, to: food)
    }
}
