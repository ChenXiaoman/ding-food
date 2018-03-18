//
//  Order.swift
//  DingPod
//
//  Created by Jiang Chunhui on 17/03/18.
//  Copyright © 2018年 JCH. All rights reserved.
//

import Foundation

public struct Order: Hashable {

    var status: OrderStatus = .preparing
    var remark: String?
    var review: Review?
    // TODO: perhaps use dictionary is better
    var content = Set<OrderTuple>()
    var time: Date?
    var shouldNotify = false

    public init() {}

    public mutating func add(food: Food, quantity: Int) {
        let tuple = OrderTuple(food: food, quantity: quantity)
        content.insert(tuple)
    }

    public mutating func delete(food: Food, quantity: Int) {
        let tuple = OrderTuple(food: food, quantity: quantity)
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

    public var hashValue: Int {
        return content.hashValue
    }

    public static func ==(lhs: Order, rhs: Order) -> Bool {
        return lhs.content == rhs.content
    }
}

public enum OrderStatus {
    case preparing
    case ready
    case collected
}

