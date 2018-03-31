//
//  OrderTableViewCell.swift
//  ding
//
//  Created by Chen Xiaoman on 22/3/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import UIKit

/**
 The cell for the collection view in ongoing orders.

 - Author: Group 3 @ CS3217
 - Date: March 2018
 */
class OngoingOrderCell: UICollectionViewCell {
    @IBOutlet weak private var stallName: UILabel!
    @IBOutlet weak private var stallPhoto: UIImageView!
    @IBOutlet weak private var totalPrice: UILabel!
    @IBOutlet weak private var orderDescription: UILabel!
    @IBOutlet weak private var orderStatus: OrderStatusLabel!
    
    static let identifier = "ongoingOrderCell"
    /// The aspect ratio of this cell.
    private static let aspectRatio = CGFloat(1.0 / 3)
    /// The width of this cell.
    static let width = Constants.screenWidth
    /// The height of this cell.
    static let height = StallListingCell.width * OngoingOrderCell.aspectRatio
}
