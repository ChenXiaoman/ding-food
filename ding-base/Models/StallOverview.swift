//
//  StallOverview.swift
//  ding-stall
//
//  Created by Jiang Chunhui on 03/04/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import FirebaseDatabase

/**
 `StallOverview` represents an overview of a stall, which could be used in the stall
 listing table view.

 - Author: Group 3 @ CS3217
 - Date: March 2018
 */
public struct StallOverview: DatabaseObject {
    public static let path = "/stall_overviews"

    public let id: String
    public var name: String
    public let queueCount: Int
    public let reviewCount: Int
    public let averageRating: Double
    public var photoPath: String
    public var location: String
    public var openingHour: String
    public var description: String
    public var isOpen: Bool
    public var filters: [String: Filter]?

    public init(id: String, name: String, photoPath: String, location: String,
                openingHour: String, description: String, filters: [String: Filter]?) {
        self.id = id
        self.name = name
        self.photoPath = photoPath
        self.location = location
        self.openingHour = openingHour
        self.description = description
        self.filters = filters
        queueCount = 0
        reviewCount = 0
        averageRating = 0
        isOpen = false
    }

    /// Provide a new path for the stall photo if it has changed
    public static var newPhotoPath: String {
        return StallOverview.path + "/\(StallOverview.getAutoId)"
    }

    /// A custom deserialization method to handle the nested `DatabaseObject` structure.
    /// - Parameter snapshot: The `DataSnapshot` containing information about the stall.
    /// - Returns: A `StallOverview` object; or nil if the conversion fails.
    static func deserialize(_ snapshot: DataSnapshot) -> StallOverview? {
        guard var dict = snapshot.value as? [String: Any] else {
            return nil
        }
        dict["id"] = snapshot.key
        if let filterDict = dict["filters"] as? [String: Any] {
            dict["filters"] = prepareNestedDeserialize(filterDict)
        }
        return deserialize(dict)
    }
}
