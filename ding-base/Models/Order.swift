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
public struct Order: DatabaseObject {
    public static let path = "/orders"
    public static let custemerIdPath = "/customerId"
    /// Used to handle all logics related to Firebase Auth.
    private static let authorizer = Authorizer()
    /// The format to display a certain kind of food with its amount and options.
    private static let foodDescriptionFormat = "x%d %@ (%@)\n"
    /// The format to display food's options.
    private static let foodOptionFormat = "%@ %@: %@"

    public let id: String
    public var status: OrderStatus {
        didSet {
            guard status.isOngoingOrderStatus else {
                delete()
                let orderHistory = OrderHistory(order: self)
                orderHistory.save()
                return
            }
        }
    }
    public let customerId: String
    public let stallId: String
    public let createdAt: Date
    /// A mapping from food id to its quantity.
    public let foodQuantity: [String: Int]
    /// A mapping from food id to its human-readable name (to apply fan-out & denormalization
    /// pattern here).
    public let foodName: [String: String]
    /// A mapping from food id to the
    /// mapping of option to user's choice for the option
    public let options: [String: [String: String]]?
    /// A pre-computed total price to improve efficiency. Another consideration is that the
    /// total price should not be affected by changes to prices after the order is created.
    public let totalPrice: Double

    public init(stall: StallOverview, food: [Food: Int], options: [Food: [String: String]]) {
        id = Order.getAutoId
        // Default status is pending
        self.status = .pending
        customerId = Order.authorizer.userId
        stallId = stall.id
        createdAt = Date()
        
        // Transform food object in dictionary to food id
        var foodQuantity: [String: Int] = [:]
        var foodName: [String: String] = [:]
        food.forEach { key, value in
            foodQuantity[key.id] = value
            foodName[key.id] = key.name
        }
        
        // Transform food object  in dictionary to food id
        var foodOptions: [String: [String: String]] = [:]
        options.forEach { key, value in
            foodOptions[key.id] = value
        }
        
        self.foodQuantity = foodQuantity
        self.foodName = foodName
        self.options = foodOptions
        self.totalPrice = food.reduce(0.0) { sum, now in
            sum + now.key.price * Double(now.value)
        }
    }
}

// MARK: CustomStringConvertible
extension Order: CustomStringConvertible {
    /// A full-text description of the order (including food name, amount and options).
    public var description: String {
        return foodQuantity.reduce("") { accum, current in
            let name = foodName[current.key] ?? ""
            let option = options?[current.key] ?? [:]
            let foodOption = option.reduce("") { acc, cur in
                String(format: Order.foodOptionFormat, acc, cur.key, cur.value)
            }
            return accum + String(format: Order.foodDescriptionFormat, current.value, name, foodOption)
        }
    }
}

public enum OrderStatus: String, Codable {
    case rejected = "Rejected"
    case pending = "Pending"
    case accepted = "Accepted"
    case ready = "Ready"
    case collected = "Collected"

    /// Indicate whether this order is an on-going (unpaid) order, i.e.
    /// should be displayed on the order list.
    public var isOngoingOrderStatus: Bool {
        return self == .pending || self == .accepted || self == .ready
    }
}
