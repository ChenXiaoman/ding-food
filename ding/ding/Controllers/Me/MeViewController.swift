//
//  MeViewController.swift
//  ding
//
//  Created by Chen Xiaoman on 23/3/18.
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
    @IBOutlet weak private var settingMenu: UITableView!
    /// The `UIImageView` used to display avatar photo.
    @IBOutlet weak private var avatarPhoto: AvatarImageView!

    /// The profile of the current customer.
    var currentProfile: Customer?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        settingMenu.delegate = self
        settingMenu.dataSource = self
        settingMenu.tableFooterView = UIView()
        
        // Hides the navigation bar
        navigationController?.setNavigationBarHidden(true, animated: true)

        // Gets the current user's information.
        let path = "\(Customer.path)/\(authorizer.userId)"
        DatabaseRef.observeValueOnce(of: path) { snapshot in
            if let profile = Customer.deserialize(snapshot) {
                self.currentProfile = profile
                self.avatarPhoto.load(from: profile.avatarPath)
            }
            DatabaseRef.stopObservers(of: path)
        }
    }
}

/**
 Extension for `MeViewController` so that it can manage `UITableView`.
 */
extension MeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return authorizer.didLogin ? SettingMenuCellInfo.count : 1
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.meSettingCellHeight
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.meSettingCellId,
                                                       for: indexPath) as? SettingMenuCell,
            let info = SettingMenuCellInfo(rawValue: indexPath.row) else {
                fatalError("Unable to get a new cell.")
        }
        guard authorizer.didLogin else {
            cell.setName("Log in")
            cell.state = .info
            return cell
        }
        cell.setName(info.name)
        cell.state = info.state

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard authorizer.didLogin else {
            navigationController?.popViewController(animated: true)
            return
        }
        guard let info = SettingMenuCellInfo(rawValue: indexPath.row) else {
            return
        }

        // Performs the corresponding action for each cell.
        switch info {
        case .logout:
            authorizer.signOut()
            navigationController?.popToRootViewController(animated: true)
        case .history:
            let id = Constants.ongoingOrderControllerId
            guard let controller = storyboard?.instantiateViewController(withIdentifier: id)
                as? OrderController else {
                    return
            }
            controller.isShowingHistory = true
            navigationController?.pushViewController(controller, animated: true)
        case .profile:
            let id = Constants.profileViewControllerId
            guard let controller = storyboard?.instantiateViewController(withIdentifier: id)
                as? ProfileViewController else {
                    return
            }
            controller.currentProfile = currentProfile
            controller.avatarPhoto = avatarPhoto.image
            controller.parentController = self
            navigationController?.pushViewController(controller, animated: true)
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
    static let controllerIds = ["", "", Constants.settingViewControllerId, Constants.aboutViewControllerId, ""]

    /// The name of a certain setting menu cell.
    var name: String {
        return SettingMenuCellInfo.labels[rawValue]
    }

    /// Indicates whether a certain setting menu cell is dangerous.
    var state: SettingMenuCellState {
        return rawValue == 4 ? .danger : .normal
    }

    /// The controller id to present next.
    var toControllerId: String {
        return SettingMenuCellInfo.controllerIds[rawValue]
    }
}
