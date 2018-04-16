//
//  OrderQueueCollectionViewCell.swift
//  ding-stall
//
//  Created by Chen Xiaoman on 24/3/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import DingBase
import SwiftyButton

class OrderQueueCollectionViewCell: OrderCollectionViewCell {

    /// The identifer for this cell (in order to dequeue reusable cells).
    static let identifier = "OrderQueueCollectionViewCell"

    @IBOutlet weak private var mainButton: PressableButton!
    @IBOutlet weak private var viceButton: PressableButton!

    /// Change the status label to a newStatus
    /// Parameter: newStatus: The new status to change
    override func setStatus(to newStatus: OrderStatus) {
        super.setStatus(to: newStatus)
        toggleButton(byStatus: newStatus)
    }

    /// Toggle the button (text and color) after the order status has changed
    private func toggleButton(byStatus status: OrderStatus) {
        let shadowColor = UIColor.fromRGB(0x2980b9)
        switch status {
        case .pending:
            mainButton.setTitle(OrderStatus.accepted.rawValue, for: .normal)
            mainButton.colors = .init(button: UIColor.fromRGB(0xefa647), shadow: shadowColor)
            viceButton.setTitle(OrderStatus.rejected.rawValue, for: .normal)
            viceButton.colors = .init(button: UIColor.fromRGB(0x706a6a), shadow: shadowColor)
            viceButton.isHidden = false
        case .accepted:
            mainButton.setTitle(OrderStatus.ready.rawValue, for: .normal)
            mainButton.colors = .init(button: UIColor.fromRGB(0x93e83a), shadow: shadowColor)
            viceButton.isHidden = true
        case .ready:
            mainButton.setTitle(OrderStatus.collected.rawValue, for: .normal)
            mainButton.colors = .init(button: UIColor.fromRGB(0xf47141), shadow: shadowColor)
            viceButton.isHidden = true
        default:
            break
        }
    }
}
