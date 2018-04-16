//
//  SettingsViewController.swift
//  ding-stall
//
//  Created by Jiang Chunhui on 24/03/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import Eureka

/**
 The controller for the application's setting view.
 */
class SettingsViewController: FormViewController {

    private var stallOverview: StallOverview?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        stallOverview = Account.stallOverview
        loadForm()
    }

    private func loadForm() {
        form +++ Section("Still receiving order")
            <<< SwitchRow { row in
                row.value = stallOverview?.isOpen
                row.title = (row.value ?? false) ? "Open (can receive order)" : "Close (not receiving order)"
            }.onChange { row in
                let isOpen = row.value ?? false
                row.title = isOpen ? "Open (can receive order)" : "Close (cannot receiving order)"
                row.updateCell()

                // update stall oeverview in the database
                self.stallOverview?.isOpen = isOpen
                self.stallOverview?.save()
            }

            +++ Section("Rings for every new order")
            <<< SwitchRow { row in
                row.value = Settings.isRinging
                row.title = (row.value ?? false) ? "Enabled" : "Disabled"
            }.onChange { row in
                let isRinging = row.value ?? false
                row.title = isRinging ? "Enabled" : "Disabled"
                row.updateCell()

                // update stall settings locally
                Settings.isRinging = isRinging
            }

            +++ Section("Accepts new order automatically")
            <<< SwitchRow { row in
                row.value = Settings.isAutomaticAcceptOrder
                row.title = (row.value ?? false) ? "Enabled" : "Disabled"
            }.onChange { row in
                    let isAutomaticAcceptOrder = row.value ?? false
                    row.title = isAutomaticAcceptOrder ? "Enabled" : "Disabled"
                    row.updateCell()

                    // update stall settings locally
                    Settings.isAutomaticAcceptOrder = isAutomaticAcceptOrder
            }
    }
}
