//
//  StorageRef.swift
//  ding
//
//  Created by Yunpeng Niu on 28/03/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import FirebaseStorage

/**
 This class acts as an abstraction layer between the server and client. It
 provides basic functionalities regarding file upload/download with the server
 cloud storage.

 - Author: Group 3 @ CS3217
 - Date: March 2018
 */
public class StorageRef {
    /// A reference to the Firebase cloud storage, as access point to the server.
    private static let ref = Storage.storage().reference()

    /// Uploads in-memory data to a specified path on the server.
    /// - Parameters:
    ///    - data: The data to be uploaded.
    ///    - path: The path at which the data will be stored. The path should usually
    /// end with the full name of the file corresonding to the data.
    public static func upload(_ data: Data, at path: String) {
        ref.child(path).putData(data)
    }

    /// Uploads the file at specified URL to a specified path on the server.
    /// - Parameters:
    ///    - url: The URL to the desired file.
    ///    - path: The path at which the file will be stored. The path should usually
    /// end with the full name of the file.
    public static func upload(_ url: URL, at path: String) {
        ref.child(path).putFile(from: url)
    }

    /// Downloads the file at specified path from cloud storage to in-memory data.
    ///
    /// Notice: To avoid memory overflow, a maximum size to download must be specified.
    /// If the download exceeds this size the task will be cancelled and an error will
    /// be returned.
    /// - Parameters:
    ///    - path: The path at which the file was stored.
    ///    - maxSize: The maximum size in bytes to download.
    ///    - handler:
    public static func download(from path: String, maxSize: Int64, onComplete handler: @escaping (Data?, Error?) -> Void) {
        ref.child(path).getData(maxSize: maxSize, completion: handler)
    }

    /// Creates a reference to the child node at the given path.
    /// - Parameter path: The path to the child node.
    /// - Returns: The reference to the child node.
    public static func getNodeRef(of path: String) -> StorageReference {
        return ref.child(path)
    }

    /// Delete the file at the given path.
    /// - Parameter path: the path of the file to be deleted.
    public static func delete(at path: String) {
        ref.child(path).delete()
    }
}
