//
//  AddFoodViewController.swift
//  ding-stall
//
//  Created by Jiang Chunhui on 27/03/18.
//  Copyright © 2018年 CS3217 Ding. All rights reserved.
//

import UIKit
import XLForm

class AddFoodViewController: XLFormViewController {

    static let identifier = "addFoodSegue"

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initializeForm()
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.initializeForm()
    }

    func initializeForm() {
        let form = XLFormDescriptor(title: "Add Food")
        let section = XLFormSectionDescriptor()
        form.addFormSection(section)
        let name = XLFormRowDescriptor(tag: "Name", rowType: XLFormRowDescriptorTypeText, title: "Food Name")
        let price = XLFormRowDescriptor(tag: "Price", rowType: XLFormRowDescriptorTypeDecimal, title: "Food Price")
        let description = XLFormRowDescriptor(tag: "Description", rowType: XLFormRowDescriptorTypeTextView,
                                              title: "Food Description")
        let type = XLFormRowDescriptor(tag: "Type", rowType: XLFormRowDescriptorTypeSelectorAlertView,
                                       title: "Food Type")
        section.addFormRow(name)
        section.addFormRow(price)
        section.addFormRow(description)

        let selectorText = [FoodType.main.rawValue,
                            FoodType.dessert.rawValue,
                            FoodType.soup.rawValue,
                            FoodType.drink.rawValue]
        type.selectorOptions = selectorText
        section.addFormRow(type)
        self.form = form
    }

    var stall: Stall!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    /*func addFood(_ sender: UIButton) {
        guard
            let name = nameText.text,
            let price = Double(priceText.text!),
            let description = descriptionText.text else {
                return
        }
        stall.addFood(name: name, price: price, description: description, type: .main)
    }*/
}
