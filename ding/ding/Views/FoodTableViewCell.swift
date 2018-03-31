//
//  FoodTableViewCell.swift
//  ding
//
//  Created by Chen Xiaoman on 23/3/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import UIKit

class FoodTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var photo: UIImageView!
    @IBOutlet private weak var name: UILabel!
    @IBOutlet private weak var price: UILabel!
    @IBOutlet private weak var soldOutImage: UIImageView!
    
    /// The identifer for this cell (in order to dequeue reusable cells).
    static let tableViewIdentifier = "FoodTableViewCell"
    
    /// The text format to display price.
    private static let priceFormat = "$ %.1f"
    
    /// Loads data into and populate a `FoodTableViewCell`.
    /// - Parameter stall: The `Food` object as the data source.
    func load(_ food: Food) {
        photo.setWebImage(at: food.photoPath, placeholder: #imageLiteral(resourceName: "food-icon"))
        name.text = food.name
        price.text = String(format: FoodTableViewCell.priceFormat, food.price)
    }
}
