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
class LoginViewController: UIViewController {
    /// Used to handle all logics related to Firebase Auth.
    fileprivate let authorizer = Authorizer()

    var stall: Stall!

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidAppear(_ animated: Bool) {

        // loadProfileView(animated)
        guard authorizer.didLogin else {
            loadLoginView(animated)
            return
        }

        loadTabBarView(animated)
    }

    private func loadProfileView(_ animated: Bool) {
        let id = Constants.profileControllerId
        guard let tabBarController = storyboard?.instantiateViewController(withIdentifier: id) else {
            fatalError("Could not find the controller for Profile View")
        }
        navigationController?.pushViewController(tabBarController, animated: animated)
    }

    /// Loads the login view from Firebase Auth UI library.
    /// - Parameter animated: If true, the view was added to the window using an animation.
    private func loadLoginView(_ animated: Bool) {
        if let authUI = FUIAuth.defaultAuthUI() {
            authUI.delegate = self
            present(authUI.authViewController(), animated: animated, completion: nil)
        }
    }

    /// Loads the main tab bar view from storyboard.
    /// - Parameter animated: If true, the view was added to the window using an animation.
    private func loadTabBarView(_ animated: Bool) {
        Account.setId(authorizer.userId)
        let id = Constants.tabBarControllerId
        guard let tabBarController = storyboard?.instantiateViewController(withIdentifier: id) else {
            fatalError("Could not find the controller for main tab bar")
        }
        navigationController?.pushViewController(tabBarController, animated: animated)
    }
}

/**
 Extension for `LoginViewController` to act as a delegate for Firebase Auth UI.
 */
extension LoginViewController: FUIAuthDelegate {
    func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) {
        guard let user = authDataResult?.user else {
            return
        }

        if !user.isEmailVerified {
            authorizer.verifyEmail()
        }

        loadTabBarView(true)
    }
}
