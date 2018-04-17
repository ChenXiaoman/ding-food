//
//  StallOverviewView.swift
//  ding
//
//  Created by Yunpeng Niu on 31/03/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import DingBase
import UIKit

/**
 A customized `UIView` which can be used to display information about
 a `StallOverview` object.

 - Author: Group 3 @ CS3217
 - Date: March 2018
 */
class StallOverviewView: UIView {
    /// The text format to display queue count.
    private static let queueCountFormat = "👥Number of people waiting: %d"
    /// The text format to display average rating.
    private static let averageRatingFormat = "🌟Average rating: %.1f"
    /// The corner radius for the stall photo.
    private static let photoCornerRadius = CGFloat(20)
    /// The text format to display opening hour.
    private static let openingHourFormat = "🕒Opening Hour: %@"
    /// The text format to display location.
    private static let locationFormat = "🏠Location: %@"
    /// The text format to display description.
    private static let descriptionFormat = "\"%@\""
    
    @IBOutlet weak private var descriptionLabel: UILabel!
    @IBOutlet weak private var openingHourLabel: UILabel!
    @IBOutlet weak private var locationLabel: UILabel!
    @IBOutlet weak private var stallPhoto: UIImageView!
    @IBOutlet weak private var stallName: UILabel!
    @IBOutlet weak private var queueCount: UILabel!
    @IBOutlet weak private var averageRating: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        stallPhoto.image = nil
        stallPhoto.layer.cornerRadius = StallOverviewView.photoCornerRadius
        stallName.text = nil
        queueCount.text = nil
        averageRating.text = nil
        descriptionLabel.text = nil
        openingHourLabel.text = nil
        locationLabel.text = nil
    }

    /// Loads data into and populate the general info of `StallOverviewView`.
    /// - Parameter stall: The `StallOverview` object as the data source.
    func load(stall: StallOverview) {
        stallPhoto.setWebImage(at: stall.photoPath, placeholder: #imageLiteral(resourceName: "stall-placeholder"))
        stallName.text = stall.name
        queueCount.text = String(format: StallOverviewView.queueCountFormat, stall.queueCount)
        averageRating.text = String(format: StallOverviewView.averageRatingFormat, stall.averageRating)
        descriptionLabel.text = String(format: StallOverviewView.descriptionFormat, stall.description)
        openingHourLabel.text = String(format: StallOverviewView.openingHourFormat, stall.openingHour)
        locationLabel.text = String(format: StallOverviewView.locationFormat, stall.location)
    }
}
