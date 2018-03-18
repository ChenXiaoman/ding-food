//
//  Stall.swift
//  ding
//
//  Created by Calvin Tantio on 17/3/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

struct Stall {
    let name: String
    let location: String
    let openingHour: String
    let description: String
    let queue: [Order]
    let menu: [Food]
    let filters: [FilterIdentifier: String]
}
