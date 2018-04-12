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
    /// The insets around the text of this label.
    private static let insets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    /// The inverted insets around the text of this label.
    private static let invertedInsets = UIEdgeInsets(top: 0, left: -5, bottom: 0, right: -5)
    /// The displayed width of this `FilterLabel`.
    static let width = CGFloat(70)
    /// The horizontal gap between two `FilterLabel`s.
    static let gap = CGFloat(5)
    /// The size of this `FilterLabel`.
    static let size = CGSize(width: FilterLabel.width, height: 20)

    override func drawText(in rect: CGRect) {
        super.drawText(in: UIEdgeInsetsInsetRect(rect, FilterLabel.insets))
    }

    override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        let insetRect = UIEdgeInsetsInsetRect(bounds, FilterLabel.insets)
        let textRect = super.textRect(forBounds: insetRect, limitedToNumberOfLines: numberOfLines)
        return UIEdgeInsetsInsetRect(textRect, FilterLabel.invertedInsets)
    }

    func load(_ filter: Filter) {
        layer.cornerRadius = FilterLabel.cornerRadius
        clipsToBounds = true
        invalidateIntrinsicContentSize()
        backgroundColor = .fromRGB(0x6bbdef)
        textColor = .white

        text = filter.name
        sizeToFit()
    }
}
