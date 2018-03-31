//
//  ShoppingCartTableViewCell.swift
//  ding
//
//  Created by Chen Xiaoman on 27/3/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import UIKit

class ShoppingCartCell: UICollectionViewCell {
    @IBOutlet weak private var foodPhoto: UIImageView!
    @IBOutlet weak private var foodName: UILabel!

    static let identifier = "shoppingCartCell"
}
