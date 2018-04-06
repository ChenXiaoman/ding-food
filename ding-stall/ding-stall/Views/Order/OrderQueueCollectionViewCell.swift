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
    @IBOutlet weak private var customerName: UILabel!

    /// The identifer for this cell (in order to dequeue reusable cells).
    static let identifier = "OrderQueueCollectionViewCell"
    /// The aspect ratio of this cell.
    private static let aspectRatio = CGFloat(1.0 / 7)
    /// The width of this cell.
    static let width = Constants.screenWidth
    /// The height of this cell.
    static let height = Constants.screenHeight * OrderCollectionViewCell.aspectRatio

    override func awakeFromNib() {
        super.awakeFromNib()
//        self.layer.shadowColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
//        self.layer.shadowOffset = CGSize(width: 5, height: 5)
//        self.layer.shadowOpacity = 1
    }

    /// Loads data into and populate a `OngoingOrderCell`.
    /// - Parameter order: The `Order` object as the data source.
    func load(_ order: Order, customerName name: String) {
        customerName.text = name
        totalPrice.text = String(format: OrderCollectionViewCell.totalPriceFormat, order.totalPrice)
        orderDescription.text = order.description
        orderStatus.load(order.status)
    }

    func setStatus(to newStatus: OrderStatus) {
        orderStatus.load(newStatus)
    }
}
