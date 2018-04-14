//
//  ProfileViewController.swift
//  ding
//
//  Created by Yunpeng Niu on 12/04/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import Eureka

/**
 The controller for profile view.

 - Author: Group 3 @ CS3217
 - Date: April 2018
 */
class ProfileViewController: FormViewController {
    /// The profile of the current customer.
    var currentProfile: Customer?
    /// The avatar photo of the current customer.
    var avatarPhoto: UIImage?
    /// The `MeViewController` that is right before the current controller.
    var parentController: MeViewController?
    /// The tag for avatar row.
    private static let avatarTag = "avatar"

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Populates the form used to get settings input.
        form +++ Section("My Profile")
            <<< TextRow { row in
                row.title = "Email Address"
                row.value = authorizer.email
                row.disabled = true
            }
            <<< TextRow { row in
                row.title = "Name"
                row.value = authorizer.userName
                row.disabled = true
            }
            <<< ImageRow { row in
                row.tag = ProfileViewController.avatarTag
                row.title = "Upload avatar"
                row.value = avatarPhoto
            }
    }

    /// Updates the user profile when the submit button is pressed.
    /// - Parameter sender: The button being pressed.
    @IBAction func onSubmitPressed(_ sender: UIBarButtonItem) {
        guard let row = form.rowBy(tag: ProfileViewController.avatarTag) as? ImageRow,
            let newPhoto = row.value else {
            navigationController?.popViewController(animated: true)
            return
        }

        // Only performs actions when the photo is actually changed.
        if !newPhoto.isEqual(avatarPhoto) {
            // Deletes the original photo.
            StorageRef.delete(at: currentProfile?.avatarPath ?? "")

            // Uploads the new photo.
            let newPath = Customer.newPhotoPath
            guard let photoData = newPhoto.standardData else {
                DialogHelpers.showAlertMessage(in: self, title: "Error Occured",
                                               message: "Unable to upload the new photo")
                return
            }
            StorageRef.upload(photoData, at: newPath)

            // Updates the customer profile.
            currentProfile?.avatarPath = newPath
            currentProfile?.save()
            parentController?.currentProfile = currentProfile
            navigationController?.popViewController(animated: true)
        }
    }
}
