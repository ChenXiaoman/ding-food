//
//  Customer.swift
//  DingPod
//
//  Created by Jiang Chunhui on 17/03/18.
//  Copyright © 2018 JCH. All rights reserved.
//

/**
 Represents a registered user in the application.
 */
public struct Customer: DatabaseObject {
    public static let path = "/customer_profiles"

    /// The customer's UID.
    public let id: String
    /// The customer's real name.
    public let name: String
}
