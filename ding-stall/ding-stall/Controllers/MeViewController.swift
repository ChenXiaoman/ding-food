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
class MeViewController: NoNavigationBarViewController {
    /// The table view to use as the setting menu
    @IBOutlet private weak var settingMenu: UITableView!
    /// The photo of this stall
    @IBOutlet private weak var stallPhoto: UIImageView!
    /// Used to handle all logics related to Firebase Auth.
    private let authorizer = Authorizer()

    override func viewDidLoad() {
        super.viewDidLoad()

        settingMenu.delegate = self
        settingMenu.dataSource = self
        settingMenu.tableFooterView = UIView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let imageFrame = stallPhoto.frame
        guard let photoPath = Account.stallOverview?.photoPath else {
            stallPhoto.image = #imageLiteral(resourceName: "avatar")
            return
        }
        stallPhoto.setWebImage(at: photoPath, placeholder: #imageLiteral(resourceName: "avatar"))
        stallPhoto.frame = imageFrame
    }

}

/**
 Extension for `MeViewController` so that it can manage `UITableView`.
 */
extension MeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SettingMenuCellInfo.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.meSettingCellHeight
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.meSettingCellId,
                                                       for: indexPath) as? MeSettingMenuCell,
            let info = SettingMenuCellInfo(rawValue: indexPath.row) else {
            fatalError("Unable to get a new cell.")
        }
        cell.setName(info.name)
        cell.isDangerous = info.isDangerous

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let info = SettingMenuCellInfo(rawValue: indexPath.row) else {
            return
        }

        // Performs the corresponding action for each cell.
        switch info {
        case .logout:
            authorizer.signOut()
            navigationController?.popToRootViewController(animated: true)
        default:
            let id = info.toControllerId
            guard let controller = storyboard?.instantiateViewController(withIdentifier: id) else {
                return
            }
            navigationController?.pushViewController(controller, animated: true)
        }

        tableView.deselectRow(at: indexPath, animated: true)
    }
}

/**
 Contains information about the cells in setting menu of me scene.
 */
enum SettingMenuCellInfo: Int {
    case history
    case profile
    case setting
    case about
    case logout

    /// The number of cells.
    static let count = 5
    /// The labels of all cells.
    static let labels = ["Order History", "My Profile", "Settings", "About", "Log Out"]
    /// The identifier for all related controllers.
    static let controllerIds = [Constants.orderHistoryControllerId, Constants.profileControllerId,
                                Constants.settingsControllerId, Constants.aboutControllerId, ""]
    /// Indicates whether it is dangerous.
    static let isDangerous = [false, false, false, false, true]

    /// The name of a certain setting menu cell.
    var name: String {
        return SettingMenuCellInfo.labels[rawValue]
    }

    /// Indicates whether a certain setting menu cell is dangerous.
    var isDangerous: Bool {
        return SettingMenuCellInfo.isDangerous[rawValue]
    }

    /// The controller id to present next.
    var toControllerId: String {
        return SettingMenuCellInfo.controllerIds[rawValue]
    }
}
