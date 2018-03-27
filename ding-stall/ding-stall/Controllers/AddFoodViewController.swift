//
//  AddFoodViewController.swift
//  ding-stall
//
//  Created by Jiang Chunhui on 27/03/18.
//  Copyright © 2018年 CS3217 Ding. All rights reserved.
//

import UIKit

class AddFoodViewController: UIViewController {

    static let identifier = "addFoodSegue"

    @IBOutlet var nameText: UITextField!
    @IBOutlet var priceText: UITextField!
    @IBOutlet var descriptionText: UITextField!

    var stall: Stall!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func addFood(_ sender: UIButton) {
        guard
            let name = nameText.text,
            let price = Double(priceText.text!),
            let description = descriptionText.text else {
                return
        }
        stall.addFood(name: name, price: price, description: description, type: .main)
    }
}
