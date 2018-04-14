//
//  ReviewTableViewController.swift
//  ding
//
//  Created by Chen Xiaoman on 25/3/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import FirebaseDatabaseUI

class ReviewTableViewController: UIViewController, UITableViewDelegate {
    /// The lable displaying the overall review rating.
    @IBOutlet weak private var averageRating: UILabel!
    /// The table displaying list of reviews.
    @IBOutlet weak private var reviewTableView: UITableView!
    
    /// The 'StallOverView' object of the review table
    var stall: StallOverview?
    
    /// The Firebase data source for the listing of reviews.
    var dataSource: FUITableViewDataSource?
    
    // The text format to display average rating.
    private static let averageRatingFormat = "%.1f"
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureTableView()
        
        displayAverageRating()
    }
    
    private func displayAverageRating() {
        averageRating.text = String(format: ReviewTableViewController.averageRatingFormat,
                                    stall?.averageRating ?? 0)
    }
    
    /// Binds Firebase data source to table view.
    private func configureTableView() {
        guard let stall = stall else {
            return
        }
        
        let orderPath = OrderHistory.path
        let childPath = Review.path + Review.stallIdPath
        
        // Configures the table view.
        let query = DatabaseRef.getNodeRef(of: orderPath)
            .queryOrdered(byChild: childPath).queryEqual(toValue: stall.id)
        dataSource = FUITableViewDataSource(query: query, populateCell: populateReviewCell)
        dataSource?.bind(to: reviewTableView)
        reviewTableView.delegate = self
    }
    
    /// Populates a `ReviewTableViewCell` with the given data from database.
    /// - Parameters:
    ///    - tableView: The table view as the listing of reviews.
    ///    - indexPath: The index path of this cell.
    ///    - snapshot: The snapshot of the corresponding model object from database.
    /// - Returns: a `ReviewTableViewCell` to use.
    private func populateReviewCell(tableView: UITableView,
                                    indexPath: IndexPath,
                                    snapshot: DataSnapshot) -> ReviewTableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ReviewTableViewCell.tableViewIdentifier,
                                                            for: indexPath) as? ReviewTableViewCell else {
                                                                fatalError("Unable to dequeue cell.")
        }
        
        guard let orderHistory = OrderHistory.deserialize(snapshot) else {
            return cell
        }
        
        // Loads the order infomation.
        cell.load(orderHistory)
        
        return cell
    }

}
