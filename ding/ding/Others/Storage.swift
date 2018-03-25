//
//  Storage.swift
//  ding-stall
//
//  Created by Yunpeng Niu on 18/03/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import FirebaseDatabase

/**
 This class acts as an abstraction layer between the server and client. It
 provides basic functionalities regarding data transaction with the server
 database.

 - Author: Group 3 @ CS3217
 - Date: March 2018
 */
class Storage {
    /// A reference to the Firebase realtime database, as access point to the server.
    private static let ref = Database.database().reference()

    /// Observes the value at a certain path. The handler will be notified each time the data
    /// at the specified path (and its child nodes) change.
    /// - Parameters:
    ///    - path: The path to the observed data.
    ///    - handler: The handler being called whenever the data at the specified path changes.
    func observeValue(of path: String, onChange handler: @escaping (DataSnapshot) -> Void) {
        Storage.ref.child(path).observe(.value, with: handler)
    }

    /// Stores a certain `FirebaseObject` at a specified path. The node (and its child nodes)
    /// originally at that path will be cleared. For instance, to store a certain blog post, you
    /// may want to write `setChildNode(of: "/posts", to: myBlogObj)`.
    /// - Parameters:
    ///    - path: The path to the observed data. The path should be a string with a "/" prefix
    ///            but without a "/" suffix, such as "/posts".
    ///    - object: The `FirebaseObject` being stored.
    func setChildNode<T: FirebaseObject>(of path: String, to object: T) {
        let newPath = path + "/\(object.id)"
        Storage.ref.child(newPath).setValue(object.serialized)
    }
}
