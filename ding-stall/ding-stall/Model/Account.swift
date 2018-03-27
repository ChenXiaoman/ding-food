//
//  Account.swift
//  ding-stall
//
//  Created by Jiang Chunhui on 27/03/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

struct Account {

    private static var id = ""

    public static var stallId: String {
        return id
    }

    public static func setId(_ newId: String) {
        id = newId
    }
}
