//
//  ShoppingCart.swift
//  ding
//
//  Created by Yunpeng Niu on 31/03/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

/**
 `ShoppingCart` is a collection of food with different quantities. It represents the
 state when an `Order` has not been submitted by the customer.

 Since the food for each `Order` can only come from the same stall, the food in a
 `ShoppingCart` can also only come from the same stall.

 - Author: Group 3 @ CS3217
 - Date: March 2018
 */
struct ShoppingCart {
    /// A collection of food with different quantities.
    var food: [String: (food: Food, quantity: Int)] = [:]
    /// The stall of the shopping cart.
    let stall: StallOverview
    /// Let the shopping cart work like a "global variable", i.e., a mapping between
    /// stall ids and shopping carts.
    static var shoppingCarts: [String: ShoppingCart] = [:]

    /// Adds an amount of a kind of food from a certain stall to the shopping cart.
    /// - Parameters:
    ///    - toAdd: The kind of food to be added.
    ///    - stall: The stall from which the food is.
    ///    - quantity: The amount of this kind of food.
    static func add(_ toAdd: Food, from stall: StallOverview, quantity: Int) {
        guard var cart = shoppingCarts[stall.id] else {
            var newCart = ShoppingCart(food: [:], stall: stall)
            newCart.add(toAdd, quantity: quantity)
            shoppingCarts[stall.id] = newCart
            return
        }
        cart.add(toAdd, quantity: quantity)
        shoppingCarts[stall.id] = cart
    }

    /// Changes amount of a kind of food from a certain stall. It will simply do nothing
    /// if either the stall's shopping cart or the food does not exist before.
    /// - Parameters:
    ///    - foodId: The id of food to be changed.
    ///    - stallId: The id of the stall from which the food is.
    ///    - quantity: The amount of this kind of food.
    static func change(_ foodId: String, from stallId: String, quantity: Int) {
        guard var cart = shoppingCarts[stallId] else {
            return
        }
        cart.change(foodId, quantity: quantity)
        // Removes the shopping cart if it is already empty.
        if cart.food.isEmpty {
            shoppingCarts[stallId] = nil
        } else {
            shoppingCarts[stallId] = cart
        }
    }

    /// Checks whether a certain kind of food from a certain stall exists before.
    /// - Parameters:
    ///    - foodId: The id of the food to be checked.
    ///    - stallId: The id of the stall from which the food is.
    /// - Returns: true if it exists; false otherwise.
    static func has(_ foodId: String, from stallId: String) -> Bool {
        guard let cart = shoppingCarts[stallId] else {
            return false
        }
        return cart.has(foodId)
    }

    /// Adds a certain amount of a kind of food to the shopping cart. If this kind of
    /// food is already in the shopping cart before, its amount will be overwritten.
    /// - Parameters:
    ///    - toAdd: The kind of food to be added.
    ///    - quantity: The amount of this kind of food.
    mutating func add(_ toAdd: Food, quantity: Int) {
        self.food[toAdd.id] = (toAdd, quantity)
    }

    /// Changes the amount of food in the shopping cart. It will simply do nothing if
    /// the food does not exist before. If the new amount of the food is 0, it will
    /// delete the food.
    /// - Parameters:
    ///    - foodId: The id of food to be changed.
    ///    - quantity: The amount of this kind of food.
    mutating func change(_ foodId: String, quantity: Int) {
        guard let foodInfo = food[foodId], quantity >= 0 else {
            return
        }
        // Deletes food if the new amount is 0.
        if quantity == 0 {
            delete(foodId)
        } else {
            food[foodId] = (foodInfo.food, quantity)
        }
    }

    /// Deletes a certain kind of food from the shopping cart. If this kind of food
    /// does not exist, it will simply do nothing.
    /// - Parameter food: The kind of food to be deleted.
    mutating func delete(_ toDelete: Food) {
        food[toDelete.id] = nil
    }

    /// Deletes a certain kind of food from the shopping cart. If this kind of food
    /// does not exist, it will simply do nothing.
    /// - Parameter foodId: The id of food to be deleted.
    mutating func delete(_ foodId: String) {
        food[foodId] = nil
    }

    /// Checks whether a certain kind of food exists in the shopping cart.
    /// - Parameter foodId: The id of the food to be checked.
    /// - Returns: true if it exists; false otherwise.
    func has(_ foodId: String) -> Bool {
        return food[foodId] != nil
    }

    /// Converts the `ShoppingCart` into an order.
    /// - Returns: The `Order` converted.
    func toOrder() -> Order {
        var foodAmount: [Food: Int] = [:]
        food.values.forEach { foodAmount[$0.food] = $0.quantity }
        return Order(stall: stall, food: foodAmount)
    }

    /// Converts all `ShoppingCart`s into an array of orders.
    /// - Returns: An array of `Order`s converted.
    static func toOrders() -> [Order] {
        return shoppingCarts.map { $0.value.toOrder() }
    }
}
