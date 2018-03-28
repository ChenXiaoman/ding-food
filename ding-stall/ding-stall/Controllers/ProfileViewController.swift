//
//  ProfileViewController.swift
//  ding-stall
//
//  Created by Jiang Chunhui on 24/03/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import UIKit

/**
 The controller for the stall's profile view.
 */
class ProfileViewController: UIViewController {

    var profileView: ProfileView!

    override func viewDidLoad() {
        super.viewDidLoad()
        loadView()
    }

    override func loadView() {
        profileView = ProfileView(frame: view.frame)
        view.addSubview(profileView)
    }
}
