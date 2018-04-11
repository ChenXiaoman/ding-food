//
//  SettingsViewController.swift
//  ding-stall
//
//  Created by Jiang Chunhui on 24/03/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import UIKit
import Eureka
/**
 The controller for the application's setting view.
 */
class SettingsViewController: FormViewController {

    private var settings = Settings()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        loadForm()
    }

    private func loadForm() {
        form +++ Section("Open / Close Stall")
            <<< SwitchRow() { row in
                row.title = "Close (not receiving order)"
            }.onChange { row in
                let isOpen = row.value ?? false
                row.title = isOpen ? "Open (can receive order)" : "Close (cannot receiving order)"
                row.updateCell()

                // update stall oeverview in the database
                guard var stallOverview = Account.stallOverview else {
                    fatalError("Stall overview should be present after logging in")
                }

                stallOverview.isOpen = isOpen
                stallOverview.save()
            }

            +++ Section("Ringing")
            <<< SwitchRow() { row in
                row.title = "Disabled"
            }.onChange { row in
                let isRinging = row.value ?? false
                row.title = isRinging ? "Enabled" : "Disabled"
                row.updateCell()

                // update stall settings locally
                self.settings.setIsRinging(to: isRinging)
                print(self.settings.getIsRinging())
            }
    }
}
