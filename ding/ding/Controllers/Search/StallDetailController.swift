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
    /// Table view for displaying menu (list of food)
    @IBOutlet weak private var foodTableaView: UITableView!
    
    /// Labels for displaying stall overview
    @IBOutlet weak private var nameLabel: UILabel!
    @IBOutlet weak private var descriptionLabel: UILabel!
    @IBOutlet weak private var averageRatingLabel: UILabel!
    @IBOutlet weak private var numOfPeopleWaitingLabel: UILabel!
    
    /// Firebase reference of the current stall's overview
    var stallOverviewId: String?
    
    override func viewWillAppear(_ animated: Bool) {
        // Hides the navigation bar
        navigationController?.setNavigationBarHidden(false, animated: animated)
        
        // Configure the labels for stall overview
        guard let stallOverviewId = stallOverviewId else {
            return
        }
        let stallOverviewPath = StallOverview.path + "/" + stallOverviewId
        DatabaseRef.observeValue(of: stallOverviewPath, onChange: populateStallOverview)
    }
    
    /// Get stall overview info from snapshot
    /// and populate to labels
    func populateStallOverview(snapshot: DataSnapshot) {
        guard let values = snapshot.value as? NSDictionary,
            let name = values[StallOverview.nameTitle] as? String,
            let rating = values[StallOverview.averageRatingTitle] as? Double,
            let numberOfPeople = values[StallOverview.queueCountTitle] as? Int else {
                return
        }
        nameLabel.text = name
        averageRatingLabel.text = "Average rating: \(rating)"
        numOfPeopleWaitingLabel.text = "Number of people waiting: \(numberOfPeople)"
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
