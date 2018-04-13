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
    /// The 'Review' object which the view controller is displaying.
    var review: Review?
    
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
    
    /// Shows the review the user has submitted before
    /// by adding the corresponding review infomation to the empty form.
    private func setUpReviewSection() {
        // First sets up a empty form with default value
        setUpDefaultReviewSection()
        
        // If the review object is nil, it means the user has not
        // written a review yet.
        guard let review = review else {
            return
        }
        
        // The review is not nil. Sets up the value of the review
        guard let ratingRow = form.allRows.first as? SegmentedRow<String> else {
            return
        }
    }
    
    /// Sets up the empty review section using default
    /// value by adding rows in Eureka form
    private func setUpDefaultReviewSection() {
        // Makes the background color the same as the app's background color.
        tableView.backgroundColor = UIColor.white
        
        form +++
            Section(Constants.reviewSectionHeaderText)
            <<< SegmentedRow<String> {
                    let ratings = Rating.allStringsValueOfRatings
                    $0.options = ratings
                
                    // Always picks the middle one from ratings.
                    $0.value = ratings[ratings.count / 2]
                    $0.cell.tintColor = UIColor.darkGray
            }
            <<< TextAreaRow {
                $0.placeholder = Constants.reviewSectionRowText
            }
    }
}
