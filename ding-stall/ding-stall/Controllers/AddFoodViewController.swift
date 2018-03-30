//
//  AddFoodViewController.swift
//  ding-stall
//
//  Created by Jiang Chunhui on 27/03/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import UIKit
import Eureka

class AddFoodViewController: FormViewController {

    static let identifier = "addFoodSegue"

    let nameTag = "Name"
    let priceTag = "Tag"
    let descriptionTag = "Description"
    let typeTag = "Type"
    let imageTag = "Image"

    var stall: Stall?

    override func viewDidLoad() {
        super.viewDidLoad()
        initializeForm()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .done,
                                                            target: self, action: #selector(addFood))
    }

    /// Build a form for adding new food
    private func initializeForm() {
        form +++ Section("Food Information")
            <<< TextRow { row in
                row.tag = nameTag
                row.title = "Food Name"
            }
            <<< DecimalRow { row in
                row.tag = priceTag
                row.title = "Food Price"
            }
            <<< ActionSheetRow<FoodType> { row in
                row.tag = typeTag
                row.title = "Food Type"
                row.options = [FoodType.main, FoodType.soup,
                               FoodType.drink, FoodType.dessert]
            }
            <<< TextAreaRow { row in
                row.tag = descriptionTag
                row.placeholder = "Food Description"
            }
            <<< ImageRow { row in
                row.tag = imageTag
                row.title = "Upload Food Photo"
            }
    }

    /// Add the new food by informaion in the form, and store it
    /// Food Name, Food Price and Food Type are required, and others are optional
    @objc
    private func addFood() {
        let valueDict = form.values()
        guard
            let foodName = valueDict[nameTag] as? String,
            let foodPrice = valueDict[priceTag] as? Double,
            foodPrice != Double.nan,
            foodPrice > 0,
            let foodType = valueDict[typeTag] as? FoodType else {
                print("Catch error")
                return
        }

        let foodDescription = valueDict[descriptionTag] as? String
        stall?.addFood(name: foodName, price: foodPrice, type: foodType, description: foodDescription, photoPath: nil)
        addSuccessAlert()
    }

    private func addSuccessAlert() {
        DialogHelpers.showAlertMessage(in: self, title: "Success", message: "Add food successfully") { _ in
            self.navigationController?.popViewController(animated: true)
        }
    }
}
