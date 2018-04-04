//
//  SingleOrderCell.swift
//  ding-stall
//
//  Created by Calvin Tantio on 4/4/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import UIKit

class SingleOrderCell: UITableViewCell {

    public static let identifier = "SingleOrderCell"

    @IBOutlet weak var foodNameLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
