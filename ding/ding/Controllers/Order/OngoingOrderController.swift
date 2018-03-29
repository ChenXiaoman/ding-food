//
//  OrderTableViewController.swift
//  ding
//
//  Created by Chen Xiaoman on 22/3/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import UIKit

/**
 The controller for current on-going order view.

 - Author: Group 3 @ CS3217
 - Date: March 2018
 */
class OngoingOrderController: UIViewController {
    @IBOutlet weak private var orderTableView: UITableView!
    
    @IBOutlet weak private var shoppingCartTableView: UITableView!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Shows navigation bar with shopping cart icon, but without back.
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == Constants.ongoingOrderToShoppingCartId else {
            return
        }
        let width = Constants.screenWidth / 2
        let height = Constants.screenHeight / 2
        segue.destination.preferredContentSize = CGSize(width: width, height: height)
    }
}

extension OngoingOrderController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Hadle two table views in one controller with if else
        if tableView == orderTableView {

        } else if tableView == shoppingCartTableView {

        }
        // Fake data
        return 2
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        // Fake data
        // Hadle two table views in one controller with if else
        if tableView == orderTableView {

        } else if tableView == shoppingCartTableView {

        }
        return 3
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        // Handles the two table views in one controller with if else
        if tableView == orderTableView {

        } else if tableView == shoppingCartTableView {

        }
        // Fake data
        switch section {
        case 0:
            return "Biz Chicken Rice"
        case 1:
            return "UTown Koufu Koreand"
        case 2:
            return "Deck"
        default:
            return "Unknown"
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Hadle two table views in one controller with if else
        if tableView == orderTableView {
            // Empty cell, need to add data inside later
            return orderTableView.dequeueReusableCell(withIdentifier:
                OrderTableViewCell.tableViewIdentifier) ?? UITableViewCell()
        } else if tableView == shoppingCartTableView {
            // Empty cell, need to add data inside later
            return shoppingCartTableView.dequeueReusableCell(withIdentifier:
                ShoppingCartTableViewCell.tableViewIdentifier) ?? UITableViewCell()
        }

        // Should never happen
        return UITableViewCell()
    }
}
