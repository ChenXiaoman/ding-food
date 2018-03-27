//
//  SearchTableViewCell.swift
//  ding
//
//  Created by Chen Xiaoman on 22/3/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import UIKit

class StallListingCell: UITableViewCell {
    @IBOutlet private weak var photo: UIImageView!
    @IBOutlet private weak var name: UILabel!
    @IBOutlet private weak var queueCount: UILabel!
    @IBOutlet private weak var averageRating: UILabel!

    /// The identifer for this cell (in order to dequeue reusable cells).
    static let identifier = "stallListingCell"
    /// The height of this cell.
    static let height = CGFloat(150)

    /// The text format to display queue count.
    private static let queueCountFormat = "%d people waiting"
    /// The text format to display average rating.
    private static let averageRatingFormat = "Average rating: %.1f"

    /// Loads data into and populate a `StallListingCell`.
    /// - Parameter stall: The `StallOverview` object as the data source.
    func load(_ stall: StallOverview) {
        photo.image = stall.photo
        name.text = stall.name
        queueCount.text = String(format: StallListingCell.queueCountFormat, stall.queueCount)
        averageRating.text = String(format: StallListingCell.averageRatingFormat, stall.averageRating)
    }
}
