//
//  Authorizer.swift
//  ding-stall
//
//  Created by Yunpeng Niu on 18/03/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import FirebaseAuth

/**
 This class acts as an abstraction layer between the server and client. It
 provides basic functionalities regarding authentication & authorization (
 user login, sign out, etc).

 - Author: Group 3 @ CS3217
 - Date: March 2018
 */
class Authorizer {
    /// A reference to the Firebase authentication, as access point to the server.
    private static let auth = Auth.auth()

    /// Sends a verification email to the current user's email address. This method will
    /// simple do nothing if there is no user signed in.
    func verifyEmail(onComplete: @escaping SendEmailVerificationCallback) {
        Authorizer.auth.currentUser?.sendEmailVerification(completion: onComplete)
    }

    /// Signs out the current user. This method will simply do nothing if any error
    /// is thrown when trying to connect to the database and sign out the user.
    func signOut() {
        try? Authorizer.auth.signOut()
    }

    /// Returns the username of the current user if it has signed in, an empty
    /// string otherwise.
    var userName: String {
        return Authorizer.auth.currentUser?.displayName ?? ""
    }

    /// Returns whether there is a user that has signed in currently.
    var didLogin: Bool {
        return Authorizer.auth.currentUser != nil
    }

    /// Returns whether the current user's email address has been verified; always
    /// false if no user has signed in.
    var isEmailVerified: Bool {
        return Authorizer.auth.currentUser?.isEmailVerified ?? false
    }
}
