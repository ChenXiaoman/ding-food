//
//  User.swift
//  DingPod
//
//  Created by Jiang Chunhui on 17/03/18.
//  Copyright © 2018 JCH. All rights reserved.
//

public struct User: FirebaseObject {
    public var name: String
    /// This id is the user's email
    public var id: String
    public var password: String
    private var historyOrder: Set<Order>

    mutating func addOrder(_ order: Order) {
        historyOrder.insert(order)
    }

    public var hashValue: Int {
        return id.hashValue
    }

    public static func == (lhs: User, rhs: User) -> Bool {
        return lhs.id == rhs.id
            && lhs.name == rhs.name
            && lhs.password == rhs.password
    }
}
