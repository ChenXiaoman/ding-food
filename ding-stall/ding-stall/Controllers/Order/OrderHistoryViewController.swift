//
//  OrderHistoryViewController.swift
//  ding-stall
//
//  Created by Jiang Chunhui on 24/03/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import UIKit

/**
 The controller for the stall's order history view.
 Order history only contains orders have been collected
 */
class OrderHistoryViewController: OrderViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
}
