//
//  Tuple.swift
//  DingPod
//
//  Created by Jiang Chunhui on 17/03/18.
//  Copyright © 2018年 JCH. All rights reserved.
//

public struct Tuple<T: Hashable & Codable, H: Hashable & Codable>: Codable {
    let attribute1: T
    let attribute2: H
    init(_ attr1: T, _ attr2: H) {
        attribute1 = attr1
        attribute2 = attr2
    }
}

extension Tuple: Hashable {
    public var hashValue: Int {
        return attribute1.hashValue ^ attribute2.hashValue
    }

    public static func == (lhs: Tuple<T, H>, rhs: Tuple<T, H>) -> Bool {
        return lhs.attribute1 == rhs.attribute1 && lhs.attribute2 == rhs.attribute2
    }
}

public struct FoodTuple: Hashable, Codable {
    var order: Tuple<Food, Int>
    var food: Food {
        return order.attribute1
    }
    var quantity: Int {
        return order.attribute2
    }

    public init(food: Food, quantity: Int) {
        order = Tuple<Food, Int>(food, quantity)
    }

    public var hashValue: Int {
        return order.hashValue
    }
    public static func == (lhs: FoodTuple, rhs: FoodTuple) -> Bool {
        return lhs.order == rhs.order
    }
}
