//
//  OrderTableViewController.swift
//  ding
//
//  Created by Chen Xiaoman on 22/3/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import UIKit

class OrderTableViewController: UIViewController, UITableViewDataSource {
    @IBOutlet private var orderTableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Fake data
        return 2
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // Fake data
        return 3
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        // Fake data
        switch section {
        case 0:
            return "Biz canteen"
        case 1:
            return "Com canteen"
        case 2:
            return "Deck"
        default:
            return "Unknown"
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Empty cell, need to add data inside later
        return orderTableView.dequeueReusableCell(withIdentifier:
            OrderTableViewCell.tableViewIdentifier) ?? UITableViewCell()
    }
}
