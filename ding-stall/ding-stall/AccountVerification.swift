//
//  AccountVerification.swift
//  ding-stall
//
//  Created by Calvin Tantio on 14/4/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//


// Makes sure that user sign in using stall account and not customer account
guard Account.isCorrectAccount else { // NOTE: in loadTabBarView()
    handleWrongAccountType()
    return
}


/// Automatically signs user out when user signs in using customer account.
private func handleWrongAccountType() {
    DialogHelpers.showAlertMessage(in: self, title: "Wrong Account Type",
                                   message: "The account is not registered as a stall account." +
    "Try to sign in using another account") {
        self.authorizer.signOut()
        self.loadLoginView(true)
    }

    return
}

