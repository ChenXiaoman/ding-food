//
//  OrderStatusLabel.swift
//  ding
//
//  Created by Yunpeng Niu on 31/03/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import UIKit

/**
 A customized `UILabel` to display order status.

 - Author: Group 3 @ CS3217
 - Date: March 2018
 */
public class OrderStatusLabel: UILabel {
    /// The corner radius for this label.
    private static let cornerRadius = CGFloat(10)
    /// The insets around the text of this label.
    private static let insets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    /// The inverted insets around the text of this label.
    private static let invertedInsets = UIEdgeInsets(top: 0, left: -5, bottom: 0, right: -5)

    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = OrderStatusLabel.cornerRadius
        clipsToBounds = true
        invalidateIntrinsicContentSize()
        text = nil
        backgroundColor = nil
    }

    override func drawText(in rect: CGRect) {
        super.drawText(in: UIEdgeInsetsInsetRect(rect, OrderStatusLabel.insets))
    }

    override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        let insetRect = UIEdgeInsetsInsetRect(bounds, OrderStatusLabel.insets)
        let textRect = super.textRect(forBounds: insetRect, limitedToNumberOfLines: numberOfLines)
        return UIEdgeInsetsInsetRect(textRect, OrderStatusLabel.invertedInsets)
    }

    /// Loads data into and populate a `OrderStatusLabel`.
    /// - Parameter status: The `OrderStatus` enum as the data source.
    public func load(_ status: OrderStatus) {
        text = status.rawValue
        switch status {
        case .pending:
            backgroundColor = .fromRGB(0x6bbdef)
        case .accepted:
            backgroundColor = .fromRGB(0xefa647)
        case .ready:
            backgroundColor = .fromRGB(0x93e83a)
        case .rejected:
            backgroundColor = .fromRGB(0x706a6a)
        case .collected:
            backgroundColor = .fromRGB(0xf47141)
        }
    }
}
