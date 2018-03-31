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

    public let id: String
    var status: OrderStatus
    var review: Review?
    let stall: StallOverview
    let createdAt: Date
    let food: [Food: Int]
}

public enum OrderStatus: String, Codable {
    case rejected = "Rejected"
    case preparing = "Preparing"
    case ready = "Ready"
    case collected = "Collected"
}
