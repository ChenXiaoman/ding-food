//
//  Food.swift
//  ding
//
//  Created by Calvin Tantio on 17/3/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import UIKit

struct Food {
    let name: String
    let price: Double
    let description: String
    let type: FoodType
    var isSoldOut: Bool
    
    mutating func soldOut() {
        isSoldOut = false
    }
}
