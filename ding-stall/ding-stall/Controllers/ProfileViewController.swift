//
//  ProfileViewController.swift
//  ding-stall
//
//  Created by Jiang Chunhui on 24/03/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import UIKit

/**
 The controller for the profile view. The profile view is used to initialise
 or edit stall profile
 */
class ProfileViewController: UIViewController, ProfileViewDelegate {

    var profileView: ProfileView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
    }

    private func setView() {
        profileView = ProfileView(frame: view.frame)
        profileView.delegate = self
        view.addSubview(profileView)
    }

    func confirmStallProfile() {
        let name = getValueFromTextField(profileView.nameTextField)

        guard textFieldInputConstraint(text: name) else {
            return
        }

        let location = getValueFromTextField(profileView.locationTextField)
        let openingHour = getValueFromTextField(profileView.openingHourTextField)
        let description = getValueFromTextField(profileView.descriptionTextField)
        let filters = getValueFromTextField(profileView.filterTextField)

        // TODO: Filters should not be nil
<<<<<<< HEAD
        let newStall = StallDetails(id: StallDetails.getAutoId, name: name,
=======
        let newStall = Stall(id: Stall.getAutoId,
>>>>>>> master
                             location: location, openingHour: openingHour,
                             description: description, menu: nil, filters: nil)

        newStall.save()
    }

    private func getValueFromTextField(_ textField: UITextField) -> String {
        return textField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
    }

    private func textFieldInputConstraint(text: String) -> Bool {
        // TODO: Define Constraints
        return text != ""
    }
}
