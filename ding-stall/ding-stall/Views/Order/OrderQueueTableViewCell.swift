//
//  OrderCollectionViewCell.swift
//  ding-stall
//
//  Created by Chen Xiaoman on 24/3/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import UIKit

class OrderCollectionViewCell: UICollectionViewCell {
    @IBOutlet private var status: UILabel!

    /// The identifier for this reusable cell
    public static let identifier = "OrderQueueCollectionViewCell"
    
    func setStatus(to newStatus: String) {
        status.text = newStatus
    }

    func load(_ order: Order) {}
}
