//
//  StallDetailViewController.swift
//  ding
//
//  Created by Chen Xiaoman on 22/3/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import UIKit
import FirebaseDatabaseUI

class StallDetailController: UIViewController, UITableViewDataSource {
    /// The text format to display queue count.
    private static let queueCountFormat = "Number of people waiting: %d"
    /// The text format to display average rating.
    private static let averageRatingFormat = "Average rating: %.1f"
    
    /// Table view for displaying menu (list of food)
    @IBOutlet weak private var foodTableaView: UITableView!
    
    /// Labels for displaying stall overview
    @IBOutlet weak private var stallImage: UIImageView!
    @IBOutlet weak private var nameLabel: UILabel!
    @IBOutlet weak private var descriptionLabel: UILabel!
    @IBOutlet weak private var averageRatingLabel: UILabel!
    @IBOutlet weak private var numOfPeopleWaitingLabel: UILabel!
    
    /// Firebase reference of the current stall's overview
    var stallOverviewPath: String?
    
    override func viewWillAppear(_ animated: Bool) {
        // Hides the navigation bar
        navigationController?.setNavigationBarHidden(false, animated: animated)
        
        // Configure the labels for stall overview
        if let path = stallOverviewPath {
            DatabaseRef.observeValue(of: path, onChange: populateStallOverview)
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let path = stallOverviewPath {
            // Stops sending updates to the view (to avoid app crash).
            DatabaseRef.stopObservers(of: path)
        }
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Fake data
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return foodTableaView.dequeueReusableCell(withIdentifier:
            FoodTableViewCell.tableViewIdentifier) ?? UITableViewCell()
    }
    
}
