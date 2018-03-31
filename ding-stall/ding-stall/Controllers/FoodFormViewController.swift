//
//  FoodFormViewController.swift
//  ding-stall
//
//  Created by Jiang Chunhui on 31/03/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import Eureka

class FoodFormViewController: FormViewController {
    
    let nameTag = "Name"
    let priceTag = "Tag"
    let descriptionTag = "Description"
    let typeTag = "Type"
    let imageTag = "Image"

    /// The stall model to add the new food
    var stall: Stall?
    /// The path in database to retrieve stall model
    let stallPath = Stall.path + "/\(Account.stallId)"

    override func viewDidLoad() {
        super.viewDidLoad()
        setValidationStyle()
        initializeForm()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DatabaseRef.observeValueOnce(of: stallPath) { snapshot in
            self.stall = Stall.deserialize(snapshot)
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Stop observe to avoid memory leak
        DatabaseRef.stopObservers(of: stallPath)
    }

    /// Set the style of cell to show whether it is valid
    private func setValidationStyle() {
        TextRow.defaultCellUpdate = { cell, row in
            if !row.isValid {
                cell.titleLabel?.textColor = .red
            }
        }

        DecimalRow.defaultCellUpdate = { cell, row in
            if !row.isValid {
                cell.titleLabel?.textColor = .red
            }
        }

        ActionSheetRow<FoodType>.defaultCellUpdate = { cell, row in
            if !row.isValid {
                cell.textLabel?.textColor = .red
            }
        }
    }

    /// Build a form for adding new food
    private func initializeForm() {
        form +++ Section("Food Information")
            <<< TextRow { row in
                row.tag = nameTag
                row.title = "Food Name"
                row.placeholder = "Food name should not be empty"
                row.add(rule: RuleRequired())
                row.validationOptions = .validatesOnDemand
            }
            <<< DecimalRow { row in
                row.tag = priceTag
                row.title = "Food Price"
                row.placeholder = "Food price should be a positive number"
                row.add(rule: RuleRequired())
                row.add(rule: RuleGreaterThan(min: 0))
                row.validationOptions = .validatesOnDemand
            }
            <<< ActionSheetRow<FoodType> { row in
                row.tag = typeTag
                row.title = "Food Type"
                row.options = [FoodType.main, FoodType.soup,
                               FoodType.drink, FoodType.dessert]
                row.add(rule: RuleRequired())
                row.validationOptions = .validatesOnDemand
            }
            <<< TextRow { row in
                row.tag = descriptionTag
                row.title = "Food Description"
            }
            <<< ImageRow { row in
                row.tag = imageTag
                row.title = "Upload Food Photo"
            }
    }
}
