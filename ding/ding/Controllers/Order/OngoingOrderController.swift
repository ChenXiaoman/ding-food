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
    @IBOutlet weak private var ongoingOrders: UICollectionView!
    @IBOutlet weak private var loadingIndicator: UIActivityIndicatorView!
    
    /// The Firebase data source for the listing of stalls.
    var dataSource: FUICollectionViewDataSource?
    /// Indicates whether the collection view has finished loading data.
    private var loaded = false

    /// A dictionary of mapping from cell's index path to the
    /// 'Order' object represented.
    var orders: [Int: Order] = [:]
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Shows navigation bar with shopping cart icon, but without back.
        navigationController?.setNavigationBarHidden(false, animated: animated)

        /// Performs permission checking.
        guard checkPermission() else {
            return
        }

        /// Performs timeout checking.
        checkLoadingTimeout(indicator: loadingIndicator, interval: Constants.timeoutInterval) {
            self.loadingIndicator.stopAnimating()
            self.alertTimeout()
        }

        /// Starts to load data of ongoing orders.
        startLoading()
        configureCollectionView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Stops sending updates to the collection view (to avoid app crash).
        dataSource?.unbind()
        // Stops the loading indicator (such that the timeout thread will not be triggered later).
        loadingIndicator.stopAnimating()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == Constants.ongoingOrderToShoppingCartId else {
            return
        }
        if UIView.onPhone {
            segue.destination.modalPresentationStyle = .none
        }
    }

    /// Bind Firebase data source to collection view
    private func configureCollectionView() {
        // Configures the collection view.
        let query = DatabaseRef.getNodeRef(of: Order.path)
            .queryOrdered(byChild: "customerId").queryEqual(toValue: authorizer.userId)
        dataSource = FUICollectionViewDataSource(query: query, populateCell: populateOngoingOrderCell)
        dataSource?.bind(to: ongoingOrders)
        ongoingOrders.delegate = self
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
            stopLoading()
        }

        if let order = Order.deserialize(snapshot) {
            // Loads the order infomation.
            cell.load(order)
            
            // Loads the related stall overview.
            let path = "\(StallOverview.path)/\(order.stallId)"
            DatabaseRef.observeValueOnce(of: path, onChange: cell.loadStoreOverview)

            // Stores this order for further retrieval.
            orders[indexPath.totalItem(in: collectionView)] = order

            // Plays the sound if the order is ready.
            if order.status == .ready {
                let sound = SoundEffectController()
                sound.play(.ring)
            }
        }
        return cell
    }
    
    /// Stops the loading indicator and changes the `loaded` status.
    private func stopLoading() {
        loaded = true
        loadingIndicator.stopAnimating()
    }
    
    /// Starts the loading indicator and changes the `loaded` status.
    private func startLoading() {
        loaded = false
        loadingIndicator.startAnimating()
    }
}
