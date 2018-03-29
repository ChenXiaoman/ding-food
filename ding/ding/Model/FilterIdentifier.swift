//
//  FilterIdentifier.swift
//  ding
//
//  Created by Calvin Tantio on 17/3/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

/**
 Represents an identifier that a user can use to filter a stall by.
 */
public struct FilterIdentifier: FirebaseObject {
    public static let path = "/filters"

    // This id is the name of the filter
    public let id: String
}
