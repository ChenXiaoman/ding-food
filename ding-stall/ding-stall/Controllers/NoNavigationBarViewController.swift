//
//  NoNavigationBarViewController.swift
//  ding-stall
//
//  Created by Jiang Chunhui on 24/03/18.
//  Copyright © 2018年 CS3217 Ding. All rights reserved.
//

import UIKit

/**
 A super class which does not have the navigation bar
 */
class NoNavigationBarViewController: UIViewController {
    override func viewWillAppear(_ animated: Bool) {
        // Hide navigation bar
        self.navigationController?.isNavigationBarHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        // Show navigation bar
        self.navigationController?.isNavigationBarHidden = false
    }
}
