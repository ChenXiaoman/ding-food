//
//  MenuCollectionViewCell.swift
//  ding-stall
//
//  Created by Jiang Chunhui on 26/03/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import UIKit

class MenuCollectionViewCell: UICollectionViewCell {
    @IBOutlet private weak var foodName: UILabel!
    @IBOutlet private weak var foodImage: UIImageView!
    
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
    public func load(_ food: Food?) {
        settleOutletFrame()
        foodTag = food?.id
        foodName.adjustsFontSizeToFitWidth = true
        foodName.text = food?.name
        if let imagePath = food?.photoPath {
            foodImage.setWebImage(at: imagePath)
        } else {
            // set to nil to avoid asynchronous problem
            foodImage.image = nil
        }
    }

    public var foodPhoto: UIImage? {
        return foodImage.image
    }

    private func settleOutletFrame() {
        foodImage.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.width)
        foodName.frame = CGRect(x: 0, y: foodImage.frame.height,
                                width: frame.width, height: frame.height - foodImage.frame.height)
    }
}
