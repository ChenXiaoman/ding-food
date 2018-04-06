//
//  StallOrderCell.swift
//  ding-stall
//
//  Created by Calvin Tantio on 2/4/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import UIKit

protocol StallOrderCellDelegate: class {
    func changeOrderStatus(for cell: UITableViewCell)
}

/*
 Table view cell for an order placed for a stall.
 */
class StallOrderCell: UITableViewCell {
    fileprivate struct BackgroundColor {
        static let red: UIColor = UIColor(red: 1, green: 0.3, blue: 0.3, alpha: 1)      // .rejected
        static let yellow: UIColor = UIColor(red: 1, green: 1, blue: 0.1, alpha: 1)     // .preparing
        static let green: UIColor = UIColor(red: 0.3, green: 1, blue: 0.2, alpha: 1)    // .ready
        static let blue: UIColor = UIColor(red: 0.4, green: 0.8, blue: 1, alpha: 1)     // .collected
    }

    public static let identifier = "StallOrderCell"

    @IBOutlet private weak var userNameLabel: UILabel!
    @IBOutlet private weak var remarkLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private weak var orderLabel: UILabel!

    @IBOutlet private weak var statusButton: UIButton!

    weak var delegate: StallOrderCellDelegate!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func load(_ order: Order) {
        setLabels(order: order)
        setButton(order: order)
        setBackgroundColor(order: order)
    }

    private func setLabels(order: Order) {
        userNameLabel.text = order.customerId
        remarkLabel.text = order.remark
        priceLabel.text = "Total: $\(order.totalPrice)"
        setOrderLabel(order: order)
    }

    private func setOrderLabel(order: Order) {
        orderLabel.text = "Order:\n\n"
        for key in order.foodName.keys {
            let foodName = order.foodName[key]!
            let quantity = order.foodQuantity[key]!
            orderLabel.text = orderLabel.text! + "\(foodName) (\(quantity))\n"
        }
    }

    private func setButton(order: Order) {
        statusButton.setTitle(order.status.rawValue.capitalized, for: .normal)
        statusButton.addTarget(self, action: #selector(statusButtonPressed), for: .touchUpInside)
    }

    // pressing button advances the order status
    @objc
    private func statusButtonPressed() {
        delegate.changeOrderStatus(for: self)
    }

    // background color of cell depends on order status
    private func setBackgroundColor(order: Order) {
        switch order.status {
        case .rejected:
            backgroundColor = BackgroundColor.red
        case .preparing:
            backgroundColor = BackgroundColor.yellow
        case .ready:
            backgroundColor = BackgroundColor.green
        case .collected:
            backgroundColor = BackgroundColor.blue
        }
    }
}

