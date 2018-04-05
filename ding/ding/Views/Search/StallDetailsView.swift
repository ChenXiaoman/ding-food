//
//  StallDetailsView.swift
//  ding
//
//  Created by Chen Xiaoman on 5/4/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import UIKit

/**
 A customized `UIView` which can be used to display information about
 a `StallDetails` object.
 
 - Author: Group 3 @ CS3217
 - Date: April 2018
 */
class StallDetailsView: UIView {
    /// The text format to display opening hour.
    private static let openingHourFormat = "🕒Opening Hour: %@"
    /// The text format to display location.
    private static let locationFormat = "🏠Location: %@"
    /// The text format to display description.
    private static let descriptionFormat = "\"%@\""
    
    @IBOutlet weak private var descriptionLabel: UILabel!
    @IBOutlet weak private var openingHourLabel: UILabel!
    @IBOutlet weak private var locationLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        descriptionLabel.text = nil
        openingHourLabel.text = nil
        locationLabel.text = nil
    }
    
    /// Loads data into and populate a `StallDetails`.
    /// - Parameter stallDetails: The `StallDetails` object as the data source.
    func load(stallDetails: StallDetails) {
        descriptionLabel.text = String(format: StallDetailsView.descriptionFormat, stallDetails.description)
        openingHourLabel.text = String(format: StallDetailsView.openingHourFormat, stallDetails.openingHour)
        locationLabel.text = String(format: StallDetailsView.locationFormat, stallDetails.location)
    }
}
