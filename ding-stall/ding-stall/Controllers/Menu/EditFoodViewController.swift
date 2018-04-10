//
//  EditFoodViewController.swift
//  ding-stall
//
//  Created by Jiang Chunhui on 31/03/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import Eureka

class EditFoodViewController: FoodFormViewController {

    /// The segue identifier from menu view to edit food view.
    static let segueIdentifier = "EditFoodSegue"

    /// Take the foodId parameter from the previous controller by segue.
    /// - Parameter: foodId: The id of food to be edited.
    func initialize(with foodId: String) {
        self.foodId = foodId
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        populateFormValue()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Update", style: .done,
                                                            target: self, action: #selector(updateFood))
    }

    /// Update the information of the selected food
    /// It will delete original food and add the new one
    @objc
    private func updateFood() {
        guard hasValidInput() else {
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
        (form.rowBy(tag: Tag.name) as? TextRow)?.value = foodModel.name
        (form.rowBy(tag: Tag.price) as? DecimalRow)?.value = foodModel.price
        (form.rowBy(tag: Tag.type) as? ActionSheetRow<FoodType>)?.value = foodModel.type
        (form.rowBy(tag: Tag.description) as? TextRow)?.value = foodModel.description
        if let optionDict = foodModel.options {
            populateFoodOption(optionDict)
        }
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
        let imageRow = form.rowBy(tag: Tag.image) as? ImageRow
        imageRow?.value = image
        imageRow?.updateCell()
    }

    /// Populate the food option 
    private func populateFoodOption(_ foodOptions: [String: [String]]) {
        for option in foodOptions.keys {
            let newSection = getNewOptionSection(header: option)
            form +++ newSection
            foodOptions[option]?.forEach { optionValue in
                guard let optionRow = newSection.multivaluedRowToInsertAt?(newSection.count - 1)
                    as? TextRow else {
                        return
                }
                optionRow.value = optionValue
                newSection <<< optionRow
            }
        }
    }
    
}
