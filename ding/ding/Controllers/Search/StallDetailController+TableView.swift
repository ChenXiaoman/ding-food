//
//  StallDetailController+TableView.swift
//  ding
//
//  Created by Chen Xiaoman on 29/3/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import UIKit

/**
 Extension for `StallDetailController` so that it can manage the table view.
 
 - Author: Group 3 @ CS3217
 - Date: March 2018
 */
extension StallDetailController: UITableViewDelegate {
    /// Jumps to stall details view when a certain is selected.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let id = Constants.foodDetailViewControllerId
        guard let controller = storyboard?.instantiateViewController(withIdentifier: id)
            as? FoodDetailViewController else {
                return
        }
        // Passes in the `id` of `Food` displayed at this cell.
        if let foodId = foodIds[indexPath.totalRow(in: tableView)],
            let stallKey = stallKey {
            controller.foodPath = "\(StallDetails.path)/\(stallKey)\(Food.path)/\(foodId)"
        }
        navigationController?.pushViewController(controller, animated: true)
    }
}
