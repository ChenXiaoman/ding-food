//
//  FilterLabel.swift
//  ding
//
//  Created by Yunpeng Niu on 06/04/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import UIKit

/**
 Each `FilterLabel` will be used to display a `Filter` that a stall belongs
 to properly.

 - Author: Group 3 @ CS3217
 - Date: March 2018
 */
class FilterLabel: UILabel {
    /// The corner radius for this label.
    private static let cornerRadius = CGFloat(10)
    /// The border width for this label.
    private static let borderWidth = CGFloat(2)
    /// The insets around the text of this label.
    private static let insets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    /// The inverted insets around the text of this label.
    private static let invertedInsets = UIEdgeInsets(top: 0, left: -5, bottom: 0, right: -5)

    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = FilterLabel.cornerRadius
        layer.borderWidth = FilterLabel.borderWidth
        layer.borderColor = UIColor.white.cgColor
        clipsToBounds = true
        invalidateIntrinsicContentSize()
    }

    override func drawText(in rect: CGRect) {
        super.drawText(in: UIEdgeInsetsInsetRect(rect, FilterLabel.insets))
    }

    override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        let insetRect = UIEdgeInsetsInsetRect(bounds, FilterLabel.insets)
        let textRect = super.textRect(forBounds: insetRect, limitedToNumberOfLines: numberOfLines)
        return UIEdgeInsetsInsetRect(textRect, FilterLabel.invertedInsets)
    }
}
