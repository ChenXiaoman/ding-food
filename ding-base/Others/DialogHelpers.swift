//
//  DialogHelpers.swift
//  ding
//
//  Created by Yunpeng Niu on 29/03/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import UIKit

/**
 Defines some helper methods for popup dialog boxes and interactions with the player.

 - Author: Group 3 @ CS3217
 - Date: March 2018
 */
public class DialogHelpers {
    /// Shows a message in an alert dialog box to the user. The user can click "OK"
    /// to dismiss this alert dialog box.
    /// - Parameters:
    ///    - viewController: The view controller used to present this alert dialog.
    ///    - title: The text shown as the title of the alert dialog.
    ///    - message: The text shown as the main body of the alert dialog.
    public static func showAlertMessage(in viewController: UIViewController, title: String, message: String) {
        let newAlert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        newAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        viewController.present(newAlert, animated: true, completion: nil)
    }

    /// Shows a message in an alert dialog box to the user. The user can click "OK"
    /// to dismiss this alert dialog box.
    /// - Parameters:
    ///    - viewController: The view controller used to present this alert dialog.
    ///    - title: The text shown as the title of the alert dialog.
    ///    - message: The text shown as the main body of the alert dialog.
    ///    - confirmHandler: The handler to be called when the user clicks "OK".
    public static func showAlertMessage(in viewController: UIViewController, title: String, message: String,
                                 onConfirm confirmHandler: @escaping () -> Void) {
        let newAlert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        newAlert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            confirmHandler()
        })
        viewController.present(newAlert, animated: true, completion: nil)
    }

    /// Prompts the user to enter an textual input. The user can click "Confirm" to
    /// submit the input or click "Cancel" to dismiss the box.
    ///
    /// _Special note_: Starting from Swift 3.0, escaping closures have to be declared
    /// explicitly due to API changes.
    /// - Parameters:
    ///    - viewController: The view controller used to present this prompt dialog.
    ///    - title: The text shown as the title of the prompt dialog.
    ///    - message: The text shown as the main body of the prompt dialog.
    ///    - placeholder: The placeholder shown in the text field.
    ///    - confirmHandler: The handler to be called when the input is entered.
    public static func promptInput(in viewController: UIViewController,
                            title: String, message: String, placeholder: String,
                            onConfirm confirmHandler: @escaping (String) -> Void) {
        let prompt = UIAlertController(title: title, message: message, preferredStyle: .alert)
        prompt.addTextField { $0.placeholder = placeholder }
        prompt.addAction(UIAlertAction(title: "Confirm",
                                       style: .default,
                                       handler: { _ in
                                        guard let input = prompt.textFields?[0].text else {
                                            fatalError("The textField cannot be reached.")
                                        }
                                        confirmHandler(input)
        }))
        prompt.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        viewController.present(prompt, animated: true, completion: nil)
    }

    /// Prompts the user to confirm something. The user can click "Confirm" to confirm the
    /// event or click "Cancel" to dismiss the box.
    ///
    /// _Special note_: Starting from Swift 3.0, escaping closures have to be declared
    /// explicitly due to API changes.
    /// - Parameters:
    ///    - viewController: The view controller used to present this confirm dialog.
    ///    - title: The text shown as the title of the confirm dialog.
    ///    - message: The text shown as the main body of the confirm dialog.
    ///    - cancelButtonText: The text shown in the cancel button.
    ///    - confirmHandler: The event to happen when confirmed.
    public static func promptConfirm(in viewController: UIViewController,
                              title: String, message: String, cancelButtonText: String,
                              onConfirm confirmHandler: @escaping () -> Void) {
        let prompt = UIAlertController(title: title, message: message, preferredStyle: .alert)
        prompt.addAction(UIAlertAction(title: "OK", style: .cancel) { _ in confirmHandler() })
        prompt.addAction(UIAlertAction(title: cancelButtonText, style: .default, handler: nil))
        viewController.present(prompt, animated: true, completion: nil)
    }
}
