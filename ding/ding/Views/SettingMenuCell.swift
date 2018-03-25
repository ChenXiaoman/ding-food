//
//  MeSettingMenuCell.swift
//  ding
//
//  Created by Yunpeng Niu on 24/03/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import UIKit

/**
 A customized `UITableViewCell` type to use in the setting menu of me scene.

 - Author: Group 3 @ CS3217
 - Date: March 2018
 */
class SettingMenuCell: UITableViewCell {
    /// The label to display the name of this setting.
    @IBOutlet private weak var name: UILabel!

    /// Indiactes whether the button will lead to any dangerous consequences. If so, the
    /// color of the title will be changed accordingly.
    var state = SettingMenuCellState.normal {
        didSet {
            switch state {
            case .normal:
                name.textAlignment = .left
                name.textColor = .black
            case .danger:
                name.textAlignment = .center
                name.textColor = .red
            case .info:
                name.textAlignment = .center
                name.textColor = .blue
            }
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

/**
 Indicates the state of a `MeSettingMenuCell`.
 */
enum SettingMenuCellState {
    case normal
    case danger
    case info
}
