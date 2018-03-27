//
//  SearchViewController.swift
//  ding
//
//  Created by Chen Xiaoman on 22/3/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import UIKit

/**
 The controller for search (stall listing) view.

 - Author: Group 3 @ CS3217
 - Date: March 2018
 */
class SearchViewController: UIViewController {
    /// The table view used to show the listing of stalls.
    @IBOutlet private var searchTableView: UITableView!

    override func viewWillAppear(_ animated: Bool) {
        // Hides the navigation bar
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
}

/**
 Extension for `SearchViewController` so that it can manage the table view.
 */
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return StallListingCell.height
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Fake data
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: StallListingCell.identifier)
            as? StallListingCell else {
            fatalError("Unable to dequeue cell.")
        }
        let stall = StallOverview(id: "123", name: "Western Food", queueCount: 10, averageRating: 4.7, photo: #imageLiteral(resourceName: "pizza"))
        cell.load(stall)
        return cell
    }
}
