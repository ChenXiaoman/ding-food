//
//  PasswordSignUpController.swift
//  ding
//
//  Created by Yunpeng Niu on 24/03/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import FirebaseAuthUI

/**
 A customized `FUIPasswordSignUpViewController` so that the user's NUSNET account is verified
 before they can sign up.

 - Author: Group 3 @ CS3217
 - Date: March 2018
 */
class PasswordSignUpController: FUIPasswordSignUpViewController {
    /// The reference to the primary main storyboard.
    weak var mainStoryboard: UIStoryboard?
    /// The reference to the `LoginViewController`.
    weak var parentController: LoginViewController?
    /// Indicates whether the NUSNET account has been verified.
    private var hasVerified = false

    /// Override this initializer to avoid conflict in nib name. This is a known bug in
    /// `FirebaseAuthUI` library. Also, this is the only possible workaround currently,
    /// as pointed by the maintainers of the library.
    override init(nibName: String?, bundle: Bundle?, authUI: FUIAuth, email: String?) {
        super.init(nibName: "FUIPasswordSignUpViewController", bundle: bundle, authUI: authUI, email: email)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Shows the navigation bar.
        navigationController?.setNavigationBarHidden(false, animated: animated)

        guard hasVerified else {
            loadVerifyNUS(animated)
            return
        }
    }

    /// Loads the `VerifyNUSControler` by pushing it into the stack of navigation controller.
    /// - Parameter animated: If true, the view is being added to the window using an animation.
    private func loadVerifyNUS(_ animated: Bool) {
        let id = Constants.verifyNUSControllerId
        guard let controller = mainStoryboard?.instantiateViewController(withIdentifier: id)
            as? VerifyNUSController else {
            return
        }
        controller.parentController = self
        navigationController?.pushViewController(controller, animated: animated)
    }

    /// Handles the logic after the user has entered the value for all the 3 fields and ready
    /// to send sign-up information to Firebase. In our case, the email and name fields are
    /// retrieved from IVLE API and cannot be modified.
    /// - Parameters:
    ///    - email: The NUS email address.
    ///    - password: The user's password (which could be different from NUSNET password).
    ///    - username: The real name of the user.
    override func signUp(withEmail email: String, andPassword password: String, andUsername username: String) {
        super.signUp(withEmail: email, andPassword: password, andUsername: username)
        parentController?.isNewUser = true
    }
}

extension PasswordSignUpController: PasswordSignUpControllerDelegate {
    func receiveCredentials(name: String, email: String) {
        hasVerified = true
        if let emailField = value(forKey: "_emailField") as? UITextField {
            emailField.text = email
            emailField.isUserInteractionEnabled = false
        }
        if let nameField = value(forKey: "_nameField") as? UITextField {
            nameField.text = name
            nameField.isUserInteractionEnabled = false
        }
    }
}

/**
 Acts as the delegate for `LoginViewController`.
 */
protocol PasswordSignUpControllerDelegate: AnyObject {
    /// Receives the credential of the user's NUSNET account from IVLE API.
    /// - Parameters:
    ///    - name: The real name of the user.
    ///    - email: The NUS email address of the user.
    func receiveCredentials(name: String, email: String)
}
