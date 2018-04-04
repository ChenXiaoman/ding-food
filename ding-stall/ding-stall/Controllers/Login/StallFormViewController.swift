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
    private enum Tag {
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

    override func viewDidAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func viewDidDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: false)
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
            <<< ImageRow { row in
                row.tag = Tag.photo
                row.title = "Upload photo of your stall"
                row.add(rule: RuleRequired())
                row.validationOptions = .validatesOnDemand
            }
            <<< ButtonRow { row in
                row.title = "Create Stall!"
            }.onCellSelection(createStall(cell:row:))
    }

    /// Create stall after tapping "Create Stall" button
    /// - Parameters:
    ///     - cell: the button cell being tapped
    ///     - row: the button row in this form
    private func createStall(cell: ButtonCellOf<String>, row: ButtonRow) {
        guard form.validate().isEmpty else {
            DialogHelpers.showAlertMessage(in: self, title: "Error",
                                           message: "Some fields are invalid") { _ in }
            return
        }
        let valueDict = form.values()
        guard
            let id = stallId,
            let name = valueDict[Tag.name] as? String,
            let description = valueDict[Tag.description] as? String,
            let location = valueDict[Tag.location] as? String,
            let openingHour = valueDict[Tag.openingHour] as? String,
            let photo = valueDict[Tag.photo] as? UIImage,
            let photoData = photo.standardData else {
                return
        }

        let photoPath = StallOverview.path + id
        StorageRef.upload(photoData, at: photoPath)
        let stallOverview = StallOverview(id: id, name: name, photoPath: photoPath)
        stallOverview.save()
        let stall = StallDetails(id: id, location: location, openingHour: openingHour,
                          description: description, menu: nil, queue: nil, filters: nil)
        stall.save()
        Account.stallId = id
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
