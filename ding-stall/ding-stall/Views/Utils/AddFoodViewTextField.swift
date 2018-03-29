//
//  AddFoodViewTextField.swift
//  ding-stall
//
//  Created by Jiang Chunhui on 26/03/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import UIKit

class AddFoodViewTextFieldGenerator {

    private let frame: CGRect

    init(frame: CGRect) {
        self.frame = frame
    }

    func create() -> UITextField {
        let textField = UITextField(frame: frame)
        textField.font = UIFont(name: "Arial", size: 30)
        textField.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        textField.returnKeyType = .next
        textField.textAlignment = .center
        textField.adjustsFontSizeToFitWidth = true
        textField.borderStyle = .bezel
        return textField
    }
}

class NameTextFieldGenerator: AddFoodViewTextFieldGenerator {
    override func create() -> UITextField {
        let textField = super.create()
        textField.placeholder = "Food Name"
        return textField
    }
}

class PriceTextFieldGenerator: AddFoodViewTextFieldGenerator {
    override func create() -> UITextField {
        let textField = super.create()
        textField.placeholder = "Food Price"
        textField.keyboardType = .decimalPad
        return textField
    }
}
