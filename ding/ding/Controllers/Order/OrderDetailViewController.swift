//
//  OrderDetailViewController.swift
//  ding
//
//  Created by Chen Xiaoman on 6/4/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import FirebaseDatabaseUI
import Eureka

class OrderDetailViewController: FormViewController {
    /// The UIView for displaying order information
    @IBOutlet weak private var orderView: OrderView!
    /// The UIView for review section.
    @IBOutlet weak private var reviewView: ReivewUIView!
    /// Table view for displaying list of food.
    @IBOutlet weak private var foodTableView: UITableView!
    /// The 'Order' object which the view controller is displaying.
    var order: Order?
    
    /// These two conflicting constraints will be
    /// resolved during runtime with method hideOrShowReview().
    /// Activates this contraint when reviewView is displaying.
    @IBOutlet weak private var reviewViewNormalConstraint: NSLayoutConstraint!
    /// Activates this contraint when reviewView is hidden.
    @IBOutlet weak private var reviewViewHiddenConstraint: NSLayoutConstraint!
    
    override func viewWillAppear(_ animated: Bool) {
        // Shows the navigation bar
        navigationController?.setNavigationBarHidden(false, animated: animated)
        
        // Loads the info about order
        guard let order = order else {
            return
        }
        orderView.load(order)
        
        hideOrShowReview()
        
        setUpFoodTableViewDataSource()
    }
    
    /// Manully sets the datasource of foodTableView to OrderFoodTableViewController
    /// because as a FormViewController, OrderDetailViewController
    /// cannot handle two TableView at the same time.
    private func setUpFoodTableViewDataSource() {
        guard let controller = storyboard?.instantiateViewController(withIdentifier:
            Constants.orderFoodTableViewControllerId)
            as? OrderFoodTableViewController else {
                return
        }
        controller.order = order
        foodTableView.dataSource = controller
        addChildViewController(controller)
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
            NSLayoutConstraint.activate([reviewViewNormalConstraint])
            NSLayoutConstraint.deactivate([reviewViewHiddenConstraint])
            setUpReviewSection()
        } else {
            NSLayoutConstraint.activate([reviewViewHiddenConstraint])
            NSLayoutConstraint.deactivate([reviewViewNormalConstraint])
        }
    }
    
    /// Sets up the review section by adding rows in
    /// Eureka form.
    private func setUpReviewSection() {
        // Makes the background color the same as the app's background color.
        tableView.backgroundColor = UIColor.white
        
        form +++
            Section(Constants.reviewSectionHeaderText)
            <<< SegmentedRow<String> {
                    $0.options = ["Bad", "Not good", "OK", "Good", "Excellent"]
                    $0.value = "OK"
                    $0.cell.tintColor = UIColor.darkGray
            }
            <<< TextAreaRow {
                $0.placeholder = Constants.reviewSectionRowText
            }
    }
}
