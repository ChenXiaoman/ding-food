//
//  OrderDetailViewController.swift
//  ding
//
//  Created by Chen Xiaoman on 6/4/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import FirebaseDatabaseUI

class OrderDetailViewController: UIViewController {
    /// Table view for displaying list of food.
    @IBOutlet weak private var foodTableView: UITableView!
    /// The 'Order' object which the view controller is displaying.
    var order: Order?
    
    override func viewWillAppear(_ animated: Bool) {
        // Shows the navigation bar
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }    
}
