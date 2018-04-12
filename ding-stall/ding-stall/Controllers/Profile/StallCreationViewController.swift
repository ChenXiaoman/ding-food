//
//  StallCreationViewController.swift
//  ding-stall
//
//  Created by Jiang Chunhui on 08/04/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import Eureka

class StallCreationViewController: StallFormViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        addCreateButton()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    private func addCreateButton() {
        let buttonRow = ButtonRow()
        buttonRow.title = "Create Stall!"
        buttonRow.onCellSelection(createStall(cell:row:))
        form.allSections.first?.append(buttonRow)
    }

    /// Create stall after tapping "Create Stall" button
    /// - Parameters:
    ///     - cell: the button cell being tapped
    ///     - row: the button row in this form
    private func createStall(cell: ButtonCellOf<String>, row: ButtonRow) {
        guard form.validate().isEmpty else {
            DialogHelpers.showAlertMessage(in: self, title: "Error",
                                           message: "Some fields are invalid")
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

        let photoPath = StallOverview.newPhotoPath
        StorageRef.upload(photoData, at: photoPath)
        let stallOverview = StallOverview(id: id, name: name, photoPath: photoPath,
                                          location: location, openingHour: openingHour,
                                          description: description)
        stallOverview.save()
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
