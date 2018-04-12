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
    var foodId: String?
    
    /*
     The tags of this food details form, need to be inherited
     by `EditFooViewController` to populate information row
     */
    enum Tag {
        static let name = "Name"
        static let price = "Price"
        static let description = "Description"
        static let type = "Type"
        static let soldOut = "isSoldOut"
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

    /// Set the style of rows to show whether it is valid
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

    /// Build a form for food information
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
                row.options = [FoodType.main, FoodType.side, FoodType.drink]
                row.add(rule: RuleRequired())
                row.validationOptions = .validatesOnDemand
            }
            <<< TextRow { row in
                row.tag = Tag.description
                row.title = "Food Description"
            }
            <<< SwitchRow { row in
                row.tag = Tag.soldOut
                row.title = "Is Sold Out?"
                row.value = false
            }
            <<< ImageRow { row in
                row.tag = Tag.image
                row.title = "Upload Food Photo"
            }
            <<< ButtonRow { row in
                row.title = "Add Food Option"
            }.onCellSelection { _, _ in
                self.form +++ self.getNewOptionSection(header: "")
            }
    }

    /// Retrieve the food option value from each section
    /// Return: A dictionary that pairs the option name and its values
    func getFoodOption() -> [String: [String]]? {
        guard form.allSections.count > 1 else {
            return nil
        }
        var optionDict = [String: [String]]()
        form.allSections.dropFirst().forEach { section in
            guard let optionName = section.header?.title else {
                return
            }
            let optionRows = section.dropFirst(2)
            var optionChoices = [String]()
            optionRows.forEach { row in
                guard let value = (row as? TextRow)?.value else {
                    return
                }
                optionChoices.append(value)
            }
            optionDict[optionName] = optionChoices
        }
        return optionDict
    }

    /// Check whether all fields of this form has valid input
    func hasValidInput() -> Bool {
        guard form.validate().isEmpty else {
            DialogHelpers.showAlertMessage(in: self, title: "Error",
                                           message: "Some required fields are empty")
            return false
        }
        
        guard !hasDuplicateFoodName() else {
            DialogHelpers.showAlertMessage(in: self, title: "Error",
                                           message: "This food name has already existed in menu")
            return false
        }

        guard !hasDuplicateOptionName() else {
            DialogHelpers.showAlertMessage(in: self, title: "Error",
                                           message: "Some food options have same name")
            return false
        }

        guard !hasDuplicateChoicesInOption() else {
            DialogHelpers.showAlertMessage(in: self, title: "Error",
                                           message: "Some food options have duplicated choices")
            return false
        }

        guard hasEnoughChoicesForOption() else {
            DialogHelpers.showAlertMessage(in: self, title: "Error",
                                           message: "Each option must have at least 2 choices")
            return false
        }
        return true
    }

    /// The whether this food name has already appears in the menu
    /// Case insensitive
    private func hasDuplicateFoodName() -> Bool {
        let allFoodNames = Account.stall?.menu?.values.map { food in
            return food.name.lowercased()
        }
        guard let currentFoodName = (Account.stall?.menu?[foodId ?? ""]?.name)?.lowercased() else {
            return false
        }
        var otherFoodNames = Set(allFoodNames ?? [String]())
        otherFoodNames.remove(currentFoodName)
        guard let foodName = (form.values()[Tag.name] as? String)?.lowercased() else {
            return false
        }
        return otherFoodNames.contains(foodName)
    }

    /// Check whether the option field has duplicated option names
    /// Case insensitive
    private func hasDuplicateOptionName() -> Bool {
        let optionNames = form.allSections.dropFirst().map { section in
            return section.header?.title?.lowercased() ?? ""
        }
        return Set(optionNames).count < optionNames.count
    }

    /// Check whether a food option has duplicate choices
    /// Case insensitive
    private func hasDuplicateChoicesInOption() -> Bool {
        for options in form.allSections.dropFirst() {
            let choiceRows = options.dropFirst(2)
            let choicesText = choiceRows.map { row in
                return (row as? TextRow)?.value?.lowercased() ?? ""
            }
            guard Set(choicesText).count == choicesText.count else {
                return true
            }
        }
        return false
    }

    /// Check whether each option has at least 2 choices
    private func hasEnoughChoicesForOption() -> Bool {
        let allOptions = form.allSections.dropFirst()
        for option in allOptions
            where option.count < Constants.minimumLinesInFoodOptionSection {
                return false
        }
        return true
    }

    /// Create and return a new section for food option
    /// Parameter: header: the header title of this sction
    func getNewOptionSection(header: String) -> MultivaluedSection {
        return MultivaluedSection(multivaluedOptions: [.Insert, .Delete], header: header, footer: "",
                                  multivalueSectionInitializer(_:))
    }

    /// Initialize a section of food option
    private func multivalueSectionInitializer(_ section: MultivaluedSection) {
        tableView.setEditing(true, animated: false)
        section.addButtonProvider = { section in
            return ButtonRow { row in
                row.title = "Add New Option Choice"
            }.cellUpdate { cell, _ in
                cell.textLabel?.textAlignment = .left
            }
        }
        section.multivaluedRowToInsertAt = { index in
            return TextRow { row in
                row.title = "Choice \(index - 1):"
                row.placeholder = "Option Choice"
                row.add(rule: RuleRequired())
            }
        }

        section <<< ButtonRow { row in
            row.title = "Delete this option"
        }.onCellSelection { _, _ in
            DialogHelpers.promptConfirm(in: self, title: "Warning",
                                        message: "Do you want to delete this option", cancelButtonText: "Cancel") {
                guard let sectionIndex = section.index else {
                    return
                }
                self.form.remove(at: sectionIndex)
            }
        }

        section <<< TextRow { row in
            row.title = "Option Name"
            row.value = section.header?.title
            row.add(rule: RuleRequired())
        }.onChange { row in
            section.header?.title = row.value
        }
    }

    /// Show an alert message that the food is successfully add into menu
    func showSuccessAlert(message: String) {
        DialogHelpers.showAlertMessage(in: self, title: "Success", message: message) {
            self.navigationController?.popViewController(animated: true)
        }
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return indexPath.item > 1
    }
}
