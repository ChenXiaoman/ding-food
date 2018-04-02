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

    @objc
    private func addFood() {
        guard form.validate().isEmpty else {
            return
        }
        let foodId = Food.getAutoId
        modifyMenu(withFoodId: foodId)
        showSuccessAlert(message: "Add food successfully")
    }
}
