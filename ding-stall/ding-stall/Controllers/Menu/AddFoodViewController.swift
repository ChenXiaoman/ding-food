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
        foodId = Food.getAutoId
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .done,
                                                            target: self, action: #selector(addFood))
    }

    /// Add food into menu
    @objc
    private func addFood() {
        guard hasValidInput() else {
            return
        }
        modifyMenu()
        showSuccessAlert(message: "Add food successfully")
    }
}
