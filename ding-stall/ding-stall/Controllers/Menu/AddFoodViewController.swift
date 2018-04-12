//
//  AddFoodViewController.swift
//  ding-stall
//
//  Created by Jiang Chunhui on 27/03/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

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

    /// Add food into menu
    @objc
    private func addFood() {
        guard hasValidInput() else {
            return
        }
        let valueDict = form.values()
        guard
            let foodName = valueDict[Tag.name] as? String,
            let foodPrice = valueDict[Tag.price] as? Double,
            foodPrice != Double.nan && foodPrice > 0,
            let foodType = valueDict[Tag.type] as? FoodType,
            let isSoldOut = valueDict[Tag.soldOut] as? Bool else {
                return
        }
        let foodDescription = valueDict[Tag.description] as? String

        var photoPath: String?
        if let image = valueDict[Tag.image] as? UIImage {
            guard let imageData = image.standardData else {
                return
            }
            let path = Food.newPhotoPath
            photoPath = path
            StorageRef.upload(imageData, at: path)
        }

        let newFood = Food(id: Food.getAutoId, name: foodName, price: foodPrice, description: foodDescription,
                           type: foodType, isSoldOut: isSoldOut, photoPath: photoPath, options: getFoodOption())
        Account.stall?.addFood(newFood)
        showSuccessAlert(message: "Add food successfully")
    }
}
