//
//  AddFoodViewController.swift
//  ding-stall
//
//  Created by Jiang Chunhui on 27/03/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import UIKit
import Eureka

/**
 A controller to handle adding new food to menu
 */
class AddFoodViewController: FoodFormViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .done,
                                                            target: self, action: #selector(addFood))
    }

    /// Add the new food by informaion in the form, and store it
    /// Food Name, Food Price and Food Type are required, and others are optional
    @objc
    private func addFood() {
        form.validate()
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
