//
//  ReviewTableViewController.swift
//  ding
//
//  Created by Chen Xiaoman on 25/3/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import UIKit

class ReviewTableViewController: UIViewController {

    @IBOutlet private var reviewTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}

extension ReviewTableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Fake data
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Empty cell, need to add data inside later
        return reviewTableView.dequeueReusableCell(withIdentifier:
            ReviewTableViewCell.tableViewIdentifier) ?? UITableViewCell()
    }
    
}
