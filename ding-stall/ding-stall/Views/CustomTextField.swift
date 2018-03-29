//
//  CustomTextField.swift
//  ding-stall
//
//  Created by Calvin Tantio on 28/3/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import UIKit

class CustomTextField: UITextField {

    init(frame: CGRect, placeHolder: String) {
        super.init(frame: frame)
        setAttributes(placeHolder: placeHolder)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    private func setAttributes(placeHolder: String = "") {
        placeholder = placeHolder
        font = UIFont.systemFont(ofSize: 15)
        borderStyle = UITextBorderStyle.roundedRect
        autocorrectionType = UITextAutocorrectionType.no
        keyboardType = UIKeyboardType.default
        returnKeyType = UIReturnKeyType.done
        clearButtonMode = UITextFieldViewMode.whileEditing;
        contentVerticalAlignment = UIControlContentVerticalAlignment.center
        contentHorizontalAlignment = UIControlContentHorizontalAlignment.leading
    }
}
