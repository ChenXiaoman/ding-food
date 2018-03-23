//
//  LoginViewController.swift
//  ding-stall
//
//  Created by Yunpeng Niu on 23/03/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import UIKit
import FirebaseAuthUI

/**
 The controller for initial login view. However, this controller is only an adapter. The actual
 login view is managed by the Firebase-Auth-UI library.

 - Author: Group 3 @ CS3217
 - Date: March 2018
 */
class LoginViewController: UIViewController, FUIAuthDelegate {
    override func viewDidAppear(_ animated: Bool) {
        guard Auth.auth().currentUser != nil else {
            loadLoginView(animated)
            return
        }
    }

    func loadLoginView(_ animated: Bool) {
        if let authUI = FUIAuth.defaultAuthUI() {
            authUI.delegate = self
            present(authUI.authViewController(), animated: animated, completion: nil)
        }
    }

    func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) {
        guard let user = authDataResult?.user else {
            return
        }

        if !user.isEmailVerified {
            user.sendEmailVerification(completion: nil)
        }
    }
}
