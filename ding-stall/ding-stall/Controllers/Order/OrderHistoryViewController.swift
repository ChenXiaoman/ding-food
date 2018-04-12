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

    private var orderHistoryDict = [IndexPath: OrderHistory]()

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
            orderHistoryDict[indexPath] = orderHistory
            populateOrderCell(cell: cell, model: orderHistory.order)
        }
        return cell
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension OrderHistoryViewController {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let orderHistory = orderHistoryDict[indexPath] else {
            return
        }
        loadOrderHistoryDetailViewController(orderHistory: orderHistory, animated: true)
    }

    private func loadOrderHistoryDetailViewController(orderHistory: OrderHistory, animated: Bool) {
        let id = Constants.orderDetailControllerId
        guard let orderDetailVC = storyboard?.instantiateViewController(withIdentifier: id)
            as? OrderHistoryDetailViewController else {
                fatalError("Could not find the controller for order detail")
        }
        orderDetailVC.initialize(order: orderHistory.order, review: orderHistory.review)
        navigationController?.pushViewController(orderDetailVC, animated: animated)
    }
}
