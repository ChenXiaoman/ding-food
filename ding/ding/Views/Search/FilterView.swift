//
//  FilterView.swift
//  ding
//
//  Created by Yunpeng Niu on 06/04/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import UIKit

/**
 A customized `UIView` which can be used to display a list of `FilterLabel`s,
 which could be useful for the `StallListingCell`. Notice that the list of
 filters should be displayed horizontally in one single row.

 - Author: Group 3 @ CS3217
 - Date: March 2018
 */
class FilterView: UIView {
    /// Loads a list of `Filter`s to be displayed in this `FilterView`.
    /// - Parameter filters: A list of `Filter`s to be displayed.
    func load(filters: [Filter]) {
        var latestX = CGFloat(0)
        for filter in filters {
            // Only displays within the visible range.
            if latestX > frame.maxX {
                break
            }
            let label = FilterLabel(frame: CGRect(origin: CGPoint(x: latestX, y: 0), size: FilterLabel.size))
            label.load(filter)
            latestX = (label.frame.maxX + FilterLabel.gap)
            addSubview(label)
        }
    }

    /// Clears a `FilterView` by removing all subviews.
    func clear() {
        subviews.forEach { $0.removeFromSuperview() }
    }
}
