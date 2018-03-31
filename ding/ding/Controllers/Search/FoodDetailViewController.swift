//
//  FoodDetailViewController.swift
//  ding
//
//  Created by Chen Xiaoman on 23/3/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import UIKit
import FirebaseDatabaseUI

class FoodDetailViewController: UIViewController {
    /// The current food object
    var food: Food?
    
    override func viewWillAppear(_ animated: Bool) {
        print(food?.name)
    }
}
