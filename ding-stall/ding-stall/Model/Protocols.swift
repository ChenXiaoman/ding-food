//
//  Protocols.swift
//  DingPod
//
//  Created by Jiang Chunhui on 17/03/18.
//  Copyright © 2018 JCH. All rights reserved.
//

import Foundation
import Firebase

/// Represents an object stored in Firebase database
public protocol FirebaseObject: Codable, Hashable {
    var id: String { get }

    static var path: String { get }
}

extension FirebaseObject {
    public var hashValue: Int {
        return id.hashValue
    }

    /// Converts a given `FirebaseObject` into a dictionary format so that it can be
    /// directly added to the database as a new child node. It will simply return an
    /// empty dictionary if the conversion fails.
    ///
    /// Notice: The id of the `FirebaseObject` will not be serialized because it ought
    /// to be used as the key rather than the value of the child node.
    public var serialized: [String: Any] {
        guard
            let data = try? JSONEncoder().encode(self),
            let obj = try? JSONSerialization.jsonObject(with: data, options: .allowFragments),
            var dict = obj as? [String: Any] else {
            return [:]
        }
        dict["id"] = nil
        return dict
    }

    /// Converts a given `DataSnapshot` back to its runtime object representation. It will
    /// simply return `nil` if the conversion fails.
    ///
    /// Notice: The snapshot should be the one containing only this object. For example, to
    /// convert a post in blog system, the snapshot should be at path "/posts/{post_id}". You
    /// then can call `Post.deserialize(snapshot)`.
    /// - Parameter snapshot: The snapshot containing the required object.
    /// - Returns: The object converted if conversion is successful; nil otherwise.
    public static func deserialize(_ snapshot: DataSnapshot) -> Self? {
        guard var dict = snapshot.value as? [String: Any] else {
            return nil
        }
        dict["id"] = snapshot.key
        guard let data = try? JSONSerialization.data(withJSONObject: dict, options: .sortedKeys),
            let obj = try? JSONDecoder().decode(Self.self, from: data) else {
                return nil
        }
        return obj
    }

    /// Generate an id for a fireBase object
    public static func getAutoId() -> String {
        return Storage.getAutoId(of: path)
    }

    public func save() {
        let storage = Storage()
        storage.setChildNode(of: Self.path, to: self)
    }

    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.id == rhs.id
    }
}
