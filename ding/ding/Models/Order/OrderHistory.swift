//
//  OrderHistory.swift
//  ding-stall
//
//  Created by Jiang Chunhui on 06/04/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

public struct OrderHistory: DatabaseObject {
    public static let path = "order_history"
    public static let orderPath = "order"
    public var id: String
    /// The composed order with the order history
    public var order: Order
    public var review: Review?

    public init(order: Order, review: Review) {
        id = order.id
        self.order = order
        self.review = review
    }
}
