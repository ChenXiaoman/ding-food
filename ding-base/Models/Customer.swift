//
//  User.swift
//  DingPod
//
//  Created by Jiang Chunhui on 17/03/18.
//  Copyright © 2018 JCH. All rights reserved.
//

/**
 Represents a registered customer in the application.

 - Author: Group 3 @ CS3217
 - Date: March 2018
 */
public struct Customer: DatabaseObject {
    public static let path = "/customer_profiles"

    /// The customer's UID.
    public let id: String
    /// The customer's real name.
    public let name: String
    /// The path to the customer's avatar.
    public var avatarPath: String

    public init(id: String, name: String, avatarPath: String) {
        self.id = id
        self.name = name
        self.avatarPath = avatarPath
    }

    /// Provide a new path for the stall photo if it has changed
    public static var newPhotoPath: String {
        return Customer.path + "/\(Customer.getAutoId)"
    }
}
