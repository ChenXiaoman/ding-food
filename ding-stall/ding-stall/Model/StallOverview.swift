//
//  StallOverview.swift
//  ding-stall
//
//  Created by Calvin Tantio on 4/4/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import UIKit

/**
 `StallOverview` represents an overview of a stall, which could be used in the stall
 listing table view.

 - Author: Group 3 @ CS3217
 - Date: March 2018
 */
struct StallOverview: FirebaseObject {
    static let path = "/stall_overviews"

    let id: String
    let name: String
    let queueCount: Int
    let averageRating: Double
    let photoPath: String
}

