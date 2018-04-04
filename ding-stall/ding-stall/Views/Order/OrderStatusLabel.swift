//
//  OrderStatusLabel.swift
//  ding-stall
//
//  Created by Jiang Chunhui on 04/04/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import UIKit

/**
 A customized `UILabel` to display order status.

 - Author: Group 3 @ CS3217
 - Date: March 2018
 */
class OrderStatusLabel: UILabel {
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
    }

    override func drawText(in rect: CGRect) {
        super.drawText(in: UIEdgeInsetsInsetRect(rect, OrderStatusLabel.insets))
    }

    override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        let insetRect = UIEdgeInsetsInsetRect(bounds, OrderStatusLabel.insets)
        let textRect = super.textRect(forBounds: insetRect, limitedToNumberOfLines: numberOfLines)
        return UIEdgeInsetsInsetRect(textRect, OrderStatusLabel.invertedInsets)
    }
}
