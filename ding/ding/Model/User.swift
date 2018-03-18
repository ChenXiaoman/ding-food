//
//  User.swift
//  DingPod
//
//  Created by Jiang Chunhui on 17/03/18.
//  Copyright © 2018年 JCH. All rights reserved.
//

public struct User {
    var name: String
    var email: String
    var password: String
    private var historyOrder: Set<Order>

    mutating func addOrder(_ order: Order) {
        historyOrder.insert(order)
    }

}
