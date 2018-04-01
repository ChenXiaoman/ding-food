//
//  OrderQueueViewController.swift
//  ding-stall
//
//  Created by Jiang Chunhui on 24/03/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import UIKit
import FirebaseDatabaseUI

/**
 The controller for the order queue view
 Order queue only contains orders have not been collected
 */
class OrderQueueViewController: NoNavigationBarViewController {
    
    @IBOutlet private var orderQueueTableView: UITableView!

    fileprivate let authorizer = Authorizer()

    // Stall Order data from database
    fileprivate var stallOrderValues: NSDictionary?
    fileprivate let stallOrderPath = "\(StallOrders.path)/\(Account.stallId)/"

    fileprivate var tableViewDataSource: FUITableViewDataSource!

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        let query = DatabaseRef.getNodeRef(of: stallOrderPath)

        tableViewDataSource = orderQueueTableView.bind(to: query, populateCell: populateOrderCell)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        orderQueueTableView.delegate = self
    }

    private func populateOrderCell(view: UITableView, indexPath: IndexPath, snapshot: DataSnapshot) -> UITableViewCell {
        let cell = view.dequeueReusableCell(withIdentifier: StallOrderCell.identifier,
                                            for: indexPath) as! StallOrderCell

        if let order = Order.deserialize(snapshot) {
            cell.load(order)
        }

        return cell
    }
}

extension OrderQueueViewController: UITableViewDelegate {
    
    // Handle when a table view cell is selected
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO: think of what to do here.
        // Change status? If not just remove delegate
    }
}
