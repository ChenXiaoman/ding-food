//
//  PasswordSignUpController.swift
//  ding-stall
//
//  Created by Jiang Chunhui on 03/04/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import FirebaseAuthUI

class PasswordSignUpController: FUIPasswordSignUpViewController {
    
    weak var parentController: LoginViewController?

    /// Override this initializer to avoid conflict in nib name. This is a known bug in
    /// `FirebaseAuthUI` library. Also, this is the only possible workaround currently,
    /// as pointed by the maintainers of the library.
    override init(nibName: String?, bundle: Bundle?, authUI: FUIAuth, email: String?) {
        super.init(nibName: "FUIPasswordSignUpViewController", bundle: bundle, authUI: authUI, email: email)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func signUp(withEmail email: String, andPassword password: String, andUsername username: String) {
        super.signUp(withEmail: email, andPassword: password, andUsername: username)
        parentController?.isNewUser = true
    }
}
