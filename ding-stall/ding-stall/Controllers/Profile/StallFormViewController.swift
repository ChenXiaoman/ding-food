//
//  StallFormViewController.swift
//  ding-stall
//
//  Created by Jiang Chunhui on 03/04/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import Eureka

/*
 A controller that create a form for user to fill in stall details
 */
class StallFormViewController: FormViewController {

    /// The stall id (user id) of the current login user
    var stallId: String?

    /*
     Tags of this stall detail form
    */
    enum Tag {
        static let name = "Name"
        static let description = "Description"
        static let openingHour = "OpeningHour"
        static let location = "Location"
        static let photo = "Photo"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setValidationStyle()
        initializeForm()
    }

    /// Set the style of cell to show whether it is valid
    private func setValidationStyle() {
        TextRow.defaultCellUpdate = { cell, row in
            if !row.isValid {
                cell.titleLabel?.textColor = .red
            }
        }
        ImageRow.defaultCellUpdate = { cell, row in
            if !row.isValid {
                cell.textLabel?.textColor = .red
            }
        }
        ActionSheetRow<Filter>.defaultCellUpdate = { cell, row in
            if !row.isValid {
                cell.textLabel?.textColor = .red
            }
        }
    }

    /// Build a form for adding new food
    private func initializeForm() {
        form +++ Section("Fill Your Stall Details")
            <<< TextRow { row in
                row.tag = Tag.name
                row.title = "Stall Name"
                row.placeholder = "Stall name should not be empty"
                row.add(rule: RuleRequired())
                row.validationOptions = .validatesOnDemand
            }
            <<< TextRow { row in
                row.tag = Tag.description
                row.title = "Stall Description"
                row.add(rule: RuleRequired())
                row.validationOptions = .validatesOnDemand
            }
            <<< TextRow { row in
                row.tag = Tag.location
                row.title = "Stall Address"
                row.placeholder = "Stall address should not be empty"
                row.add(rule: RuleRequired())
                row.validationOptions = .validatesOnDemand
            }
            <<< TextRow { row in
                row.tag = Tag.openingHour
                row.title = "Opening hours"
                row.add(rule: RuleRequired())
                row.validationOptions = .validatesOnDemand
            }
            <<< ImageRow { row in
                row.tag = Tag.photo
                row.title = "Upload photo of your stall"
                row.add(rule: RuleRequired())
                row.validationOptions = .validatesOnDemand
            }
        form +++ MultivaluedSection(multivaluedOptions: [.Insert, .Delete],
                                    header: "Add category of your stall", footer: "",
                                    initializeStallFilterSection)
    }

    /// Initializer of the stall filter section in this form, set the button provider
    /// and row to created
    /// Parameter: section: the section to be initialized
    private func initializeStallFilterSection(_ section: MultivaluedSection) {
        tableView.setEditing(true, animated: false)
        section.addButtonProvider = { section in
            return ButtonRow { row in
                row.title = "Add new category"
            }.cellUpdate { cell, _ in
                cell.textLabel?.textAlignment = .left
            }
        }

        section.multivaluedRowToInsertAt = { _ in
            return ActionSheetRow<Filter> { row in
                row.title = "Stall Category:"
                row.options = Account.allFilters
                row.add(rule: RuleRequired())
            }
        }
    }

    /// Retrieve the filter values from form and create a dictionary to store it
    func getFilters() -> [String: Filter]? {
        var filters = [String: Filter]()
        form.allSections.last?.forEach { row in
            guard let filter = (row as? ActionSheetRow<Filter>)?.value else {
                return
            }
            filters[filter.id] = filter
        }
        return !filters.isEmpty ? filters : nil
    }

    /// Show an alert message that the food is successfully add into menu
    func showSuccessAlert(message: String) {
        DialogHelpers.showAlertMessage(in: self, title: "Success", message: message) {
            self.navigationController?.popViewController(animated: true)
        }
    }
}
