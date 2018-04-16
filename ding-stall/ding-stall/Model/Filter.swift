//
//  Filter.swift
//  ding
//
//  Created by Yunpeng Niu on 07/04/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import DingBase

/**
 Represents a `Filter` that a stall can belong to. Notice that while many
 stalls can belong to the same `Filter`, a stall can belong to many `Filter`s
 as well.
 */
public struct Filter: DatabaseObject {
    public static let path = "/filters"

    public let id: String
    public let name: String
}

// MARK: CustomStringConvertible
extension Filter: CustomStringConvertible {
    public var description: String {
        return name
    }
}
