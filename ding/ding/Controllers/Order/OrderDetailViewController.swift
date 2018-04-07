//
//  OrderDetailViewController.swift
//  ding
//
//  Created by Chen Xiaoman on 6/4/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import FirebaseDatabaseUI

class OrderDetailViewController: UIViewController {
    /// The UIView for displaying order information
    @IBOutlet weak private var orderView: OrderView!
    /// The UIView for review section.
    @IBOutlet weak private var reviewView: ReivewUIView!
    /// Table view for displaying list of food.
    @IBOutlet weak private var foodTableView: UITableView!
    /// The 'Order' object which the view controller is displaying.
    var order: Order?
    
    override func viewWillAppear(_ animated: Bool) {
        // Shows the navigation bar
        navigationController?.setNavigationBarHidden(false, animated: animated)
        
        hideOrShowReview()
    }
    
    /// Checks whether an order is ready for review. An order is ready
    /// for review only if the status is collected.
    /// If no, hides the review section because review is not available.
    /// at this time. If yes, shows the review section.
    private func hideOrShowReview() {
        guard let order = order else {
            return
        }
        if order.status == OrderStatus.collected {
            reviewView.isHidden = false
        } else {
            reviewView.isHidden = true
        }
    }
}
