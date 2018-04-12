//
//  FoodTypeLabel.swift
//  ding
//
//  Created by Chen Xiaoman on 8/4/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import UIKit

class FoodTypeLabel: UILabel {
    
    override func awakeFromNib() {
        self.text = nil
    }
    
    /// Loads the food type into the FoodType Label.
    /// - parameter foodType: The 'FoodType' enumeration.
    func load(foodType: FoodType) {
        switch foodType {
        case .main:
            self.text = "🍱"
        case .side:
            self.text = "🍪"
        case .drink:
            self.text = "🍺"
        }
    }
}
