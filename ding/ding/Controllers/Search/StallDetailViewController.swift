//
//  StallDetailViewController.swift
//  ding
//
//  Created by Chen Xiaoman on 22/3/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import UIKit

class StallDetailViewController: UIViewController, UITableViewDataSource {
    @IBOutlet private var foodTableaView: UITableView!

    override func viewWillAppear(_ animated: Bool) {
        // Hides the navigation bar
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Fake data
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return foodTableaView.dequeueReusableCell(withIdentifier:
            FoodTableViewCell.tableViewIdentifier) ?? UITableViewCell()
    }
    
}
