//
//  FoodOverviewView.swift
//  ding
//
//  Created by Yunpeng Niu on 01/04/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import UIKit

/**
 A customized `UIView` which can be used to display information about
 a `Food` object.

 - Author: Group 3 @ CS3217
 - Date: March 2018
 */
class FoodOverviewView: UIView {
    @IBOutlet weak private var photo: UIImageView!
    @IBOutlet weak private var name: UILabel!
    @IBOutlet weak private var price: UILabel!
    @IBOutlet weak private var foodDescription: UILabel!

    /// The text format to display price.
    private static let priceFormat = "$%.1f"
    /// The text format to display description.
    private static let descriptionFormat = "\"%@\""

    override func awakeFromNib() {
        super.awakeFromNib()
        photo.image = nil
        name.text = nil
        price.text = nil
        foodDescription.text = nil
        frame = CGRect(x: frame.minX, y: frame.minY, width: frame.width, height: Constants.screenHeight / 2)
    }

    /// Loads data into and populate a `FoodOverviewView`.
    /// - Parameter food: The `Food` object as the data source.
    func load(food: Food) {
        photo.setWebImage(at: food.photoPath ?? "", placeholder: #imageLiteral(resourceName: "food-icon"))
        name.text = food.name
        price.text = String(format: FoodOverviewView.priceFormat, food.price)
        if let description = food.description {
            foodDescription.text = String(format: FoodOverviewView.descriptionFormat, description)
        } else {
            foodDescription?.removeFromSuperview()
        }
    }
}
