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

    /// Checks whether the application has been authorized to push notifications
    /// and request authorization if not. Shows an alert message if the user does
    /// not grant the permission.
    static func checkPermission(in controller: UIViewController) {
        checkPermission { isGranted, _ in
            if !isGranted {
                DialogHelpers.showAlertMessage(in: controller, title: alertTitle, message: alertMessage)
            }
        }
    }

    /// Schedules a local notification to the user after a certain time interval.
    /// - Parameters:
    ///    - time: The time after which the notification is pushed, whose value must
    /// be strictly larger than 0. It has a default value of 0.1s
    ///    - id: The identifier of the created notification request.
    ///    - title: The title of the local notification.
    ///    - subtitle: The subtitle of the local notification.
    ///    - body: The body of the local notification.
    static func notify(after time: TimeInterval = 0.1, id: String, title: String, subtitle: String, body: String) {
        // Sets up the content of the notification.
        let content = UNMutableNotificationContent()
        content.title = title
        content.subtitle = subtitle
        content.body = body
        if isVolumeOn() {
            content.sound = UNNotificationSound.default()
        }

        // Creates the notification trigger and reqeust.
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: time, repeats: false)
        let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
        center.add(request, withCompletionHandler: nil)
    }

    /// Unschedules all pending local notification requests.
    static func clearPendingRequests() {
        center.removeAllPendingNotificationRequests()
    }

    /// Checks whether the user has set the volume on/off.
    /// - Returns: true if the user set the volume on; true as well if the
    /// user neve sets the volume before.
    private static func isVolumeOn() -> Bool {
        guard UserDefaults.standard.object(forKey: "volume") != nil else {
            return true
        }
        return UserDefaults.standard.bool(forKey: "volume")
    }
}
