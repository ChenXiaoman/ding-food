//
//  EditFoodViewController.swift
//  ding-stall
//
//  Created by Jiang Chunhui on 31/03/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import Eureka

class EditFoodViewController: FoodFormViewController {

    var foodId: String?
    private var food: Food? {
        didSet {
            populateFormValue()
        }
    }
    private var foodPath: String {
        return stallPath + Food.path + (foodId ?? "")
    }

    func initialize(with foodId: String) {
        self.foodId = foodId
        DatabaseRef.observeValue(of: foodPath) { snapshot in
            self.food = Food.deserialize(snapshot)
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        DatabaseRef.stopObservers(of: foodPath)
    }

    private func populateFormValue() {
        guard let foodModel = food else {
            print("Food is nil")
            return
        }
        (form.rowBy(tag: nameTag) as? TextRow)?.value = foodModel.name
        (form.rowBy(tag: priceTag) as? DecimalRow)?.value = foodModel.price
        (form.rowBy(tag: typeTag) as? ActionSheetRow<FoodType>)?.value = foodModel.type
        (form.rowBy(tag: descriptionTag) as? TextRow)?.value = foodModel.description
        //(form.rowBy(tag: imageTag) as? ImageRow)?.value = foodModel.name
    }
}
