//
//  MenuCollectionViewCell.swift
//  ding-stall
//
//  Created by Jiang Chunhui on 26/03/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import DingBase
import UIKit

class MenuCollectionViewCell: UICollectionViewCell {
    @IBOutlet private weak var foodName: UILabel!
    @IBOutlet private weak var foodImage: UIImageView!
    @IBOutlet private weak var soldOutLabel: UIImageView!
    public static let identifier = "MenuCollectionViewCell"

    /// The id of this cell to retrieve back the food model
    private var foodTag: String?
    var cellTag: String? {
        return foodTag
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.shadowColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        self.layer.shadowOffset = CGSize(width: 5, height: 5)
        self.layer.shadowOpacity = 1
    }

    /// Load the food view with a food model
    public func load(_ food: Food) {
        foodTag = food.id
        foodName.adjustsFontSizeToFitWidth = true
        foodName.text = food.name
        soldOutLabel.isHidden = !food.isSoldOut
        if let imagePath = food.photoPath {
            foodImage.setWebImage(at: imagePath, placeholder: #imageLiteral(resourceName: "food-icon"))
        } else {
            foodImage.image = #imageLiteral(resourceName: "food-icon")
        }
    }

    public var foodPhoto: UIImage? {
        return foodImage.image
    }
}
