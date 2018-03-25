//
//  OrderQueueViewController.swift
//  ding-stall
//
//  Created by Jiang Chunhui on 24/03/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import UIKit

/**
 The controller for the order queue view
 Order queue only contains orders have not been collected
 */
class OrderQueueViewController: NoNavigationBarViewController {
    
    @IBOutlet private var orderQueueTableView: UITableView!
    @IBOutlet private var orderStatusPicker: UIPickerView!
    
    private var currentSellectedCell: OrderQueueTableViewCell?
    
    private let statusPickerData = ["rejected", "preparing", "ready for collect", "collected"]
    
    override func viewDidLoad() {
        // Hide status picker
        orderStatusPicker.isHidden = true
    }
    
}

extension OrderQueueViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Fake data
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return orderQueueTableView.dequeueReusableCell(withIdentifier: OrderQueueTableViewCell.tableViewIdentifier) ?? UITableViewCell()
    }
    
    // Handle when a table view cell is selected
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentSellectedCell = tableView.cellForRow(at: indexPath) as? OrderQueueTableViewCell
        // Show status picker
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
