//
//  FoodFormViewController.swift
//  ding-stall
//
//  Created by Jiang Chunhui on 31/03/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import Eureka

class FoodFormViewController: FormViewController {
    
    let nameTag = "Name"
    let priceTag = "Price"
    let descriptionTag = "Description"
    let typeTag = "Type"
    let imageTag = "Image"

    var foodId: String?

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
        form +++ Section("Food Details")
            <<< TextRow { row in
                row.tag = nameTag
                row.title = "Food Name"
                row.placeholder = "Food name should not be empty"
                row.add(rule: RuleRequired())
                row.validationOptions = .validatesOnDemand
            }
            <<< DecimalRow { row in
                row.tag = priceTag
                row.title = "Food Price"
                row.placeholder = "Food price should be a positive number"
                row.add(rule: RuleRequired())
                row.add(rule: RuleGreaterThan(min: 0))
                row.validationOptions = .validatesOnDemand
            }
            <<< ActionSheetRow<FoodType> { row in
                row.tag = typeTag
                row.title = "Food Type"
                row.options = [FoodType.main, FoodType.soup,
                               FoodType.drink, FoodType.dessert]
                row.add(rule: RuleRequired())
                row.validationOptions = .validatesOnDemand
            }
            <<< TextRow { row in
                row.tag = descriptionTag
                row.title = "Food Description"
            }
            <<< ImageRow { row in
                row.tag = imageTag
                row.title = "Upload Food Photo"
            }.onChange { _ in
                let path = "/Menu" + "/\(Account.stallId)" + "/\(self.foodId ?? "")"
                UIImageView.addPathShouldBeRefreshed(path)
            }
    }

    /// Add the new food by informaion in the form, and store it
    /// Food Name, Food Price and Food Type are required, and others are optional
    func modifyMenu() {
        let valueDict = form.values()
        guard let id = foodId else {
            return
        }
        guard
            let foodName = valueDict[nameTag] as? String,
            let foodPrice = valueDict[priceTag] as? Double,
            foodPrice != Double.nan && foodPrice > 0,
            let foodType = valueDict[typeTag] as? FoodType else {
                return
        }
        var photoPath: String?
        let path = "/Menu" + "/\(Account.stallId)" + "/\(id)"
        if
            let image = valueDict[imageTag] as? UIImage,
            let imageData = standardizeImageData(image) {
                photoPath = path
                StorageRef.upload(imageData, at: path)
        } 
        let foodDescription = valueDict[descriptionTag] as? String

        let newFood = Food(id: id, name: foodName, price: foodPrice, description: foodDescription,
                           type: foodType, isSoldOut: false, photoPath: photoPath)
        Account.stall?.addFood(newFood)
    }

    /// Compress an image to avoid large-size image
    /// - Parameter:
    ///     - image: the original image
    /// - Return: the data of compressed image, nil if it cannot be compressed
    private func standardizeImageData(_ image: UIImage) -> Data? {
        let originalImageSize = image.size.width * image.size.height
        var quality = CGFloat(Constants.standardImageSize) / originalImageSize
        if quality > 1 {
            quality = 1
        }
        return UIImageJPEGRepresentation(image, quality)
    }

    /// Show an alert message that the food is successfully add into menu
    func showSuccessAlert(message: String) {
        DialogHelpers.showAlertMessage(in: self, title: "Success", message: message) { _ in
            self.navigationController?.popViewController(animated: true)
        }
    }
}
