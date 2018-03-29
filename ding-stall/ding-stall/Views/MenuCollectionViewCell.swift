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
        foodName.text = food?.name
        foodName.adjustsFontSizeToFitWidth = true
        backgroundColor = #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1)
    }
}
