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
    @IBOutlet weak private var description: UILabel!
    @IBOutlet weak private var orderStatus: OrderStatusLabel!
    
    static let identifier = "ongoingOrderCell"
}
