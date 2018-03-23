//
//  MeViewController.swift
//  ding-stall
//
//  Created by Yunpeng Niu on 23/03/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import UIKit

/**
 The controller for me view.

 - Author: Group 3 @ CS3217
 - Date: March 2018
 */
class MeViewController: UIViewController {
    /// The table view to use as the setting menu
    @IBOutlet private weak var settingMenu: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        settingMenu.delegate = self
        settingMenu.dataSource = self
        settingMenu.tableFooterView = UIView()
    }
}

/**
 Extension for `MeViewController` so that it can manage `UITableView`.
 */
extension MeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SettingMenuInfo.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.meSettingCellHeight
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.meSettingCellId,
                                                       for: indexPath) as? MeSettingMenuCell,
            let info = SettingMenuInfo(rawValue: indexPath.row) else {
            fatalError("Unable to get a new cell.")
        }
        cell.setName(info.name)
        cell.isDangerous = info.isDangerous

        return cell
    }
}

/**
 Contains information about the cells in setting menu of me scene.
 */
enum SettingMenuInfo: Int {
    case history
    case profile
    case setting
    case about
    case logout

    /// The number of cells.
    static let count = 5
    /// The labels of all cells.
    static let labels = ["Order History", "My Profile", "Settings", "About", "Log Out"]
    /// Indicates whether it is dangerous.
    static let isDangerous = [false, false, false, false, true]

    /// The name of a certain setting menu cell.
    var name: String {
        return SettingMenuInfo.labels[rawValue]
    }

    /// Indicates whether a certain setting menu cell is dangerous.
    var isDangerous: Bool {
        return SettingMenuInfo.isDangerous[rawValue]
    }
}
