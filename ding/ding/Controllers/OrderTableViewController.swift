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
    
    override func viewWillAppear(_ animated: Bool) {
        // Hide navigation bar
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        // Show navigation bar
        self.navigationController?.isNavigationBarHidden = false
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
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
        return orderTableView.dequeueReusableCell(withIdentifier: OrderTableViewCell.tableViewIdentifier) ?? UITableViewCell()
    }
}
