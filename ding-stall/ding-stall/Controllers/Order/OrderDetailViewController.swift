//
//  OrderDetailViewController.swift
//  ding-stall
//
//  Created by Jiang Chunhui on 12/04/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import DingBase
import Eureka

/**
 Control a form to display details of an order.
 */
class OrderDetailViewController: FormViewController {

    private var order: Order?

    /// Intialize the order model by segue
    func initialize(order: Order) {
        self.order = order
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
        populateOrderDetails()
    }

    /// Populate the order details (food name, quantity, option choice)
    /// into form
    private func populateOrderDetails() {
        order?.foodName.keys.forEach { foodId in
            let section = Section(order?.foodName[foodId] ?? "")
            form +++ section
            section
                <<< TextRow { row in
                    row.title = "Food Name"
                    row.value = order?.foodName[foodId]
                    row.disabled = true
                }
                <<< IntRow { row in
                    row.title = "Food Quantity"
                    row.value = order?.foodQuantity[foodId]
                    row.disabled = true
                }

            order?.options?[foodId]?.forEach { key, value in
                section <<< TextRow { row in
                    row.title = key
                    row.value = value
                    row.disabled = true
                }
            }
        }
    }

}
