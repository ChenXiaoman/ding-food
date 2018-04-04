//
//  Account.swift
//  ding-stall
//
//  Created by Jiang Chunhui on 27/03/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

/**
 Store the user id and stall model for the current login user
 */
struct Account {

    /// Current user id
    private static var uid = "" {
        didSet {
            downloadStall()
        }
    }
    
    /// Stall model of current user.
    public static var stall: StallDetails?

    public static var stallId: String {
        get { return uid }
        set { uid = newValue }
    }

    /// Download the stall object from database
    private static func downloadStall() {
        guard uid != "" else {
            return
        }
        DatabaseRef.observeValueOnce(of: StallDetails.path + "/\(uid)") { snapshot in
            stall = StallDetails.deserialize(snapshot)
            // Stop observing to avoid memory leak
            DatabaseRef.stopObservers(of: StallDetails.path + "/\(uid)")
        }
    }
}
