//
//  MenuButton.swift
//  ding
//
//  Created by Yunpeng Niu on 24/03/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import UIKit

/**
 Defines a customized button used for the main menu.

 - Author: Group 3 @ CS3217
 - Date: March 2018
 */
class MenuButton: UIButton {
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor.lightText
        layer.cornerRadius = frame.width * Constants.menuButtonCornerRadiusCoefficient
        layer.borderWidth = Constants.menuButtonBorderWidth
        layer.borderColor = UIColor.darkGray.cgColor
        setTitleColor(.black, for: .normal)
        contentHorizontalAlignment = .center
        contentVerticalAlignment = .center
    }
}
