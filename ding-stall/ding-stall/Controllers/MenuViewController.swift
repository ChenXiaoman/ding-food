//
//  MenuViewController.swift
//  ding-stall
//
//  Created by Jiang Chunhui on 24/03/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import UIKit

/**
 The controller of stall's menu view
 */
class MenuViewController: NoNavigationBarViewController {

    private let storage = Storage()

    func addFood(name: String, price: Double, description: String, type: FoodType) {
        let id = Food.getAutoId()
        let newFood = Food(id: id, name: name, price: price, description: description,
                           type: type, isSoldOut: false)
        storage.setChildNode(of: Food.path, to: newFood)
    }

    func deleteFood(id: String) {
        
    }
}
