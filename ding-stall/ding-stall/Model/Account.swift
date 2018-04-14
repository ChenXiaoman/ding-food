//
//  Account.swift
//  ding-stall
//
//  Created by Jiang Chunhui on 27/03/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

/**
 Store the user id and stall model for the current login user
 This information is shared through the whole app
 */
struct Account {

    /// Current user id
    private static var uid = "" 
    
    /// Stall model of current user.
    public static var stall: StallDetails?
    public static var stallOverview: StallOverview?
    public static var allFilters: [Filter]?

    public static var stallId: String {
        get { return uid }
        set { uid = newValue }
    }

    /// Checks whether this account is registered for stall
    /// If not, the database has no stallOverview information
    /// and this variable is nil after downloading
    public static var isCorrectAccount: Bool {
        return stallOverview != nil
    }

    /// Sets all the Account properties back to their original values
    public static func clear() {
        stall = nil
        stallOverview = nil
        stallId = ""
    }

}
