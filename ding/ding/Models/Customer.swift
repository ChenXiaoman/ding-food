//
//  User.swift
//  DingPod
//
//  Created by Jiang Chunhui on 17/03/18.
//  Copyright © 2018 JCH. All rights reserved.
//

import DingBase

/**
 Represents a registered customer in the application.

 - Author: Group 3 @ CS3217
 - Date: March 2018
 */
struct Customer: DatabaseObject {
    public static let path = "/customer_profiles"

    /// The customer's UID.
    let id: String
    /// The customer's real name.
    let name: String
    /// The path to the customer's avatar.
    var avatarPath: String

    /// Provide a new path for the stall photo if it has changed
    static var newPhotoPath: String {
        return Customer.path + "/\(Customer.getAutoId)"
    }
}
