//
//  NotificationController.swift
//  ding
//
//  Created by Yunpeng Niu on 13/04/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import UIKit
import UserNotifications

/**
 A dedicated controller to manage all local notifications sent by the application,
 which uses the `UserNotifications` module under-the-hood.

 - Author: Group 3 @ CS3217
 - Date: April 2018
 */
class NotificationController {
    /// A shared instance to access the system-level notification center.
    private static let center = UNUserNotificationCenter.current()
    /// The typical options of permission we request.
    private static let options: UNAuthorizationOptions = [.alert, .badge, .sound]
    /// The title for alert box.
    private static let alertTitle = "Permission Not Granted"
    /// The message in the alert box.
    private static let alertMessage = "Permission for pushing notification is not granted. This may result "
        + "in malfunction. Please go to the system settings to change it."

    /// Checks whether the application has been authorized to push notifications
    /// and request authorization if not.
    /// - Parameter handler: The handler after the permission request with a parameter
    /// indicating whether authorization was granted.
    static func checkPermission(onRequest handler: @escaping (Bool, Error?) -> Void) {
        center.getNotificationSettings { settings in
            if settings.authorizationStatus != .authorized {
                center.requestAuthorization(options: options, completionHandler: handler)
            }
        }
    }

    static func checkPermission(in controller: UIViewController) {
        checkPermission { isGranted, _ in
            if !isGranted {
                DialogHelpers.showAlertMessage(in: controller, title: alertTitle, message: alertMessage)
            }
        }
    }
}
