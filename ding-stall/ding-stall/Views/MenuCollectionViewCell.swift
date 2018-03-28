//
//  MenuCollectionViewCell.swift
//  ding-stall
//
//  Created by Jiang Chunhui on 26/03/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import UIKit

class MenuCollectionViewCell: UICollectionViewCell {
    @IBOutlet var foodName: UILabel!
    @IBOutlet var foodImage: UIImageView!
    
    public static let identifier = "MenuCollectionViewCell"

    public func load(_ food: Food) {
        foodName.text = food.name
    }
}
