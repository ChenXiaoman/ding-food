//
//  FoodFormViewController.swift
//  ding-stall
//
//  Created by Jiang Chunhui on 31/03/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import Eureka

/*
 A super class which creates a form of food information
 */
class FoodFormViewController: FormViewController {

    /// The id of the food shown in this form.
    /// If it is to add new food, it will use `Food.getAutoId`
    var foodId: String?

    /// The path to store the food image
    private var foodImagePath: String {
        return "/Menu" + "/\(Account.stallId)" + "/\(self.foodId ?? "")"
    }
    
    /*
     The tags of this food details form, need to be inherited
     by `EditFooViewController` to populate information row
     */
    enum Tag {
        static let name = "Name"
        static let price = "Price"
        static let description = "Description"
        static let type = "Type"
        static let image = "Image"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setValidationStyle()
        initializeForm()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
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
        form +++ Section("Food Details")
            <<< TextRow { row in
                row.tag = Tag.name
                row.title = "Food Name"
                row.placeholder = "Food name should not be empty"
                row.add(rule: RuleRequired())
                row.validationOptions = .validatesOnDemand
            }
            <<< DecimalRow { row in
                row.tag = Tag.price
                row.title = "Food Price"
                row.placeholder = "Food price should be a positive number"
                row.add(rule: RuleRequired())
                row.add(rule: RuleGreaterThan(min: 0))
                row.validationOptions = .validatesOnDemand
            }
            <<< ActionSheetRow<FoodType> { row in
                row.tag = Tag.type
                row.title = "Food Type"
                row.options = [FoodType.main, FoodType.soup,
                               FoodType.drink, FoodType.dessert]
                row.add(rule: RuleRequired())
                row.validationOptions = .validatesOnDemand
            }
            <<< TextRow { row in
                row.tag = Tag.description
                row.title = "Food Description"
            }
            <<< ImageRow { row in
                row.tag = Tag.image
                row.title = "Upload Food Photo"
            }.onChange { _ in
                let path = "/Menu" + "/\(Account.stallId)" + "/\(self.foodId ?? "")"
                UIImageView.addPathShouldBeRefreshed(path)
            }
            <<< ButtonRow { row in
                row.title = "Add Food Option"
            }.onCellSelection(addOptionSection(cell:row:))
    }

    /// Add the new food by informaion in the form, and store it
    /// Food Name, Food Price and Food Type are required, and others are optional
    func modifyMenu() {
        let valueDict = form.values()
        guard let id = foodId else {
            return
        }
        guard
            let foodName = valueDict[Tag.name] as? String,
            let foodPrice = valueDict[Tag.price] as? Double,
            foodPrice != Double.nan && foodPrice > 0,
            let foodType = valueDict[Tag.type] as? FoodType else {
                return
        }
        var photoPath: String?
        let path = "/Menu" + "/\(Account.stallId)" + "/\(id)"
        if
            let image = valueDict[Tag.image] as? UIImage,
            let imageData = image.standardData {
                photoPath = path
                StorageRef.upload(imageData, at: path)
        } 
        let foodDescription = valueDict[Tag.description] as? String

        let newFood = Food(id: id, name: foodName, price: foodPrice, description: foodDescription,
                           type: foodType, isSoldOut: false, photoPath: photoPath, options: getFoodOption())
        Account.stall?.addFood(newFood)
    }

    /// Retrieve the food option value from each section
    /// Return: A dictionary that pairs the option name and its values
    private func getFoodOption() -> [String: [String]]? {
        guard form.allSections.count > 1 else {
            return nil
        }
        var optionDict = [String: [String]]()
        form.allSections.dropFirst().forEach { section in
            guard let optionName = section.header?.title else {
                return
            }
            let optionRows = section.dropFirst(2)
            var optionContent = [String]()
            optionRows.forEach { row in
                guard let value = (row as? TextRow)?.value else {
                    return
                }
                optionContent.append(value)
            }
            optionDict[optionName] = optionContent
        }
        return optionDict
    }

    /// Check whether all fields of this form has valid input
    func hasValidInput() -> Bool {
        guard form.validate().isEmpty else {
            DialogHelpers.showAlertMessage(in: self, title: "Error",
                                           message: "Some required fields are empty") { _ in }
            return false
        }

        guard !hasDuplicateFoodName() else {
            DialogHelpers.showAlertMessage(in: self, title: "Error",
                                           message: "This food name has already existed in menu") { _ in }
            return false
        }

        guard !hasDuplicateOptionName() else {
            DialogHelpers.showAlertMessage(in: self, title: "Error",
                                           message: "Some food options have same name") { _ in }
            return false
        }
        return true
    }

    /// The whether this food name has already appears in the menu
    private func hasDuplicateFoodName() -> Bool {
        let foodNames = Account.stall?.menu?.values.map { food in
            return food.name
        }
        guard let foodName = form.values()[Tag.name] as? String else {
            return true
        }
        return foodNames?.contains(foodName) ?? true
    }

    ///  Check whether the option field has duplicated option names
    private func hasDuplicateOptionName() -> Bool {
        let optionNames = form.allSections.dropFirst().map { section in
            return section.header?.title ?? ""
        }
        return Set(optionNames).count < optionNames.count
    }

    /// Add a new section for food option
    private func addOptionSection(cell: ButtonCellOf<String>, row: ButtonRow) {
        form +++ MultivaluedSection(multivaluedOptions: [.Insert, .Delete], header: "", footer: "",
                                    multivalueSectionInitializer(_:))
    }

    /// Initialize a section of food option
    private func multivalueSectionInitializer(_ section: MultivaluedSection) {
        tableView.setEditing(true, animated: false)
        section.addButtonProvider = { section in
            return ButtonRow { row in
                row.title = "Add New Option Content"
            }.cellUpdate { cell, _ in
                cell.textLabel?.textAlignment = .left
            }
        }
        section.multivaluedRowToInsertAt = { index in
            return TextRow { row in
                row.title = "Content \(index - 1):"
                row.placeholder = "Option Content"
                row.add(rule: RuleRequired())
            }
        }

        section <<< ButtonRow { row in
            row.title = "Delete this option"
        }.onCellSelection { _, _ in
            DialogHelpers.promptConfirm(in: self, title: "Warning",
                                        message: "Do you want to delete this option") {
                guard let sectionIndex = section.index else {
                    return
                }
                self.form.remove(at: sectionIndex)
            }
        }

        section <<< TextRow { row in
            row.title = "Option Name"
            row.add(rule: RuleRequired())
        }.onChange { row in
            section.header?.title = row.value
        }
    }

    /// Show an alert message that the food is successfully add into menu
    func showSuccessAlert(message: String) {
        DialogHelpers.showAlertMessage(in: self, title: "Success", message: message) { _ in
            self.navigationController?.popViewController(animated: true)
        }
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return indexPath.item > 1
    }
}
