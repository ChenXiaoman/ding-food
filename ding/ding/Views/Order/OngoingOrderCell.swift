//
//  OrderTableViewCell.swift
//  ding
//
//  Created by Chen Xiaoman on 22/3/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import FirebaseDatabaseUI

/**
 The cell for the collection view in ongoing orders.

 - Author: Group 3 @ CS3217
 - Date: March 2018
 */
class OngoingOrderCell: UICollectionViewCell {
    /// The format to display total price.
    private static let totalPriceFormat = "$%.2f"

    @IBOutlet weak private var stallName: UILabel!
    @IBOutlet weak private var stallPhoto: UIImageView!
    @IBOutlet weak private var totalPrice: UILabel!
    @IBOutlet weak private var orderDescription: UILabel!
    @IBOutlet weak private var orderStatus: OrderStatusLabel!

    /// The identifer for this cell (in order to dequeue reusable cells).
    static let identifier = "ongoingOrderCell"
    /// The aspect ratio of height of this cell.
    private static let aspectRatioOfHeight = CGFloat(1.0 / 3)
    /// The aspect ratio of of width this cell.
    private static let aspectRatioOfWidth = CGFloat(19.0 / 20)
    /// The width of this cell.
    static let width = Constants.screenWidth * aspectRatioOfWidth
    /// The height of this cell.
    static let height = StallListingCell.width * OngoingOrderCell.aspectRatioOfHeight

    /// Loads data into and populate a `OngoingOrderCell`.
    /// - Parameter order: The `Order` object as the data source.
    func load(_ order: Order) {
        // Load order details
        totalPrice.text = String(format: OngoingOrderCell.totalPriceFormat, order.totalPrice)
        orderDescription.text = order.description
        orderStatus.load(order.status)
    }

    /// Loads data (about stal) into a `OngoingOrderCell`.
    /// - Parameter snapshot: The database snapshot containing a `StallOverview` object.
    func loadStoreOverview(from snapshot: DataSnapshot) {
        guard let stall = StallOverview.deserialize(snapshot) else {
            return
        }
        stallPhoto.setWebImage(at: stall.photoPath, placeholder: #imageLiteral(resourceName: "stall-placeholder"))
        stallPhoto.clipsToBounds = true // Use for enable corner radius
        stallName.text = stall.name

        // Stop observer after getting stall details
        DatabaseRef.stopObservers(of: "\(StallOverview.path)/\(stall.id)")
    }
    
    /// Get the stall photo for current cell
    func getStallPhoto() -> UIImage? {
        return stallPhoto.image
    }
    
    /// Get the stall name for current cell
    func getStallName() -> String? {
        return stallName.text
    }
}
