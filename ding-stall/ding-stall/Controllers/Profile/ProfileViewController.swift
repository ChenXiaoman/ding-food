//
//  ProfileViewController.swift
//  ding-stall
//
//  Created by Jiang Chunhui on 24/03/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import Eureka

class ProfileViewController: StallFormViewController {

    /// The "memory" model to store the updates temporarily
    /// If the user commit the change, it will be written to database
    /// otherwise it will be aboarted
    private var currentStallOverview: StallOverview?

    /// The current photo of stall.
    /// Since the image need to be stored separated from other text information,
    /// assigning this value by segue other than download from web will
    /// accelerate the loading speed
    private var stallPhoto: UIImage?

    /// Initilize from segue by parent view controller
    func initialize(photo: UIImage) {
        stallPhoto = photo
        currentStallOverview = Account.stallOverview
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        populateRow()
        addBehaviorWhenRowValueChanged()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Update", style: .done,
                                                            target: self,
                                                            action: #selector(updateStallInformation))
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }

    /// Populate the row value by information in stall overview
    private func populateRow() {
        guard let stallOverviewModel = currentStallOverview else {
            return
        }
        (form.rowBy(tag: Tag.name) as? TextRow)?.value = stallOverviewModel.name
        (form.rowBy(tag: Tag.description) as? TextRow)?.value = stallOverviewModel.description
        (form.rowBy(tag: Tag.location) as? TextRow)?.value = stallOverviewModel.location
        (form.rowBy(tag: Tag.openingHour) as? TextRow)?.value = stallOverviewModel.openingHour
        (form.rowBy(tag: Tag.photo) as? ImageRow)?.value = stallPhoto
    }

    /// Add the behavior of each row when its value change
    /// Basically, the model in memory will change the value at same time
    /// But these changes will not be written to database at this stage
    private func addBehaviorWhenRowValueChanged() {
        guard
            let nameRow = form.rowBy(tag: Tag.name) as? TextRow,
            let descRow = form.rowBy(tag: Tag.description) as? TextRow,
            let locationRow = form.rowBy(tag: Tag.location) as? TextRow,
            let openhourRow = form.rowBy(tag: Tag.openingHour) as? TextRow else {
                return
        }
        nameRow.onChange { row in
            self.currentStallOverview?.name = row.value ?? ""
        }

        descRow.onChange { row in
            self.currentStallOverview?.description = row.value ?? ""
        }

        locationRow.onChange { row in
            self.currentStallOverview?.location = row.value ?? ""
        }

        openhourRow.onChange { row in
            self.currentStallOverview?.openingHour = row.value ?? ""
        }
    }

    /// If the user commit the update, all the new information
    /// of stall will be written to database
    @objc
    private func updateStallInformation() {
        guard form.validate().isEmpty else {
            DialogHelpers.showAlertMessage(in: self, title: "Error",
                                           message: "Some fields are empty") { _ in }
            return
        }

        guard let currentPhoto = (form.rowBy(tag: Tag.photo) as? ImageRow)?.value else {
            return
        }

        // If the photo has changed
        if !currentPhoto.isEqual(stallPhoto) {
            StorageRef.delete(at: currentStallOverview?.photoPath ?? "")
            let newPhotoPath = StallOverview.newPhotoPath
            currentStallOverview?.photoPath = newPhotoPath
            guard let photoData = currentPhoto.standardData else {
                DialogHelpers.showAlertMessage(in: self, title: "Error",
                                               message: "Unable to upload the new photo") { _ in }
                return
            }
            StorageRef.upload(photoData, at: newPhotoPath)
        }
        currentStallOverview?.save()
        Account.stallOverview = currentStallOverview
        showSuccessAlert(message: "Update successfully")
    }
}
