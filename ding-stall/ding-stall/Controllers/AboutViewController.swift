//
//  AboutViewController.swift
//  ding-stall
//
//  Created by Yunpeng Niu on 23/03/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import UIKit

/**
 The controller for about view.

 - Author: Group 3 @ CS3217
 - Date: March 2018
 */
class AboutViewController: NoNavigationBarViewController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    /// Goes back to the previous view after enough times of tap gesture.
    @IBAction func handleTapGesture(_ sender: UITapGestureRecognizer) {
        navigationController?.popViewController(animated: true)
    }
}
