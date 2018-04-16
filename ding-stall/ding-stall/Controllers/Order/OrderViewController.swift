//
//  OrderViewController.swift
//  ding-stall
//
//  Created by Jiang Chunhui on 06/04/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import DingBase
import FirebaseDatabaseUI

class OrderViewController: UIViewController {
    /// The Firebase data source for the listing of food.
    var dataSource: FUICollectionViewDataSource?
    /// The customer names of all orders, since name need to be downloaded
    /// Use this local storage to store it will make it faster
    private var nameDict = [String: String]()

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Stop binding to avoid program crash
        dataSource?.unbind()
    }

    /// Populate an order cell with corresponding order model
    /// - Parameters:
    ///     - cell: The cell to be populated
    ///     - order: The data source of the order model
    func populateOrderCell(cell: OrderCollectionViewCell, model order: Order) {
        cell.load(order)
        if let customerName = nameDict[order.customerId] {
            cell.populateName(customerName)
        } else {
            // Avoid repeating download customer object
            DatabaseRef.observeValueOnce(of: Customer.path + "/\(order.customerId)") { snapshot in
                let customer = Customer.deserialize(snapshot)
                DatabaseRef.stopObservers(of: Customer.path + "/\(order.customerId)")
                cell.populateName(customer?.name ?? "")
                self.nameDict[order.customerId] = customer?.name
            }
        }
    }
}

extension OrderViewController: UICollectionViewDelegateFlowLayout {

    /// Sets the size of each cell.
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: OrderQueueCollectionViewCell.width, height: OrderQueueCollectionViewCell.height)
    }
}
