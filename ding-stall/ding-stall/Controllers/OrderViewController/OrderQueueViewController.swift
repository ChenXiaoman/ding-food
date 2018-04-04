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

    fileprivate var tableViewDataSource: FUITableViewDataSource?

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        let query = DatabaseRef.getNodeRef(of: Order.path).queryOrdered(byChild: "stallId").queryEqual(toValue: Account.stallId)

        self.tableViewDataSource = FUITableViewDataSource(query: query, populateCell: populateOrderCell)

        tableViewDataSource?.bind(to: orderQueueTableView)
        orderQueueTableView.delegate = self
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableViewDataSource?.unbind()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    private func populateOrderCell(view: UITableView, indexPath: IndexPath, snapshot: DataSnapshot) -> UITableViewCell {
        guard let cell = view.dequeueReusableCell(withIdentifier: StallOrderCell.identifier,
                                                  for: indexPath) as? StallOrderCell else {
            fatalError("Cell must be able to be downcasted to StallOrderCell")
        }
/*
        guard let dict = snapshot.value as? [String: Any] else {
            fatalError("cannot change to dict")
        }

        guard let data = try? JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted) else {
            fatalError("cannot")
        }

        guard let string = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else {
            fatalError("shit")
        }

        print(string)
*/
        if let order = Order.deserialize(snapshot) {
            cell.load(order)
        }
        cell.backgroundColor = .green
        cell.remarkLabel.text = "Somewhere over the rainbow, blue birds fly, birds fly over the rainbow, oh why can't oh can't i. coz i am a human damn it"
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

