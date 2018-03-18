//
//  FilterIdentifier.swift
//  ding
//
//  Created by Calvin Tantio on 17/3/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

struct FilterIdentifier: FirebaseObject {
    public let id: String
    public var identifierName: String
    
    public var hashValue: Int {
        return id.hashValue
    }
    
    public static func == (lhs: FilterIdentifier, rhs: FilterIdentifier) -> Bool {
        return lhs.id == rhs.id &&
            lhs.identifierName == rhs.identifierName
    }
}
