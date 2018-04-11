//
//  OrderQueueViewController.swift
//  ding-stall
//
//  Created by Jiang Chunhui on 24/03/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import FirebaseDatabaseUI

/**
 The controller for the order queue view
 Order queue only contains orders have not been collected
 */
class OrderQueueViewController: UIViewController {
    
    @IBOutlet private var orderQueueCollectionView: UICollectionView!

    /// Indicate which order cell is selected, used for change the view
    private var currentSelectedCell: OrderCollectionViewCell?
    /// Indicate which order model is associated with the current selected cell
    private var currentSelectedOrder: Order?
    /// Store all order models in this stall
    private var orderDict = [IndexPath: Order]()
    /// The customer names of all orders
    private var nameDict = [String: String]()

    /// The Firebase data source for the listing of food.
    var dataSource: FUICollectionViewDataSource?
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Hide status picker
        navigationController?.setNavigationBarHidden(true, animated: false)
        let query = DatabaseRef.getNodeRef(of: Order.path).queryOrdered(byChild: "stallId")
            .queryEqual(toValue: Account.stallId)
        dataSource = FUICollectionViewDataSource(query: query, populateCell: populateOrderCell)
        dataSource?.bind(to: orderQueueCollectionView)
        orderQueueCollectionView.delegate = self
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Stop binding to avoid program crash
        dataSource?.unbind()
    }

    /// Populates a `OrderCollectionViewCell` with the given data from database.
    /// - Parameters:
    ///    - CollectionView: The Collection view as the listing of orders.
    ///    - indexPath: The index path of this cell.
    ///    - snapshot: The snapshot of the corresponding order object from database.
    /// - Returns: a `OrderCollectionViewCell` to use.
    private func populateOrderCell(collectionView: UICollectionView,
                                   indexPath: IndexPath,
                                   snapshot: DataSnapshot) -> OrderCollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OrderCollectionViewCell.identifier,
                                                            for: indexPath) as? OrderCollectionViewCell else {
                                                                fatalError("Unable to dequeue a cell.")
        }

        if let order = Order.deserialize(snapshot) {
            cell.load(order)
            orderDict[indexPath] = order

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
        return cell
    }

    /// Change the status of `currentSelectedOrder` to the new status
    /// The status label in the view will also be changed
    /// - Parameter: newStatus: The new status to be changed
    private func changeOrderStatus(to newStatus: OrderStatus) {
        // Change the model
        currentSelectedOrder?.status = newStatus
        currentSelectedOrder?.save()
        // Change the view
        currentSelectedCell?.setStatus(to: newStatus)
        // Set to nil to avoid affecting subsequent status change
        currentSelectedCell = nil
        currentSelectedOrder = nil
    }

    /// Handle pressing an order status button
    /// `currentSelectedCell` and `currentSelectedOrder` will be assigned by corresponding
    /// order cell and order model values
    @IBAction func pressStatusButton(_ sender: UIButton) {
        // Convert the button center from local cell frame to the whole collection view frame
        guard let center = sender.superview?
            .convert(sender.center, to: sender.superview?.superview?.superview) else {
                return
        }
        guard let indexPath = orderQueueCollectionView.indexPathForItem(at: center) else {
            return
        }
        currentSelectedCell = orderQueueCollectionView.cellForItem(at: indexPath) as? OrderCollectionViewCell
        currentSelectedOrder = orderDict[indexPath]
        guard
            let statusRawValue = sender.titleLabel?.text,
            let newStatus = OrderStatus(rawValue: statusRawValue) else {
                return
        }
        DialogHelpers.promptConfirm(in: self, title: "Confirm \(statusRawValue) ?",
                                    message: "Are you sure to change order status to be " + statusRawValue) {
                                        self.changeOrderStatus(to: newStatus)
        }
    }
}

extension OrderQueueViewController: UICollectionViewDelegateFlowLayout {

    /// Sets the size of each cell.
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: OrderCollectionViewCell.width, height: OrderCollectionViewCell.height)
    }
}
