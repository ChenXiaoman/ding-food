//
//  NoNavigationBarViewController.swift
//  ding-stall
//
//  Created by Jiang Chunhui on 24/03/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import UIKit

/**
 A super class which handles all controllers do not have the navigation bar
 */
class NoNavigationBarViewController: UIViewController {
    override func viewDidAppear(_ animated: Bool) {
        // Hide navigation bar
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func viewDidDisappear(_ animated: Bool) {
        // Show navigation bar
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
}
