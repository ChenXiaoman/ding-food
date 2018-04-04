//
//  Order.swift
//  DingPod
//
//  Created by Jiang Chunhui on 17/03/18.
//  Copyright © 2018 JCH. All rights reserved.
//

import Foundation

/**
 Represents an order posted by a user. An order may have various food with different
 quantities from the same stall.
 */
public struct Order: FirebaseObject {
    public static let path = "/orders"
    /// Used to handle all logics related to Firebase Auth.
    private static let authorizer = Authorizer()
    /// The format to display a certain kind of food with its amount.
    private static let foodDescriptionFormat = "x%d %@\n"

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
}
