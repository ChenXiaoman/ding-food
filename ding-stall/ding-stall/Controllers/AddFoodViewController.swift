//
//  AddFoodViewController.swift
//  ding-stall
//
//  Created by Jiang Chunhui on 27/03/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import UIKit
import Eureka

class AddFoodViewController: FormViewController {

    let nameTag = "Name"
    let priceTag = "Tag"
    let descriptionTag = "Description"
    let typeTag = "Type"
    let imageTag = "Image"

    /// The stall model to add the new food
    var stall: Stall?

    override func viewDidLoad() {
        super.viewDidLoad()
        initializeForm()
        setValidationStyle()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .done,
                                                            target: self, action: #selector(addFood))
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DatabaseRef.observeValueOnce(of: Stall.path + "/\(Account.stallId)") { snapshot in
            self.stall = Stall.deserialize(snapshot)
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Stop observe to avoid memory leak
        DatabaseRef.stopObservers(of: Stall.path + "/\(Account.stallId)")
    }

    /// Set the style of cell to show whether it is valid
    private func setValidationStyle() {
        TextRow.defaultCellUpdate = { cell, row in
            if !row.isValid {
                cell.titleLabel?.textColor = .red
            }
        }

        DecimalRow.defaultCellUpdate = { cell, row in
            if !row.isValid {
                cell.titleLabel?.textColor = .red
            }
        }

        ActionSheetRow<FoodType>.defaultCellUpdate = { cell, row in
            if !row.isValid {
                cell.textLabel?.textColor = .red
            }
        }
    }

    /// Build a form for adding new food
    private func initializeForm() {
        form +++ Section("Food Information")
            <<< TextRow { row in
                row.tag = nameTag
                row.title = "Food Name"
                row.placeholder = "Food name should not be empty"
                row.add(rule: RuleRequired())
                row.validationOptions = .validatesAlways
            }
            <<< DecimalRow { row in
                row.tag = priceTag
                row.title = "Food Price"
                row.placeholder = "Food price should be a positive number"
                row.add(rule: RuleRequired())
                row.add(rule: RuleGreaterThan(min: 0))
                row.validationOptions = .validatesAlways
            }
            <<< ActionSheetRow<FoodType> { row in
                row.tag = typeTag
                row.title = "Food Type"
                row.options = [FoodType.main, FoodType.soup,
                               FoodType.drink, FoodType.dessert]
                row.add(rule: RuleRequired())
                row.validationOptions = .validatesAlways
            }
            <<< TextRow { row in
                row.tag = descriptionTag
                row.title = "Food Description"
            }
            <<< ImageRow { row in
                row.tag = imageTag
                row.title = "Upload Food Photo"
            }
        form.validate()
    }

    /// Add the new food by informaion in the form, and store it
    /// Food Name, Food Price and Food Type are required, and others are optional
    @objc
    private func addFood() {
        let valueDict = form.values()
        guard
            stall != nil,
            let foodName = valueDict[nameTag] as? String,
            let foodPrice = valueDict[priceTag] as? Double,
            foodPrice != Double.nan && foodPrice > 0,
            let foodType = valueDict[typeTag] as? FoodType else {
                return
        }
        let foodId = Food.getAutoId
        var photoPath: String?
        if
            let image = valueDict[imageTag] as? UIImage,
            let imageData = standardedSizeImageData(image) {
                let path = "/Menu" + "/\(Account.stallId)" + "/\(foodId)"
                photoPath = path
                StorageRef.upload(imageData, at: path)
        }
        let foodDescription = valueDict[descriptionTag] as? String

        let newFood = Food(id: foodId, name: foodName, price: foodPrice, description: foodDescription,
                           type: foodType, isSoldOut: false, photoPath: photoPath)
        stall?.addFood(newFood)
        addSuccessAlert()
    }

    /// Compress an image to avoid large-size image
    /// - Parameter:
    ///     - image: the original image
    /// - Return: the data of compressed image, nil if it cannot be compressed
    private func standardedSizeImageData(_ image: UIImage) -> Data? {
        let originalImageSize = image.size.width * image.size.height
        var quality = Constants.standardImageSize / originalImageSize
        if quality > 1 {
            quality = 1
        }
        return UIImageJPEGRepresentation(image, quality)
    }

    /// Show an alert message that the food is successfully add into menu
    private func addSuccessAlert() {
        DialogHelpers.showAlertMessage(in: self, title: "Success", message: "Add food successfully") { _ in
            self.navigationController?.popViewController(animated: true)
        }
    }
}
