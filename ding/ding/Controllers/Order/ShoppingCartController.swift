//
//  ShoppingCartController.swift
//  ding
//
//  Created by Yunpeng Niu on 29/03/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import Eureka

/**
 The controller for the shopping cart.

 - Author: Group 3 @ CS3217
 - Date: March 2018
 */
class ShoppingCartController: FormViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        for cart in ShoppingCart.shoppingCarts {
            form +++ Section(cart.stall.name)
            guard let section = form.last else {
                continue
            }
            for food in cart.food {
                section <<< StepperRow(tag: food.key.name)
            }
        }
    }
}
