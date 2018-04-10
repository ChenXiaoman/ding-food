//
//  ProfileViewController.swift
//  ding-stall
//
//  Created by Jiang Chunhui on 24/03/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import Eureka

class ProfileViewController: StallFormViewController {

    private var currentStallOverview: StallOverview?

    private var stallPhoto: UIImage?

    func initialize(photo: UIImage) {
        stallPhoto = photo
        currentStallOverview = Account.stallOverview
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        populateRow()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Update", style: .done,
                                                            target: self,
                                                            action: #selector(updateStallInformation))
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setToolbarHidden(false, animated: false)
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

//        let maxImageSize = Int64(Constants.standardImageSize * Constants.bytesPerKiloByte)
//        let imageRow = form.rowBy(tag: Tag.photo) as? ImageRow
//        StorageRef.download(from: stallOverviewModel.photoPath, maxSize: maxImageSize) { data, error in
//            guard error == nil else {
//                DialogHelpers.showAlertMessage(in: self, title: "Error",
//                                               message: "Cannot display Stall Photo") { _ in }
//                return
//            }
//            imageRow?.populateImage(data: data, error: error)
//        }
    }

    private func addBehaviorWhenRowValueChanged() {
        
    }

    @objc
    private func updateStallInformation() {
        guard form.validate().isEmpty else {
            return
        }
        let valueDict = form.values()
        guard
            let name = valueDict[Tag.name] as? String,
            let description = valueDict[Tag.description] as? String,
            let location = valueDict[Tag.location] as? String,
            let openingHour = valueDict[Tag.openingHour] as? String,
            let photo = valueDict[Tag.photo] as? UIImage,
            let photoData = photo.standardData else {
                return
        }
        StorageRef.delete(at: Account.stallOverview?.photoPath ?? "")
        let photoPath = StallOverview.path + "\(StallOverview.getAutoId)"
        Account.stallOverview?.name = name
        Account.stallOverview?.description = description
        Account.stallOverview?.location = location
        Account.stallOverview?.openingHour = openingHour
        Account.stallOverview?.photoPath = photoPath
        Account.stallOverview?.save()
        StorageRef.upload(photoData, at: photoPath)
        showSuccessAlert(message: "Update successfully")
    }
}
