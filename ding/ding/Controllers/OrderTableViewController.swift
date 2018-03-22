//
//  OrderTableViewController.swift
//  ding
//
//  Created by Chen Xiaoman on 22/3/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import UIKit

class OrderTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet private var orderTableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return orderTableView.dequeueReusableCell(withIdentifier: OrderTableViewCell.tableViewIdentifier) ?? UITableViewCell()
    }
}
