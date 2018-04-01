//
//  StallOrders.swift
//  ding
//
//  Created by Calvin Tantio on 1/4/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import UIKit

/*
 `StallOrder` provides information about all the order that a stall gets.
 This is used in the order view, the main view that the stall owner will be
 looking at during business hour.

 The number of order might be huge; and therefore, we need to minimize the
 amount of data fetched from the database

 - Author: Group 3 @ CS3217
 - Date: April 2018
 */
struct StallOrders: FirebaseObject {
    static let path = "/stall_order"

    // TODO: Save StallOrder during the creation of Stall (after merging)
    let id: String
    let queue: [Order]?
}
