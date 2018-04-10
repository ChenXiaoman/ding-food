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

    private var foodPhoto: UIImage?

    private var currentFood: Food?

    /// Take the foodId parameter from the previous controller by segue.
    /// - Parameter: foodId: The id of food to be edited.
    func initialize(foodId: String, foodPhoto: UIImage?) {
        self.foodId = foodId
        self.foodPhoto = foodPhoto
        currentFood = Account.stall?.menu?[foodId]
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        populateFormValue()
        addBehaviorWhenRowValueChanged()
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

        guard let currentPhoto = (form.rowBy(tag: Tag.image) as? ImageRow)?.value else {
            return
        }
        if !currentPhoto.isEqual(foodPhoto) {
            StorageRef.delete(at: currentFood?.photoPath ?? "")
            let newPhotoPath = Food.newPhotoPath
            currentFood?.photoPath = newPhotoPath
            guard let photoData = currentPhoto.standardData else {
                DialogHelpers.showAlertMessage(in: self, title: "Error",
                                               message: "Unable to upload the new photo") { _ in }
                return
            }
            StorageRef.upload(photoData, at: newPhotoPath)
        }
        guard let addedFood = currentFood else {
            return
        }
        Account.stall?.addFood(addedFood)
        showSuccessAlert(message: "Update successfully")
    }

    /// Add the behavior of each row when its value change
    /// Basically, the model in memory will change the value at same time
    /// But these changes will not be written to database at this stage
    private func addBehaviorWhenRowValueChanged() {
        guard
            let nameRow = form.rowBy(tag: Tag.name) as? TextRow,
            let priceRow = form.rowBy(tag: Tag.price) as? DecimalRow,
            let descRow = form.rowBy(tag: Tag.description) as? TextRow,
            let typeRow = form.rowBy(tag: Tag.type) as? ActionSheetRow<FoodType> else {
                return
        }
        nameRow.onChange { row in
            self.currentFood?.name = row.value ?? ""
        }

        priceRow.onChange { row in
            self.currentFood?.price = row.value ?? 0
        }

        descRow.onChange { row in
            self.currentFood?.description = row.value ?? ""
        }

        typeRow.onChange { row in
            self.currentFood?.type = row.value ?? .main
        }
    }

    /// Populate the initial value in the form by information of selected food
    private func populateFormValue() {
        guard let foodModel = currentFood else {
            return
        }
        (form.rowBy(tag: Tag.name) as? TextRow)?.value = foodModel.name
        (form.rowBy(tag: Tag.price) as? DecimalRow)?.value = foodModel.price
        (form.rowBy(tag: Tag.type) as? ActionSheetRow<FoodType>)?.value = foodModel.type
        (form.rowBy(tag: Tag.description) as? TextRow)?.value = foodModel.description
        (form.rowBy(tag: Tag.image) as? ImageRow)?.value = foodPhoto
        if let optionDict = foodModel.options {
            populateFoodOption(optionDict)
        }
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
