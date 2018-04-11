//
//  OrderCollectionViewCell.swift
//  ding-stall
//
//  Created by Jiang Chunhui on 11/04/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import UIKit

class OrderCollectionViewCell: UICollectionViewCell {
    /// The format to display total price.
    private static let totalPriceFormat = "$%.2f"
    /// The identifer for this cell (in order to dequeue reusable cells).
    static let identifier = "OrderQueueCollectionViewCell"
    /// The aspect ratio of this cell.
    private static let aspectRatio = CGFloat(1.0 / 7)
    /// The width of this cell.
    static let width = Constants.screenWidth
    /// The height of this cell.
    static let height = Constants.screenHeight * OrderQueueCollectionViewCell.aspectRatio

    @IBOutlet weak private var totalPrice: UILabel!
    @IBOutlet weak private var orderDescription: UILabel!
    @IBOutlet weak private var orderStatus: OrderStatusLabel!
    @IBOutlet weak private var customerName: UILabel!

    /// Loads data into and populate a `OngoingOrderCell`.
    /// - Parameter: order: The `Order` object as the data source.
    func load(_ order: Order) {
        totalPrice.text = String(format: OrderCollectionViewCell.totalPriceFormat, order.totalPrice)
        orderDescription.text = order.description
        setStatus(to: order.status)
    }

    /// Populate the customer name into cell, since this requires to
    /// download customer object separately, it should be separated
    /// from populating food information
    /// - Parameter: name: The customer name to be put into
    func populateName(_ name: String) {
        customerName.text = name
    }

    /// Change the status label to a newStatus
    /// Parameter: newStatus: The new status to change
    func setStatus(to newStatus: OrderStatus) {
        orderStatus.load(newStatus)
    }
}
