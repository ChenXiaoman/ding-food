//
//  ProfileViewController.swift
//  ding-stall
//
//  Created by Jiang Chunhui on 24/03/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import DingBase
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
        if let filters = stallOverviewModel.filters {
            populateStallFilters(filters)
        }
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

    /// Populate the current filters of this stall into form
    /// Parameter: filters: the filter to be populated
    private func populateStallFilters(_ filters: [String: Filter]) {
        guard var filterSection = form.allSections.last as? MultivaluedSection else {
            return
        }
        filters.forEach { _, filter in
            guard let filterRow = filterSection
                .multivaluedRowToInsertAt?(filterSection.count - 1)
                as? ActionSheetRow<Filter> else {
                    return
            }
            filterRow.value = filter
            filterSection.insert(filterRow, at: filterSection.count - 1)
        }
    }

    /// If the user commit the update, all the new information
    /// of stall will be written to database
    @objc
    private func updateStallInformation() {
        guard form.validate().isEmpty else {
            DialogHelpers.showAlertMessage(in: self, title: "Error",
                                           message: "Some fields are empty")
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
                                               message: "Unable to upload the new photo")
                return
            }
            StorageRef.upload(photoData, at: newPhotoPath)
        }
        currentStallOverview?.filters = getFilters()
        currentStallOverview?.save()
        Account.stallOverview = currentStallOverview
        showSuccessAlert(message: "Update successfully")
    }
}
