//
//  Stall.swift
//  ding
//
//  Created by Calvin Tantio on 17/3/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

/// Represents a food stall registered in the application.
struct Stall: FirebaseObject {
    public var id: String
    public let name: String
    public let location: String
    public let openingHour: String
    public let description: String
    public let queue: [Order]
    public let menu: [Food]
    public let filters: Set<FilterIdentifier>

}
