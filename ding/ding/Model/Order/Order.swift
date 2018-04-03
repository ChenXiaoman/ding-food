//
//  Order.swift
//  DingPod
//
//  Created by Jiang Chunhui on 17/03/18.
//  Copyright © 2018 JCH. All rights reserved.
//

import Foundation

/**
 `Order` represents a collection of food with certain quantities. An `Order` is
 submitted by the customer and confirmed by the stall owner.

 - Author: Group 3 @ CS3217
 - Date: March 2018
 */
public struct Order: FirebaseObject {
    public static let path = "/orders"
    /// Used to handle all logics related to Firebase Auth.
    private static let authorizer = Authorizer()

    public let id: String
    var status: OrderStatus
    var review: Review?
    let customerId: String
    let stallId: String
    let createdAt: Date
    /// A mapping from food id to its quantity.
    let foodQuantity: [String: Int]
    /// A mapping from food id to its human-readable name (to apply fan-out & denormalization
    /// pattern here).
    let foodName: [String: String]
    /// A pre-computed total price to improve efficiency. Another consideration is that the
    /// total price should not be affected by changes to prices after the order is created.
    let totalPrice: Double

    init(status: OrderStatus = .preparing, review: Review? = nil, stall: StallOverview, food: [Food: Int]) {
        id = Order.getAutoId
        self.status = status
        self.review = review
        customerId = Order.authorizer.userId
        stallId = stall.id
        createdAt = Date()
        var foodQuantity: [String: Int] = [:]
        var foodName: [String: String] = [:]
        food.forEach { key, value in
            foodQuantity[key.id] = value
            foodName[key.id] = key.name
        }
        self.foodQuantity = foodQuantity
        self.foodName = foodName
        totalPrice = food.reduce(0.0) { sum, now in
            sum + now.key.price * Double(now.value)
        }
    }

    /// A full-text description of the order (including food name and amount).
    var description: String {
        return ""
    }
}

public enum OrderStatus: String, Codable {
    case rejected = "Rejected"
    case preparing = "Preparing"
    case ready = "Ready"
    case collected = "Collected"
}
