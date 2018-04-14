//
//  ReviewTableViewCell.swift
//  ding
//
//  Created by Chen Xiaoman on 25/3/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import UIKit

class ReviewTableViewCell: UITableViewCell {

    @IBOutlet weak private var rating: UILabel!
    @IBOutlet weak private var content: UILabel!
    @IBOutlet weak private var date: UILabel!
    @IBOutlet weak private var foodOrdered: UILabel!
    
    public static let tableViewIdentifier = "ReviewTableViewCell"

    /// Loads data into and populate a `OngoiReviewTableViewCellngOrderCell`.
    /// - Parameter order: The `OrderHistory` object as the data source.
    func load(_ orderHistory: OrderHistory) {
        // Load order history details
        rating.text = orderHistory.review?.rating.description
        content.text = orderHistory.review?.reviewText
        date.text = orderHistory.order.createdAt.description
        foodOrdered.text = orderHistory.order.foodName.description
    }
}
