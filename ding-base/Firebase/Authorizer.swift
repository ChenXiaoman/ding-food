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
public class Authorizer {
    /// A reference to the Firebase authentication, as access point to the server.
    private static let auth = Auth.auth()

    /// A placeholder `init`.
    public init() {

    }

    /// Sends a verification email to the current user's email address. This method will
    /// simple do nothing if there is no user signed in.
    /// - Parameter onComplete: The handler to be called after the verification email has
    /// been sent.
    public func verifyEmail(onComplete: @escaping SendEmailVerificationCallback) {
        Authorizer.auth.currentUser?.sendEmailVerification(completion: onComplete)
    }

    /// Sends a verification email to the current user's email address. This method will
    /// simple do nothing if there is no user signed in.
    public func verifyEmail() {
        Authorizer.auth.currentUser?.sendEmailVerification(completion: nil)
    }

    /// Signs out the current user. This method will simply do nothing if any error
    /// is thrown when trying to connect to the database and sign out the user.
    public func signOut() {
        try? Authorizer.auth.signOut()
    }

    /// Returns the username of the current user if it has signed in, an empty
    /// string otherwise.
    public var userName: String {
        return Authorizer.auth.currentUser?.displayName ?? ""
    }

    /// Returns the user id of the current user if it has signed in, an empty
    /// string otherwise.
    public var userId: String {
        return Authorizer.auth.currentUser?.uid ?? ""
    }

    /// Returns the email address of the current user if it has signed in, an empty
    /// string otherwise.
    public var email: String {
        return Authorizer.auth.currentUser?.email ?? ""
    }

    /// Returns whether there is a user that has signed in currently.
    public var didLogin: Bool {
        return Authorizer.auth.currentUser != nil
    }

    /// Returns whether the current user's email address has been verified; always
    /// false if no user has signed in.
    public var isEmailVerified: Bool {
        return Authorizer.auth.currentUser?.isEmailVerified ?? false
    }

    /// Returns whether the user has signed in and the email has been verified.
    public var didLoginAndVerified: Bool {
        return didLogin && isEmailVerified
    }
}
