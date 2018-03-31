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
    private var food: [Food: Int] = [:]
    /// Let the shopping cart work like a "global variable".
    private static var shoppingCarts: [StallOverview: ShoppingCart] = [:]

    static func cartFor(_ stall: StallOverview) -> ShoppingCart {
        guard let cart = shoppingCarts[stall] else {
            let newCart = ShoppingCart(food: [:])
            shoppingCarts[stall] = newCart
            return newCart
        }
        return cart
    }

    /// Adds a certain amount of a kind of food to the shopping cart. If this kind of food
    /// is already in the shopping cart before, its amount will be overwritten.
    /// - Parameters:
    ///    - toAdd: The kind of food to be added.
    ///    - quantity: The amount of this kind of food.
    mutating func add(_ toAdd: Food, quantity: Int) {
        food[toAdd] = quantity
    }

    /// Deletes a certain kind of food from the shopping cart. If this kind of food
    /// does not exist, it will simply do nothing.
    /// - Parameter food: The kind of food to be deleted.
    mutating func delete(toDelete: Food) {
        food[toDelete] = nil
    }

    /// Increments the amount of a kind of food by 1.
    /// - Parameter toChange: The kind of food to be changed.
    mutating func incrementByOne(_ toChange: Food) {
        guard let currentQuantity = food[toChange] else {
            return
        }
        food[toChange] = currentQuantity + 1
    }

    /// Decrements the amount of a kind of food by 1.
    /// - Parameter toChange: The kind of food to be changed.
    mutating func decrementByOne(_ toChange: Food) {
        guard let currentQuantity = food[toChange] else {
            return
        }
        food[toChange] = currentQuantity - 1
    }

    /// Converts a `ShoppingCart` to an `Order`, whose food should be the same. This method
    /// should be called when the customer submits the order.
    /// - Returns: The `Order` converted.
    static func toOrder(from stall: StallOverview) -> Order {
        let id = Order.getAutoId
        let cart = cartFor(stall)
        return Order(id: id, status: .preparing, review: nil, stall: stall, createdAt: Date(), food: cart.food)
    }
}
