//
//  OrderDetailViewController+TableView.swift
//  ding
//
//  Created by Chen Xiaoman on 7/4/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import FirebaseDatabaseUI

extension OrderDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return order?.foodName.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FoodTableViewCell.tableViewIdentifier,
                                                            for: indexPath) as? FoodTableViewCell else {
                                                                fatalError("Unable to dequeue cell.")
        }
        guard let order = order else {
            fatalError("Nil order")
        }
        
        /// Gets the corresponding food object by its ID.
        let foodKey = Array(order.foodName.keys)[indexPath.totalRow(in: tableView)]
        let foodPath = StallDetails.path + "/\(order.stallId)\(Food.path)/" + foodKey
        DatabaseRef.observeValueOnce(of: foodPath, onChange: { (snapshot: DataSnapshot) in
            guard let food = Food.deserialize(snapshot) else {
                return
            }
            cell.load(food, with: order.foodQuantity[foodKey] ?? 0)
            DatabaseRef.stopObservers(of: foodPath)
        })
        
        return cell
    }
    
}
