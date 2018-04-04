//
//  OrderQueueViewController.swift
//  ding-stall
//
//  Created by Jiang Chunhui on 24/03/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import FirebaseDatabaseUI
import UIKit

/**
 The controller for the order queue view
 Order queue only contains orders have not been collected
 */
class OrderQueueViewController: NoNavigationBarViewController {
    
    @IBOutlet private var orderQueueCollectionView: UICollectionView!
    @IBOutlet private var orderStatusPicker: UIPickerView!
    
    private var currentSellectedCell: OrderCollectionViewCell?

    /// The Firebase data source for the listing of food.
    var dataSource: FUICollectionViewDataSource?
    
    private let statusPickerData = ["rejected", "preparing", "ready for collect", "collected"]
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Hide status picker
        orderStatusPicker.isHidden = true
        let query = DatabaseRef.getNodeRef(of: Order.path).queryOrdered(byChild: "stallId")
            .queryEqual(toValue: Account.stallId)
        dataSource = FUICollectionViewDataSource(query: query, populateCell: populateOrderCell)
        dataSource?.bind(to: orderQueueCollectionView)
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
        }
        return cell
    }
    
}

extension OrderQueueViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        orderStatusPicker.isHidden = false
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
        return statusPickerData[row]
    }
    
    // Catpure the picker view selection
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // This method is triggered whenever the user makes a change to the picker selection.
        // The parameter named row and component represents what was selected.
        
        // Hide status picker when a status is picked
        self.orderStatusPicker.isHidden = true
        
        // Set selected cell's status to new status
        currentSellectedCell?.setStatus(to: statusPickerData[row])
    }
    
}
