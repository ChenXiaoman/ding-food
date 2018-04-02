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
    let customerId = Order.authorizer.userId
    let stallId: String
    let createdAt: Date
    /// A mapping from food id to its quantity.
    let foodQuantity: [String: Int]
    /// A mapping from food id to its human-readable name (to apply fan-out & denormalization
    /// pattern here).
    let foodName: [String: String]
}

public enum OrderStatus: String, Codable {
    case rejected = "Rejected"
    case preparing = "Preparing"
    case ready = "Ready"
    case collected = "Collected"
}
