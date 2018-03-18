//
//  User.swift
//  DingPod
//
//  Created by Jiang Chunhui on 17/03/18.
//  Copyright © 2018 JCH. All rights reserved.
//

/// Represents a registered user in the application.
public struct User: FirebaseObject {
    public var name: String
    /// This id is the user's email
    public var id: String
    public var password: String
    private var historyOrder: Set<Order>

    mutating func addOrder(_ order: Order) {
        historyOrder.insert(order)
    }
}
