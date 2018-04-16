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
    /// The loading indicator indicates that collection view is loading data.
    @IBOutlet weak private var loadingIndicator: UIActivityIndicatorView!
    /// The search bar used to search restaurants.
    @IBOutlet weak private var searchBar: UISearchBar!

    /// The Firebase data source for the listing of stalls.
    var dataSource: FUICollectionViewDataSource?
    /// Indicates whether the collection view has finished loading data.
    private var loaded = false
    
    /// A dictionary of mapping from cell's index path to the id of the stall
    /// overview represented.
    var stallIds: [Int: String] = [:]

    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkInternetConnection()
        // Hides the navigation bar
        navigationController?.setNavigationBarHidden(true, animated: animated)

        // Indicates that loading starts.
        loaded = false
        loadingIndicator.startAnimating()

        // Configures the collection view.
        let query = DatabaseRef.getNodeRef(of: StallOverview.path).queryOrdered(byChild: "name")
        dataSource = FUICollectionViewDataSource(query: query, populateCell: populateStallListingCell)
        dataSource?.bind(to: stallListing)
        stallListing.delegate = self

        // Configures the search bar.
        searchBar.delegate = self
        
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Stops sending updates to the collection view (to avoid app crash).
        dataSource?.unbind()
        // Stops the loading indicator (such that the timeout thread will not be triggered later).
        loadingIndicator.stopAnimating()
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

        // Stops the loading indicator.
        if !loaded {
            loaded = true
            loadingIndicator.stopAnimating()
        }

        guard let stall = StallOverview.deserialize(snapshot) else {
            return cell
        }
        
        cell.load(stall)
        stallIds[indexPath.totalItem(in: collectionView)] = stall.id
        
        return cell
    }
}

/**
 Extension for `SearchViewController` so that it can manage the search bar.
 */
extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        dataSource?.unbind()
        let query = DatabaseRef.getNodeRef(of: StallOverview.path).queryOrdered(byChild: "name")
            .queryStarting(atValue: searchText).queryEnding(atValue: searchText.queryStartedWith)
        dataSource = FUICollectionViewDataSource(query: query, populateCell: populateStallListingCell)
        dataSource?.bind(to: stallListing)
        stallListing.reloadData()
    }
}
