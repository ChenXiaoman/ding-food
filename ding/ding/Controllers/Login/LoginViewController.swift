//
//  LoginViewController.swift
//  ding
//
//  Created by Yunpeng Niu on 24/03/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import FirebaseAuthUI

/**
 The primary controller for all functionalities related to user login. This
 is a more complicated process than the one in stall-facing application since
 we have to integrate with NUSNET login API.

 - Author: Group 3 @ CS3217
 - Date: March 2018
 */
class LoginViewController: UIViewController {
    /// Used to handle all logics related to Firebase Auth.
    private let authorizer = Authorizer()
    /// A flag to indicate whether this user is a new user (who has just signed up).
    var isNewUser = false

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Hides the navigation bar.
        navigationController?.setNavigationBarHidden(true, animated: animated)

        // Navigates to the main tab bar view directly if user has logged in.
        if authorizer.didLogin {
            loadMainTabBarView()
        }
    }

    /// Handles the action when the login button is pressed.
    /// - Parameter sender: The button being pressed.
    @IBAction func loginButtonPressed(_ sender: MenuButton) {
        if let authUI = FUIAuth.defaultAuthUI() {
            // By default, we will consider it as an old user.
            isNewUser = false

            authUI.delegate = self
            present(authUI.authViewController(), animated: true)
        }
    }

    /// Loads the main tab bar view by pushing it into the stack of navigation controller.
    private func loadMainTabBarView() {
        let id = Constants.mainTabBarId
        guard let controller = storyboard?.instantiateViewController(withIdentifier: id) else {
            return
        }
        navigationController?.pushViewController(controller, animated: true)
    }
}

/**
 Extension for `LoginViewController` to act as the delegate for `FirebaseAuthUI`.
 */
extension LoginViewController: FUIAuthDelegate {
    func passwordSignUpViewController(forAuthUI authUI: FUIAuth, email: String) -> FUIPasswordSignUpViewController {
        let controller = PasswordSignUpController(authUI: authUI, email: email)
        controller.mainStoryboard = storyboard
        controller.parentController = self
        return controller
    }

    /// Sends a verification email when a new user has just successfully signed up.
    /// - Parameters:
    ///    - authUI: The authorization UI assets.
    ///    - authDataResult: The result indicating the authorization.
    ///    - error: Indicates whether any error happens.
    func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) {
        if isNewUser {
            authorizer.verifyEmail()
        }
    }
}
