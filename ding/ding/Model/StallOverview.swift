//
//  Stall.swift
//  ding
//
//  Created by Yunpeng Niu on 27/03/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import UIKit

/**
 `StallOverview` represents an overview of a stall, which could be used in the stall
 listing table view.

 - Author: Group 3 @ CS3217
 - Date: March 2018
 */
struct StallOverview: Codable {
    let id: String
    let name: String
    let queueCount: Int
    let averageRating: Double
    var photo: UIImage? = nil

    private enum CodingKeys: CodingKey {
        case id
        case name
        case queueCount
        case averageRating
    }
}
