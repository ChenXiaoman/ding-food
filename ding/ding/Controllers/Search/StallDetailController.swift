//
//  StallDetailViewController.swift
//  ding
//
//  Created by Chen Xiaoman on 22/3/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import DingBase
import FirebaseDatabaseUI

/**
 The controller for stall details view.

 - Author: Group 3 @ CS3217
 - Date: March 2018
 */
class StallDetailController: UIViewController {
    /// Table view for displaying menu (list of food).
    @IBOutlet weak private var foodTableView: UITableView!
    /// The loading indicator indicates that collection view is loading data.
    @IBOutlet weak private var loadingIndicator: UIActivityIndicatorView!
    /// The view for displaying general information about the stall.
    @IBOutlet weak private var stallOverviewView: StallOverviewView!
    /// The Firebase data source for the menu.
    var dataSource: FUITableViewDataSource?
    /// Indicates whether the collection view has finished loading data.
    private var loaded = false
    
    /// A dictionary of mapping from cell's index path to the correspoding food object.
    var foods: [Int: Food] = [:]

    /// The id of the current stall.
    var stallKey: String?
    /// The `StallOverview` object to contain all general information about this stall.
    var stall: StallOverview?
    
    override func viewWillAppear(_ animated: Bool) {
        // Shows the navigation bar
        navigationController?.setNavigationBarHidden(false, animated: animated)
        
        // Indicates that loading starts.
        loaded = false
        loadingIndicator.startAnimating()

        /// Performs timeout checking.
        checkLoadingTimeout(indicator: loadingIndicator, interval: Constants.timeoutInterval) {
            self.loadingIndicator.stopAnimating()
        }
        
        // Configure the `StallOverViewView`.
        guard let path = stallKey else {
            return
        }
        DatabaseRef.observeValue(of: "\(StallOverview.path)/\(path)", onChange: populateStallOverview)
        
        // Configures the table view.
        let query = DatabaseRef.getNodeRef(of: String(format: Food.menuPath, path))
        dataSource = FUITableViewDataSource(query: query, populateCell: populateMenuCell)
        dataSource?.bind(to: foodTableView)
        foodTableView.delegate = self
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let path = stallKey {
            // Stops sending updates to the view (to avoid app crash).
            DatabaseRef.stopObservers(of: "\(StallOverview.path)/\(path)")
        }
        // Stops sending updates to the collection view (to avoid app crash).
        dataSource?.unbind()
    }
    
    /// Populates the `StallOverviewView` whenever receiving data update from database.
    /// - Parameter snapshot: The database snapshot representing a `StallOverview` object.
    private func populateStallOverview(snapshot: DataSnapshot) {
        guard let stall = StallOverview.deserialize(snapshot) else {
            return
        }
        self.stall = stall
        
        // If the stall is closed,
        // User is not allowed to order any food.
        if stall.isOpen {
            foodTableView.allowsSelection = true
        } else {
            foodTableView.allowsSelection = false
        }
        stallOverviewView.load(stall: stall)
    }
    
    /// Populates a `FoodTableViewCell` with the given data from database.
    /// - Parameters:
    ///    - tableView: The table view as the menu.
    ///    - indexPath: The index path of this cell.
    ///    - snapshot: The snapshot of the corresponding model object from database.
    /// - Returns: a `FoodTableViewCell` to use.
    private func populateMenuCell(tableView: UITableView,
                                  indexPath: IndexPath,
                                  snapshot: DataSnapshot) -> FoodTableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FoodTableViewCell.tableViewIdentifier,
                                                       for: indexPath) as? FoodTableViewCell else {
            fatalError("Unable to dequeue cell.")
        }
        // Stops the loading indicator.
        if !loaded {
            loaded = true
            loadingIndicator.stopAnimating()
        }
        
        guard let food = Food.deserialize(snapshot) else {
            return cell
        }
        cell.load(food)
        foods[indexPath.totalRow(in: tableView)] = food
        
        return cell
    }
    
    /// The navigation bar click to review table view
    @IBAction func toReviews(_ sender: UIBarButtonItem) {
        let id = Constants.reviewTableViewControllerId
        guard let controller = storyboard?.instantiateViewController(withIdentifier: id)
            as? ReviewTableViewController else {
                return
        }
        // Passes `StallOverview` object of this view controller.
        controller.stall = stall
        navigationController?.pushViewController(controller, animated: true)
    }
}
