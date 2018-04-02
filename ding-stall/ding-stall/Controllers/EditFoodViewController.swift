//
//  EditFoodViewController.swift
//  ding-stall
//
//  Created by Jiang Chunhui on 31/03/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import Eureka

class EditFoodViewController: FoodFormViewController {

    /// The segue identifier from menu view to edit food view
    static let segueIdentifier = "EditFoodSegue"

    func initialize(with foodId: String) {
        self.foodId = foodId
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        populateFormValue()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Update", style: .done,
                                                            target: self, action: #selector(updateFood))
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }

    @objc
    private func updateFood() {
        guard form.validate().isEmpty else {
            return
        }
        guard let id = foodId else {
            return
        }
        Account.stall?.deleteFood(by: id)
        modifyMenu()
        showSuccessAlert(message: "Update successfully")
    }

    /// Populate the initial value in the form by information of selected food
    private func populateFormValue() {
        guard let foodModel = Account.stall?.menu?[foodId ?? ""] else {
            return
        }
        (form.rowBy(tag: nameTag) as? TextRow)?.value = foodModel.name
        (form.rowBy(tag: priceTag) as? DecimalRow)?.value = foodModel.price
        (form.rowBy(tag: typeTag) as? ActionSheetRow<FoodType>)?.value = foodModel.type
        (form.rowBy(tag: descriptionTag) as? TextRow)?.value = foodModel.description
        if let photoPath = foodModel.photoPath {
            let maxImageSize = Int64(Constants.standardImageSize * Constants.bytesPerKiloByte)
            StorageRef.download(from: photoPath, maxSize: maxImageSize, onComplete: populateImage)
        }
    }

    /// Populate the image row with the given image data
    /// - Parameters:
    ///    - data: the image data
    ///    - error: the error thrown during download
    private func populateImage(data: Data?, error: Error?) {
        guard error == nil else {
            DialogHelpers.showAlertMessage(in: self, title: "Error",
                                           message: "Food Image is too large to display") { _ in }
            return
        }
        guard let imageData = data else {
            return
        }
        let image = UIImage(data: imageData)
        let imageRow = form.rowBy(tag: imageTag) as? ImageRow
        imageRow?.value = image
        imageRow?.updateCell()
    }
}
