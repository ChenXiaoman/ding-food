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
        form +++ Section("Still receiving order")
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

            +++ Section("Rings for every new order")
            <<< SwitchRow() { row in
                row.title = "Disabled"
                row.value = settings.isRinging
            }.onChange { row in
                let isRinging = row.value ?? false
                row.title = isRinging ? "Enabled" : "Disabled"
                row.updateCell()

                // update stall settings locally
                self.settings.setIsRinging(to: isRinging)
            }

            +++ Section("Accepts new order automatically")
            <<< SwitchRow() { row in
                row.title = "Disabled"
                row.value = settings.isAutomaticAcceptOrder
            }.onChange { row in
                    let isAutomaticAcceptOrder = row.value ?? false
                    row.title = isAutomaticAcceptOrder ? "Enabled" : "Disabled"
                    row.updateCell()

                    // update stall settings locally
                    self.settings.setIsAutomaticAcceptOrder(to: isAutomaticAcceptOrder)
            }
    }
}
