//
//  StallOverview.swift
//  ding-stall
//
//  Created by Jiang Chunhui on 03/04/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

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

    public init(id: String, name: String, photoPath: String) {
        self.id = id
        self.name = name
        self.photoPath = photoPath
        queueCount = 0
        averageRating = 0
    }
}
