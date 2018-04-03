//
//  OrderTableViewController.swift
//  ding
//
//  Created by Chen Xiaoman on 22/3/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import FirebaseDatabaseUI

/**
 The controller for current on-going order view.

 - Author: Group 3 @ CS3217
 - Date: March 2018
 */
class OngoingOrderController: UIViewController {
    /// Used to handle all logics related to Firebase Auth.
    private static let authorizer = Authorizer()

    @IBOutlet weak private var ongoingOrders: UICollectionView!
    @IBOutlet weak private var loadingIndicator: UIActivityIndicatorView!
    
    /// The Firebase data source for the listing of stalls.
    var dataSource: FUICollectionViewDataSource?
    /// Indicates whether the collection view has finished loading data.
    private var loaded = false

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Shows navigation bar with shopping cart icon, but without back.
        navigationController?.setNavigationBarHidden(false, animated: animated)

        // Indicates that loading starts.
        loaded = false
        loadingIndicator.startAnimating()

        // Configures the collection view.
        let query = DatabaseRef.getNodeRef(of: Order.path)
            .queryOrdered(byChild: "customerId").queryEqual(toValue: OngoingOrderController.authorizer.userId)
        dataSource = FUICollectionViewDataSource(query: query, populateCell: populateOngoingOrderCell)
        dataSource?.bind(to: ongoingOrders)
        ongoingOrders.delegate = self
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Stops sending updates to the collection view (to avoid app crash).
        dataSource?.unbind()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == Constants.ongoingOrderToShoppingCartId else {
            return
        }
        let width = Constants.screenWidth / 2
        let height = Constants.screenHeight / 2
        segue.destination.preferredContentSize = CGSize(width: width, height: height)
    }

    /// Populates a `OngoingOrderCell` with the given data from database.
    /// - Parameters:
    ///    - collectionView: The collection view as the listing of ongoing orders.
    ///    - indexPath: The index path of this cell.
    ///    - snapshot: The snapshot of the corresponding model object from database.
    /// - Returns: a `StallListingCell` to use.
    private func populateOngoingOrderCell(collectionView: UICollectionView,
                                          indexPath: IndexPath,
                                          snapshot: DataSnapshot) -> OngoingOrderCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OngoingOrderCell.identifier,
                                                            for: indexPath) as? OngoingOrderCell else {
            fatalError("Unable to dequeue cell.")
        }

        // Stops the loading indicator.
        if !loaded {
            loaded = true
            loadingIndicator.stopAnimating()
        }

        if let order = Order.deserialize(snapshot) {
            cell.load(order)
        }
        return cell
    }
}
