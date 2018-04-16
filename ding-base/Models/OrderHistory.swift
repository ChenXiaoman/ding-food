//
//  OrderHistory.swift
//  ding-stall
//
//  Created by Jiang Chunhui on 06/04/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

/**
 `OrderHistory` represents a `Order` that has been collected or rejeted. In such
 case, the `OrderHistory` may optionally contain a `Review`.

 - Author: Group 3 @ CS3217
 - Date: March 2018
 */
public struct OrderHistory: DatabaseObject {
    public static let path = "order_history"
    public static let orderPath = "order"
    public var id: String
    /// The composed order with the order history
    public var order: Order
    public var review: Review?

    public init(order: Order, review: Review? = nil) {
        id = order.id
        self.order = order
        self.review = review
    }
}
