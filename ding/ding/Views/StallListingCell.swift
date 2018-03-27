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

    static let identifier = "stallListingCell"

    func load(_ stall: StallDetails) {
        name.text = stall.name
    }
}
