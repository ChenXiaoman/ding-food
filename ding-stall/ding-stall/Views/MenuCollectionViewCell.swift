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

    /// Load the food view with a food model
    public func load(_ food: Food?) {
        settleOutletFrame()
        foodName.adjustsFontSizeToFitWidth = true
        foodName.text = food?.name
        if let imagePath = food?.photoPath {
            foodImage.setWebImage(at: imagePath)
        } else {
            // set to nil to avoid asyconize problem
            foodImage.image = nil
        }
    }

    private func settleOutletFrame() {
        foodImage.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.width)
        foodName.frame = CGRect(x: 0, y: foodImage.frame.height,
                                width: frame.width, height: frame.height - foodImage.frame.height)
    }
}
