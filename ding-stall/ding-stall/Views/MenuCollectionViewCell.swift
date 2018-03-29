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

    public func load(_ food: Food?) {

        foodName.adjustsFontSizeToFitWidth = true
        foodName.text = food?.name
        foodName.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        backgroundColor = #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1)
    }
}
