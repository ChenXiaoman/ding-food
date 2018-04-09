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
public struct StallOverview: FirebaseObject {
    public static let path = "/stall_overviews"

    public let id: String
    public let name: String
    public var queueCount: Int
    public var averageRating: Double
    public var photoPath: String
    public var location: String
    public var openingHour: String
    public var description: String
    public var isOpen: Bool     // isOpen means that the stall will be able to receive order
                                // !isOpen means that the stall will not be receiving anymore order

    public init(id: String, name: String, photoPath: String,
                location: String, openingHour: String, description: String) {
        self.id = id
        self.name = name
        self.photoPath = photoPath
        self.location = location
        self.openingHour = openingHour
        self.description = description
        queueCount = 0
        averageRating = 0
        isOpen = false
    }
}
