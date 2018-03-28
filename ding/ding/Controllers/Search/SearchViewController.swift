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
    @IBOutlet weak private var stallListing: UICollectionView!
    /// The loading indicator indicates that collection view is loading data
    @IBOutlet weak private var loadingIndicator: UIActivityIndicatorView!
    
    /// The Firebase data source for the listing of stalls.
    private var dataSource: FUICollectionViewDataSource?
    
    /// An array of Firebase StallOverview objects' key
    /// It is used for passing in ID when transfer to stall detail page
    var allStallsId: [String] = []

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Hides the navigation bar
        navigationController?.setNavigationBarHidden(true, animated: animated)

        // Configures the collection view.
        let query = DatabaseRef.getNodeRef(of: StallOverview.path)
        dataSource = FUICollectionViewDataSource(query: query, populateCell: populateStallListingCell)
        dataSource?.bind(to: stallListing)
        stallListing.delegate = self
        
        /// Add finish loading observer
        DatabaseRef.observeValue(of: StallOverview.path, onChange: firebaseFinishLoading)
    }
    
    /// Handle when firebase data have finished loading
    private func firebaseFinishLoading(snapshot: DataSnapshot) {
        // Stop animating of the loading indicator
        loadingIndicator.stopAnimating()
        
        getAllStallsId(with: snapshot)
    }
    
    /// Get all IDs of StallOverview objects from Firebase
    private func getAllStallsId(with snapshot: DataSnapshot) {
        guard let children = snapshot.value as? NSDictionary,
            let allKeys = children.allKeys as? [String] else {
            return
        }
        allStallsId = allKeys
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
