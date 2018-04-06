//
//  OrderDetailViewController.swift
//  ding
//
//  Created by Chen Xiaoman on 6/4/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import FirebaseDatabaseUI

class OrderDetailViewController: UIViewController {
    /// Table view for displaying list of food.
    @IBOutlet weak private var foodTableView: UITableView!
    /// The 'Order' object which the view controller is displaying.
    var order: Order?
    
    override func viewWillAppear(_ animated: Bool) {
        // Shows the navigation bar
        navigationController?.setNavigationBarHidden(false, animated: animated)
        
    }
    
    /// Populates a `FoodTableViewCell` with the given data from database.
    /// - Parameters:
    ///    - tableView: The table view as the menu.
    ///    - indexPath: The index path of this cell.
    ///    - snapshot: The snapshot of the corresponding model object from database.
    /// - Returns: a `FoodTableViewCell` to use.
    private func populateMenuCell(tableView: UITableView,
                                  indexPath: IndexPath,
                                  snapshot: DataSnapshot) -> FoodTableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FoodTableViewCell.tableViewIdentifier,
                                                       for: indexPath) as? FoodTableViewCell else {
                                                        fatalError("Unable to dequeue cell.")
        }
        
        guard let food = Food.deserialize(snapshot) else {
            return cell
        }
        
        cell.load(food)
        
        return cell
    }

}
