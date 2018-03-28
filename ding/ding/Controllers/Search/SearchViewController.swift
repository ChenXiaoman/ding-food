//
//  SearchViewController.swift
//  ding
//
//  Created by Chen Xiaoman on 22/3/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import FirebaseDatabaseUI

/**
 The controller for search (stall listing) view.

 - Author: Group 3 @ CS3217
 - Date: March 2018
 */
class SearchViewController: UIViewController {
    /// The collection view used to show the listing of stalls.
    @IBOutlet private weak var stallListing: UICollectionView!
    /// The Firebase data source for the listing of stalls.
    private var dataSource: FUICollectionViewDataSource?
    /// The collection of Firebase StallOverview objects
    var stallOverViewObjects: FUIArray?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Hides the navigation bar
        navigationController?.setNavigationBarHidden(true, animated: animated)

        // Configures the collection view.
        let query = DatabaseRef.getNodeRef(of: StallOverview.path)
        dataSource = FUICollectionViewDataSource(query: query, populateCell: populateStallListingCell)
        dataSource?.bind(to: stallListing)
        stallListing.delegate = self
        
        /// Get collection of StallOverview objects
        stallOverViewObjects = FUIArray(query: query)
    }

    /// Populates a `StallListingCell` with the given data from database.
    /// - Parameters:
    ///    - collectionView: The collection view as the listing of stalls.
    ///    - indexPath: The index path of this cell.
    ///    - snapshot: The snapshot of the corresponding model object from database.
    /// - Returns: a `StallListingCell` to use.
    private func populateStallListingCell(collectionView: UICollectionView,
                                          indexPath: IndexPath,
                                          snapshot: DataSnapshot) -> StallListingCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StallListingCell.identifier,
                                                            for: indexPath) as? StallListingCell else {
                                                                fatalError("Unable to dequeue cell.")
        }

        if var stall = StallOverview.deserialize(snapshot) {
            stall.photo = #imageLiteral(resourceName: "pizza")
            cell.load(stall)
        }
        return cell
    }
}
