//
//  StallOrderCell.swift
//  ding-stall
//
//  Created by Calvin Tantio on 2/4/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import UIKit
/*
 Table view cell for an order placed for a stall.
 */
class StallOrderCell: UITableViewCell {
    fileprivate struct BackgroundColor {
        static let red: UIColor = UIColor(red: 1, green: 0.3, blue: 0.3, alpha: 1)      // .rejected
        static let yellow: UIColor = UIColor(red: 1, green: 1, blue: 0.1, alpha: 1)     // .preparing
        static let green: UIColor = UIColor(red: 0.3, green: 1, blue: 0.2, alpha: 1)    // .ready
        static let blue: UIColor = UIColor(red: 0.4, green: 0.8, blue: 1, alpha: 1)     // .collected
    }

    public static let identifier = "StallOrderCell"

    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var singleOrderTableView: UITableView!
    @IBOutlet weak var remarkLabel: UILabel!
    @IBOutlet weak var stateButton: UIButton!

    fileprivate var order: Order!

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func load(_ order: Order) {
        self.order = order
        setLabels()
        setBackgroundColor()
    }

    private func setLabels() {
        userNameLabel.text = order.customerId
        remarkLabel.text = order.remark
        stateButton.setTitle(String(describing: order.status).capitalized, for: .normal)
    }

    private func setBackgroundColor() {
        switch order.status {
        case .rejected:
            backgroundColor = BackgroundColor.red
        case .preparing:
            backgroundColor = BackgroundColor.yellow
        case .ready:
            backgroundColor = BackgroundColor.green
        case .collected:
            backgroundColor = BackgroundColor.blue
        }
    }
}

//extension StallOrderCell: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return order.content.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        return
//    }
//}

