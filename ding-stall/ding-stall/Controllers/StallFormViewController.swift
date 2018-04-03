//
//  StallFormViewController.swift
//  ding-stall
//
//  Created by Jiang Chunhui on 03/04/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import Eureka
import UIKit

class StallFormViewController: FormViewController {

    private struct Tag {
        static let name = "Name"
        static let description = "Description"
        static let openingHour = "OpeningHour"
        static let location = "Location"
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
                row.value = "No description"
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
            <<< ButtonRow { row in
                row.value = "Create Stall!"
            }.onCellSelection(createStall(cell:row:))
    }

    private func createStall(cell: ButtonCellOf<String>, row: ButtonRow) {
        form.validate()
        let valueDict = form.values()
        guard
            let name = valueDict[Tag.name] as? String,
            let description = valueDict[Tag.description] as? String,
            let location = valueDict[Tag.location] as? String,
            let openingHour = valueDict[Tag.openingHour] as? String else {
                return
        }

        let stallId = Stall.getAutoId
        let stall = Stall(id: stallId, location: location, openingHour: openingHour,
                          description: description, menu: nil, queue: nil, filters: nil)
        stall.save()
        Account.stallId = stallId
        loadTabBarView(true)
    }

    /// Loads the main tab bar view from storyboard.
    /// - Parameter animated: If true, the view was added to the window using an animation.
    private func loadTabBarView(_ animated: Bool) {
        let id = Constants.tabBarControllerId
        guard let tabBarController = storyboard?.instantiateViewController(withIdentifier: id) else {
            fatalError("Could not find the controller for main tab bar")
        }
        navigationController?.pushViewController(tabBarController, animated: animated)
    }

}
