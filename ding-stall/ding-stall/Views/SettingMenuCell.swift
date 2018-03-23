//
//  SettingMenuCell.swift
//  ding-stall
//
//  Created by Yunpeng Niu on 23/03/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import UIKit

/**
 A customized `UIButton` type to represent each single cell within a setting menu.

 - Author: Group 3 @ CS3217
 - Date: March 2018
 */
class SettingMenuCell: UIButton {
    /// Indiactes whether the button will lead to any dangerous consequences. If so, the
    /// color of the title will be changed accordingly.
    @IBInspectable var isDanger: Bool = false

    override func awakeFromNib() {
        frame = CGRect(x: frame.minX, y: frame.minY,
                       width: Constants.screenWidth, height: Constants.settingMenuCellHeight)
        layer.borderWidth = Constants.settingMenuCellBorderWidth
        layer.borderColor = UIColor.lightGray.cgColor

        let inset = Constants.settingMenuCellInset
        contentEdgeInsets = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)

        if let label = titleLabel {
            label.font = label.font.withSize(Constants.settingMenuCellFontSize)
        }
        setTitleColor(isDanger ? .red : .black, for: .normal)
        contentHorizontalAlignment = isDanger ? .center : .left
        contentVerticalAlignment = .center
    }
}
