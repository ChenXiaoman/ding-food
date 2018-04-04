//
//  OrderCollectionViewCell.swift
//  ding-stall
//
//  Created by Chen Xiaoman on 24/3/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import UIKit

class OrderCollectionViewCell: UICollectionViewCell {
    /// The format to display total price.
    private static let totalPriceFormat = "$%.2f"

    @IBOutlet weak private var totalPrice: UILabel!
    @IBOutlet weak private var orderDescription: UILabel!
    @IBOutlet weak private var orderStatus: OrderStatusLabel!

    /// The identifer for this cell (in order to dequeue reusable cells).
    static let identifier = "OrderQueueCollectionViewCell"
    /// The aspect ratio of this cell.
    private static let aspectRatio = CGFloat(1.0 / 3)
    /// The width of this cell.
    static let width = Constants.screenWidth
    /// The height of this cell.
    static let height = Constants.screenHeight * OngoingOrderCell.aspectRatio

    /// Loads data into and populate a `OngoingOrderCell`.
    /// - Parameter order: The `Order` object as the data source.
    func load(_ order: Order) {
        totalPrice.text = String(format: OrderCollectionViewCell.totalPriceFormat, order.totalPrice)
        orderDescription.text = order.description
        orderStatus.load(order.status)
    }
}
