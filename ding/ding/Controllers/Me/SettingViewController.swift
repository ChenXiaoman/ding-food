//
//  SettingViewController.swift
//  ding
//
//  Created by Yunpeng Niu on 12/04/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import Eureka

/**
 The controller for setting view.

 - Author: Group 3 @ CS3217
 - Date: April 2018
 */
class SettingViewController: FormViewController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        navigationController?.title = "Settings"
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Populates the form used to get settings input.
        form +++ Section("Settings")
            <<< SwitchRow { row in
                row.title = "Volume"
                row.value = UserDefaults.standard.bool(forKey: "volume")
            }.onChange { row in
                if let option = row.value {
                    UserDefaults.standard.set(option, forKey: "volume")
                }
            }
    }
}
