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

    @IBOutlet fileprivate var orderQueueTableView: UITableView!

    fileprivate var tableViewDataSource: FUITableViewDataSource?
    fileprivate var orderDict = [IndexPath: Order]()

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        // TODO: still need to order by createdAt?
        let query = DatabaseRef.getNodeRef(of: Order.path).queryOrdered(byChild: "stallId").queryEqual(toValue: Account.stallId)

        self.tableViewDataSource = FUITableViewDataSource(query: query, populateCell: populateOrderCell)

        tableViewDataSource?.bind(to: orderQueueTableView)
        orderQueueTableView.delegate = self
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableViewDataSource?.unbind()
    }

    private func populateOrderCell(view: UITableView, indexPath: IndexPath, snapshot: DataSnapshot) -> UITableViewCell {
        guard let cell = view.dequeueReusableCell(withIdentifier: StallOrderCell.identifier,
                                                  for: indexPath) as? StallOrderCell else {
            fatalError("Cell must be able to be downcasted to StallOrderCell")
        }

        if let order = Order.deserialize(snapshot) {
            cell.load(order)
            orderDict[indexPath] = order
            cell.delegate = self
        }

        return cell
    }
}

extension OrderQueueViewController: UITableViewDelegate {

    // Handle when a table view cell is selected
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO: think of what to do here.
        // Change status? If not just remove delegate method
    }
}

extension OrderQueueViewController: StallOrderCellDelegate {
    func changeOrderStatus(for cell: UITableViewCell) {
        guard var order = orderDict[orderQueueTableView.indexPath(for: cell)!] else {
            return
        }

        order.nextStatus()
        order.save()
    }
}

