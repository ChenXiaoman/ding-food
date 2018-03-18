//
//  Order.swift
//  DingPod
//
//  Created by Jiang Chunhui on 17/03/18.
//  Copyright © 2018年 JCH. All rights reserved.
//

import Foundation

/// Represents an order posted by a user.
/// An order may have 
public struct Order: FirebaseObject {
    public let id: String
    public var status: OrderStatus = .preparing
    public var remark: String?
    public var review: Review?
    public var time: Date?
    public var shouldNotify = false
    public var content = Set<FoodTuple>()

    public init(id: String) {
        self.id = id
    }

    public mutating func add(food: Food, quantity: Int) {
        let tuple = FoodTuple(food: food, quantity: quantity)
        content.insert(tuple)
    }

    public mutating func delete(food: Food, quantity: Int) {
        let tuple = FoodTuple(food: food, quantity: quantity)
        content.remove(tuple)
    }

    public mutating func increaseQuantity(food: Food, quantity: Int) {
        delete(food: food, quantity: quantity)
        add(food: food, quantity: quantity + 1)
    }

    public mutating func decreaseQuantity(food: Food, quantity: Int) {
        delete(food: food, quantity: quantity)
        add(food: food, quantity: quantity - 1)
    }

    public mutating func confirm() {
        time = Date()
    }

    public mutating func addReview(_ review: Review) {
        self.review = review
    }

    public mutating func changeStatus(to newStatus: OrderStatus) {
        self.status = newStatus
    }
}
