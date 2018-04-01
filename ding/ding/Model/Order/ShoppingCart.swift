//
//  ShoppingCart.swift
//  ding
//
//  Created by Yunpeng Niu on 31/03/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import Foundation

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
    var food: [Food: Int] = [:]
    /// The stall of the shopping cart.
    let stall: StallOverview
    /// Let the shopping cart work like a "global variable".
    static var shoppingCarts: [String: ShoppingCart] = [:]

    /// Adds a certain amount of a kind of food from a certain stall to (or changes the
    /// amount of a certain food from) the shopping cart.
    /// - Parameters:
    ///    - toAdd: The kind of food to be added.
    ///    - stall: The stall from which the food is.
    ///    - quantity: The amount of this kind of food.
    static func addOrChange(_ toAdd: Food, from stall: StallOverview, quantity: Int) {
        guard var cart = shoppingCarts[stall.id] else {
            var newCart = ShoppingCart(food: [:], stall: stall)
            newCart.addOrChange(toAdd, quantity: quantity)
            shoppingCarts[stall.id] = newCart
            return
        }
        cart.addOrChange(toAdd, quantity: quantity)
        shoppingCarts[stall.id] = cart
    }

    static func change(_ foodId: String, from stallId: String, quantity: Int) {

    }

    /// Adds or changes to a certain amount of a kind of food to the shopping cart. If
    /// this kind of food is already in the shopping cart before, its amount will be
    /// overwritten.
    /// - Parameters:
    ///    - toAdd: The kind of food to be added.
    ///    - quantity: The amount of this kind of food.
    mutating func addOrChange(_ toAdd: Food, quantity: Int) {
        food[toAdd] = quantity
    }

    /// Deletes a certain kind of food from the shopping cart. If this kind of food
    /// does not exist, it will simply do nothing.
    /// - Parameter food: The kind of food to be deleted.
    mutating func delete(toDelete: Food) {
        food[toDelete] = nil
    }

    func toOrder() -> Order {
        return Order(id: Order.getAutoId, status: .preparing, review: nil,
                     stallId: stall.id, createdAt: Date(), food: food)
    }
    
    /// - Returns: An array of `Order`s converted.
    static func toOrders() -> [Order] {
        return shoppingCarts.map { $0.value.toOrder() }
    }
}
