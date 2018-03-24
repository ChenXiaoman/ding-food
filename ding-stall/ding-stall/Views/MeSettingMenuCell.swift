//
//  MeSettingMenuCell.swift
//  ding-stall
//
//  Created by Yunpeng Niu on 23/03/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import UIKit

/**
 A customized `UITableViewCell` type to use in the setting menu of me scene.

 - Author: Group 3 @ CS3217
 - Date: March 2018
 */
class MeSettingMenuCell: UITableViewCell {
    /// The label to display the name of this setting.
    @IBOutlet private weak var name: UILabel!

    /// Indiactes whether the button will lead to any dangerous consequences. If so, the
    /// color of the title will be changed accordingly.
    var isDangerous = false {
        didSet {
            name.textAlignment = isDangerous ? .center : .left
            name.textColor = isDangerous ? .red : .black
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        name.frame = frame
    }

    /// Changes the name label shown in the cell.
    /// - Parameter text: The new text to display.
    func setName(_ text: String) {
        name.text = text
    }
}
