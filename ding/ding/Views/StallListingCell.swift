//
//  SearchTableViewCell.swift
//  ding
//
//  Created by Chen Xiaoman on 22/3/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import UIKit

class StallListingCell: UICollectionViewCell {
    @IBOutlet private weak var photo: UIImageView!
    @IBOutlet private weak var name: UILabel!
    @IBOutlet private weak var queueCount: UILabel!
    @IBOutlet private weak var averageRating: UILabel!

    /// The identifer for this cell (in order to dequeue reusable cells).
    static let identifier = "stallListingCell"
    /// The aspect ratio of this cell.
    private static let aspectRatio = CGFloat(1.0 / 3)
    /// The width ratio constant depending on the device.
    static let widthRatio = (UIDevice.current.userInterfaceIdiom == .phone) ? CGFloat(1) : CGFloat(0.5)
    /// The width of this cell.
    static let width = Constants.screenWidth * StallListingCell.widthRatio
    /// The height of this cell.
    static let height = StallListingCell.width * StallListingCell.aspectRatio

    /// The text format to display queue count.
    private static let queueCountFormat = "%d people waiting"
    /// The text format to display average rating.
    private static let averageRatingFormat = "Average rating: %.1f"

    /// Loads data into and populate a `StallListingCell`.
    /// - Parameter stall: The `StallOverview` object as the data source.
    func load(_ stall: StallOverview) {
        photo.setWebImage(at: stall.photoPath, placeholder: #imageLiteral(resourceName: "stall-placeholder"))
        name.text = stall.name
        queueCount.text = String(format: StallListingCell.queueCountFormat, stall.queueCount)
        averageRating.text = String(format: StallListingCell.averageRatingFormat, stall.averageRating)
    }

    static var onPhone: Bool {
        return UIDevice.current.userInterfaceIdiom == .phone
    }
}
