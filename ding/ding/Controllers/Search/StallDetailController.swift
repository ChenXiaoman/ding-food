//
//  StallDetailViewController.swift
//  ding
//
//  Created by Chen Xiaoman on 22/3/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import UIKit
import FirebaseDatabaseUI

class StallDetailController: UIViewController {
    /// The text format to display queue count.
    private static let queueCountFormat = "Number of people waiting: %d"
    /// The text format to display average rating.
    private static let averageRatingFormat = "Average rating: %.1f"
    /// The text format to display description.
    private static let descriptionFormat = "\"%@\""
    
    /// Table view for displaying menu (list of food)
    @IBOutlet weak private var foodTableaView: UITableView!
    /// The loading indicator indicates that collection view is loading data.
    @IBOutlet weak private var loadingIndicator: UIActivityIndicatorView!
    
    /// Labels for displaying stall overview
    @IBOutlet weak private var stallImage: UIImageView!
    @IBOutlet weak private var nameLabel: UILabel!
    @IBOutlet weak private var descriptionLabel: UILabel!
    @IBOutlet weak private var averageRatingLabel: UILabel!
    @IBOutlet weak private var numOfPeopleWaitingLabel: UILabel!
    
    /// The Firebase data source for the menu
    var dataSource: FUITableViewDataSource?
    /// Indicates whether the collection view has finished loading data.
    private var loaded = false
    
    /// A dictionary of mapping from cell's index path to the
    /// correspoding food object
    var foods: [Int: Food] = [:]
    
    /// Firebase reference of the current stall's key
    /// in both store overview and stall details
    var stallKey: String?
    
    override func viewWillAppear(_ animated: Bool) {
        // Shows the navigation bar
        navigationController?.setNavigationBarHidden(false, animated: animated)
        
        // Indicates that loading starts.
        loaded = false
        loadingIndicator.startAnimating()
        
        // Configure the labels for stall overview
        guard let path = stallKey else {
            return
        }
        DatabaseRef.observeValue(of: "\(StallOverview.path)/\(path)", onChange: populateStallOverview)
        
        // Configures the table view.
        let query = DatabaseRef.getNodeRef(of: StallDetails.path + "/\(path)/\(Food.path)")
        dataSource = FUITableViewDataSource(query: query, populateCell: populateMenuCell)
        dataSource?.bind(to: foodTableaView)
        foodTableaView.delegate = self
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
    
    /// Get stall overview info from snapshot
    /// and populate to labels
    func populateStallOverview(snapshot: DataSnapshot) {
        guard let stallOverview = StallOverview.deserialize(snapshot) else {
            return
        }
        nameLabel.text = stallOverview.name
        stallImage.setWebImage(at: stallOverview.photoPath, placeholder: #imageLiteral(resourceName: "stall-placeholder"))
        averageRatingLabel.text = String(format: StallDetailController.queueCountFormat, stallOverview.queueCount)
        numOfPeopleWaitingLabel.text = String(format: StallDetailController.averageRatingFormat,
                                              stallOverview.averageRating)
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
        
        if let food = Food.deserialize(snapshot) {
            cell.load(food)
            foods[indexPath.totalRow(in: tableView)] = food
        }
        return cell
    }
}
