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
    public static var path = "/order"

    public let id: String
    public var status: OrderStatus = .preparing // Default value when an order is placed
    public var remark: String?  // TODO: Remark should be more complicated than this
    public var review: Review?
    public var time: Date?
    public var shouldNotify = false
    public var content = [Food: Int]()

    public init(id: String) {
        self.id = id
    }

    public mutating func add(food: Food, quantity: Int) {
        content[food] = quantity
    }

    public mutating func delete(food: Food) {
        content.removeValue(forKey: food)
    }

    public mutating func increaseQuantity(food: Food) {
        guard let currentQuantity = content[food] else {
            return
        }
        content[food] = currentQuantity + 1
    }

    public mutating func decreaseQuantity(food: Food, quantity: Int) {
        guard let currentQuantity = content[food] else {
            return
        }
        content[food] = currentQuantity - 1
    }

    public mutating func confirm() {
        time = Date()
    }
}
