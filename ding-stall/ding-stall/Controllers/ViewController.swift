//
//  ViewController.swift
//  ding-stall
//
//  Created by Yunpeng Niu on 16/03/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import UIKit
import FirebaseAuthUI

class ViewController: UIViewController, FUIAuthDelegate {
    override func viewDidAppear(_ animated: Bool) {
        if let authUI = FUIAuth.defaultAuthUI() {
            authUI.delegate = self
            present(authUI.authViewController(), animated: animated, completion: nil)
        }
    }

    func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) {
        // 
    }
}
