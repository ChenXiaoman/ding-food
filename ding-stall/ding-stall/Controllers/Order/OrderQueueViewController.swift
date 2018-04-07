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
    @IBOutlet private var orderStatusPicker: UIPickerView!

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
    
    private let statusPickerData: [OrderStatus] = [.preparing, .rejected, .ready, .collected]
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Hide status picker
        orderStatusPicker.isHidden = true
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

    @IBAction func pressStatusButton(_ sender: UIButton) {
        guard let center = sender.superview?
            .convert(sender.center, to: sender.superview?.superview?.superview) else {
                return
        }
        guard let indexPath = orderQueueCollectionView.indexPathForItem(at: center) else {
            return
        }
        currentSelectedCell = orderQueueCollectionView.cellForItem(at: indexPath) as? OrderCollectionViewCell
        currentSelectedOrder = orderDict[indexPath]
        guard let newStatus = OrderStatus(rawValue: (sender.titleLabel?.text)!) else {
            return
        }
        changeOrderStatus(to: newStatus)
    }
}

extension OrderQueueViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //currentSelectedCell = collectionView.cellForItem(at: indexPath) as? OrderCollectionViewCell
        //currentSelectedOrder = orderDict[indexPath]
        //orderStatusPicker.isHidden = false
    }

    /// Sets the size of each cell.
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: OrderCollectionViewCell.width, height: OrderCollectionViewCell.height)
    }
}

/// Handle status picker
extension OrderQueueViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    // The number of columns of data
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return statusPickerData.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return statusPickerData[row].rawValue
    }
    
    // Catpure the picker view selection
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // This method is triggered whenever the user makes a change to the picker selection.
        // The parameter named row and component represents what was selected.
        
        // Hide status picker when a status is picked
        self.orderStatusPicker.isHidden = true
        
        // Set selected cell's status to new status
        changeOrderStatus(to: statusPickerData[row])
    }
}
