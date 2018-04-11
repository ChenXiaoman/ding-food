//
//  SearchTableViewCell.swift
//  ding
//
//  Created by Chen Xiaoman on 22/3/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import UIKit

/**
 The cell for the collection view in ongoing orders.

 - Author: Group 3 @ CS3217
 - Date: March 2018
 */
class StallListingCell: UICollectionViewCell {
    @IBOutlet weak private var photo: UIImageView!
    @IBOutlet weak private var name: UILabel!
    @IBOutlet weak private var queueCount: UILabel!
    @IBOutlet weak private var averageRating: UILabel!
    @IBOutlet weak private var filters: FilterView!
    
    /// The identifer for this cell (in order to dequeue reusable cells).
    static let identifier = "stallListingCell"
    /// The aspect ratio of this cell.
    private static let aspectRatio = CGFloat(1.0 / 3)
    /// The width ratio constant depending on the device.
    static let widthRatio = (UIView.onPhone) ? CGFloat(1) : CGFloat(0.5)
    /// The width of this cell.
    static let width = Constants.screenWidth * StallListingCell.widthRatio
    /// The height of this cell.
    static let height = StallListingCell.width * StallListingCell.aspectRatio

    /// The text format to display queue count.
    private static let queueCountFormat = "%d people waiting"
    /// The text format to display average rating.
    private static let averageRatingFormat = "Average rating: %.1f"

    override func awakeFromNib() {
        photo.image = nil
        name.text = nil
        queueCount.text = nil
        averageRating.text = nil
        photo.clipsToBounds = true // Use for enable corner radius
    }
    
    /// Loads data into and populate a `StallListingCell`.
    /// - Parameter stall: The `StallOverview` object as the data source.
    func load(_ stall: StallOverview) {
        photo.setWebImage(at: stall.photoPath, placeholder: #imageLiteral(resourceName: "stall-placeholder"))
        name.text = stall.name
        queueCount.text = String(format: StallListingCell.queueCountFormat, stall.queueCount)
        averageRating.text = String(format: StallListingCell.averageRatingFormat, stall.averageRating)
        filters.load(filters: stall.filters ?? [])
    }
}
