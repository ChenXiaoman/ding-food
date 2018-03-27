//
//  SearchViewController.swift
//  ding
//
//  Created by Chen Xiaoman on 22/3/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import UIKit
import FirebaseDatabaseUI

/**
 The controller for search (stall listing) view.

 - Author: Group 3 @ CS3217
 - Date: March 2018
 */
class SearchViewController: UIViewController {
    /// The collection view used to show the listing of stalls.
    @IBOutlet private weak var stallListing: UICollectionView!

    override func viewWillAppear(_ animated: Bool) {
        // Hides the navigation bar
        navigationController?.setNavigationBarHidden(true, animated: animated)

        stallListing.delegate = self
        let query = Storage.getNodeRef(of: "/stalls")
        stallListing.dataSource = stallListing.bind(to: query, populateCell: populateStallListingCell)
    }

    private func populateStallListingCell(collectionView: UICollectionView,
                                          indexPath: IndexPath,
                                          snapshot: DataSnapshot) -> StallListingCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StallListingCell.identifier,
                                                            for: indexPath) as? StallListingCell else {
                                                                fatalError("Unable to dequeue cell.")
        }
        let stall = StallOverview(id: "123", name: "Western Food", queueCount: 10, averageRating: 4.7, photo: #imageLiteral(resourceName: "pizza"))
        cell.load(stall)
        return cell
    }
}
