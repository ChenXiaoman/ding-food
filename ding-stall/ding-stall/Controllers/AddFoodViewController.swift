//
//  AddFoodViewController.swift
//  ding-stall
//
//  Created by Jiang Chunhui on 27/03/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import UIKit
import XLForm

class AddFoodViewController: XLFormViewController {

    static let identifier = "addFoodSegue"

    let nameTag = "Name"
    let priceTag = "Tag"
    let descriptionTag = "Description"
    let typeTag = "Type"

    var stall: Stall?

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initializeForm()
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.initializeForm()
    }

    /// Build a form for adding new food
    private func initializeForm() {
        let form = XLFormDescriptor(title: "Add Food")
        let section = XLFormSectionDescriptor()
        form.addFormSection(section)
        let name = XLFormRowDescriptor(tag: nameTag, rowType: XLFormRowDescriptorTypeText, title: "Food Name")
        let price = XLFormRowDescriptor(tag: priceTag, rowType: XLFormRowDescriptorTypeDecimal, title: "Food Price")
        let description = XLFormRowDescriptor(tag: descriptionTag, rowType: XLFormRowDescriptorTypeTextView,
                                              title: "Food Description")
        let type = XLFormRowDescriptor(tag: typeTag, rowType: XLFormRowDescriptorTypeSelectorAlertView,
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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .done,
                                                            target: self, action: #selector(addFood))
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    /// Add the new food by informaion in the form, and store it
    /// Food Name, Food Price and Food Type are required, and others are optional
    @objc
    private func addFood() {
        guard
            let foodName = form.formRow(withTag: nameTag)?.value as? String,
            let foodPrice = form.formRow(withTag: priceTag)?.value as? Double,
            foodPrice != Double.nan,
            foodPrice > 0,
            let rawFoodType = form.formRow(withTag: typeTag)?.value as? String,
            let foodType = FoodType(rawValue: rawFoodType) else {
                return
        }
        let foodDescription = form.formRow(withTag: descriptionTag)?.value as? String
        stall?.addFood(name: foodName, price: foodPrice, type: foodType, description: foodDescription, photoPath: nil)
        addSuccessAlert()
    }

    private func addSuccessAlert() {
        DialogHelpers.showAlertMessage(in: self, title: "Success", message: "Add food successfully") { _ in
            self.navigationController?.popViewController(animated: true)
        }
    }
}
