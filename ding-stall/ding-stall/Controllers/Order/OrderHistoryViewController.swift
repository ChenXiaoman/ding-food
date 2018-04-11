//
//  OrderHistoryViewController.swift
//  ding-stall
//
//  Created by Jiang Chunhui on 24/03/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import FirebaseDatabaseUI

/**
 The controller to display the stall's order history view.
 Order history only contains orders have been collected
 */
class OrderHistoryViewController: OrderViewController {
    
    @IBOutlet private weak var orderHistoryCollectionView: UICollectionView!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
        let query = DatabaseRef.getNodeRef(of: OrderHistory.path)
            .queryOrdered(byChild: "order/stallId")
            .queryEqual(toValue: Account.stallId)
        dataSource = FUICollectionViewDataSource(query: query, populateCell: generateOrderCell)
        dataSource?.bind(to: orderHistoryCollectionView)
        orderHistoryCollectionView.delegate = self
    }

    /// Generate a `OrderHistoryCollectionViewCell` with the given data from database.
    /// - Parameters:
    ///    - CollectionView: The Collection view as the listing of orders.
    ///    - indexPath: The index path of this cell.
    ///    - snapshot: The snapshot of the corresponding order object from database.
    /// - Returns: a `OrderHistoryCollectionViewCell` to use.
    private func generateOrderCell(collectionView: UICollectionView,
                                   indexPath: IndexPath,
                                   snapshot: DataSnapshot) -> OrderHistoryCollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier:
                                                                OrderHistoryCollectionViewCell.identifier,
                                                            for: indexPath) as? OrderHistoryCollectionViewCell else {
                                                                fatalError("Unable to dequeue a cell.")
        }

        if let orderHistory = OrderHistory.deserialize(snapshot) {
            populateOrderCell(cell: cell, model: orderHistory.order)
        }
        return cell
    }
}
