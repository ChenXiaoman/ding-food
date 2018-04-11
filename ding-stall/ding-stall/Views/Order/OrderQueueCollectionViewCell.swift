//
//  OrderQueueCollectionViewCell.swift
//  ding-stall
//
//  Created by Chen Xiaoman on 24/3/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import UIKit

class OrderQueueCollectionViewCell: OrderCollectionViewCell {

    @IBOutlet weak private var rejectButton: UIButton!
    @IBOutlet weak private var collectButton: UIButton!
    @IBOutlet weak private var readyButton: UIButton!

    /// Change the status label to a newStatus
    /// Parameter: newStatus: The new status to change
    override func setStatus(to newStatus: OrderStatus) {
        super.setStatus(to: newStatus)
        toggleButton(byStatus: newStatus)
    }

    /// Toggle the button (enable or disable) after the order status has changed
    private func toggleButton(byStatus status: OrderStatus) {
        readyButton.isEnabled = status == .preparing
        rejectButton.isEnabled = status == .preparing
        collectButton.isEnabled = status == .ready
    }
}
