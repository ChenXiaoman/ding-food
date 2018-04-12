//
//  ProfileViewController.swift
//  ding
//
//  Created by Yunpeng Niu on 12/04/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import Eureka

/**
 The controller for profile view.

 - Author: Group 3 @ CS3217
 - Date: April 2018
 */
class ProfileViewController: FormViewController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        navigationController?.title = "Edit My Profile"
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Populates the form used to get settings input.
        form +++ Section("My Profile")
            <<< TextRow { row in
                row.title = "Email Address"
                row.value = authorizer.email
                row.disabled = true
            }
            <<< TextRow { row in
                row.title = "Name"
                row.value = authorizer.userName
                row.disabled = true
            }
            <<< ImageRow { row in
                row.title = "Upload avatar"
            }
    }
}
