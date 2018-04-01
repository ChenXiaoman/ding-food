//
//  Account.swift
//  ding-stall
//
//  Created by Jiang Chunhui on 27/03/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import Firebase

/**
 Store the user id and stall model for the current login user
 */
struct Account {

    /// Current user id
    private static var uid = ""
    /// Stall model of current user.
    public static var stall: Stall?

    public static var stallId: String {
        return uid
    }
    
    public static func setId(_ newId: String) {
        uid = newId
        downloadStall()
    }

    private static func downloadStall() {
        DatabaseRef.observeValueOnce(of: Stall.path + "/\(uid)") { snapshot in
            stall = Stall.deserialize(snapshot)
        }
    }
}
