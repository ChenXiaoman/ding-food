//
//  StallDetailViewController.swift
//  ding
//
//  Created by Chen Xiaoman on 22/3/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import UIKit

class StallDetailViewController: UIViewController, UITableViewDataSource {
    @IBOutlet var foodTableaView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return foodTableaView.dequeueReusableCell(withIdentifier: FoodTableViewCell.tableViewIdentifier) ?? UITableViewCell()
    }
    
}
