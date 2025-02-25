//
//  DatabaseRef.swift
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
public class DatabaseRef {
    /// A reference to the Firebase realtime database, as access point to the server.
    private static let ref = Database.database().reference()
    /// The Firebase path to check internet connection.
    public static let checkConnectionPath = ".info/connected"
    /// A reference to check whether internet is connected.
    public static let connectedRef = Database.database().reference(withPath: DatabaseRef.checkConnectionPath)

    /// Observes the value at a certain path. The handler will be notified each time the data
    /// at the specified path (and its child nodes) change.
    /// - Parameters:
    ///    - path: The path to the observed data.
    ///    - handler: The handler being called whenever the data at the specified path changes.
    public static func observeValue(of path: String, onChange handler: @escaping (DataSnapshot) -> Void) {
        ref.child(path).observe(.value, with: handler)
    }

    /// Observes the value at a certain path once. This means the handler will only be notified
    /// once, after which the required data is loaded.
    /// - Parameters:
    ///    - path: The path to the observed-once data.
    ///    - handler: The handler being called after the required data is loaded.
    public static func observeValueOnce(of path: String, onChange handler: @escaping (DataSnapshot) -> Void) {
        ref.child(path).observeSingleEvent(of: .value, with: handler)
    }

    /// Stops all observers at a certain path. However, the observers for its child nodes will
    /// not be removed.
    /// - Parameter path: The path to the observed data.
    public static func stopObservers(of path: String) {
        ref.child(path).removeAllObservers()
    }

    /// Stores a certain `DatabaseObject` at a specified path. The node (and its child nodes)
    /// originally at that path will be cleared. For instance, to store a certain blog post, you
    /// may want to write `setChildNode(of: "/posts", to: myBlogObj)`.
    /// - Parameters:
    ///    - path: The path to the observed data. The path should be a string with a "/" prefix
    ///            but without a "/" suffix, such as "/posts".
    ///    - object: The `DatabaseObject` being stored.
    public static func setChildNode<T: DatabaseObject>(of path: String, to object: T) {
        let newPath = path + "/\(object.id)"
        ref.child(newPath).setValue(object.serialized)
    }

    /// Stores a certain `DatabaseObject` at an array of specified paths. You should call this
    /// function once instead of calling `setChildNode` iteratively to achieve **atomicity**.
    /// - Parameters:
    ///    - paths: An array of paths to store at. They will not be prepended with the `path`
    /// attribute of the `DatabaseObject`.
    ///    - object: The `DatabaseObject` being stored.
    public static func setChildNodes<T: DatabaseObject>(of paths: [String], to object: T) {
        let data = object.serialized
        var updated: [String: [String: Any]] = [:]
        paths.forEach { updated[$0] = data }
        ref.updateChildValues(updated)
    }

    /// Delete the node and all its child nodes in database by given path.
    /// - Parameter: path: the path of the deleted node
    public static func deleteChildNode(of path: String) {
        ref.child(path).setValue(nil)
    }

    /// Creates a reference to the child node at the given path.
    /// - Parameter path: The path to the child node.
    /// - Returns: The reference to the child node.
    public static func getNodeRef(of path: String) -> DatabaseReference {
        return ref.child(path)
    }

    /// Creates a unique key used to generate a child at a node specified by the given path.
    /// - Parameter path: The path to the parent node.
    /// - Returns: a string representing the unique key.
    public static func getAutoId(of path: String) -> String {
        return ref.child(path).childByAutoId().key
    }
}
