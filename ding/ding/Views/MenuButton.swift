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
    /// The constant for menu corner radius.
    private static let cornerRadius = CGFloat(5)
    /// The border width for menu buttons
    private static let borderWidth = CGFloat(1)

    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor.lightText
        layer.cornerRadius = MenuButton.cornerRadius
        layer.borderWidth = MenuButton.borderWidth
        layer.borderColor = UIColor.darkGray.cgColor
        setTitleColor(.black, for: .normal)
        contentHorizontalAlignment = .center
        contentVerticalAlignment = .center
    }

    /// Disables this button.
    /// - Parameter text: The text to be shown on disabled state. If this parameter is not
    /// filled, the disabled text would be the same as normal state.
    func disable(text: String? = nil) {
        if let newText = text {
            setTitle(newText, for: .disabled)
        }
        isEnabled = false
        backgroundColor = .lightGray
        setTitleColor(.white, for: .disabled)
    }

    /// Enables this button.
    /// - Parameter text: The text to be shown on normal state. If this parameter is not
    /// filled, the text would not change.
    func enable(text: String? = nil) {
        if let newText = text {
            setTitle(newText, for: .normal)
        }
        isEnabled = true
        backgroundColor = UIColor.lightText
        setTitleColor(.black, for: .normal)
    }
}
