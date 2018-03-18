//
//  Protocols.swift
//  DingPod
//
//  Created by Jiang Chunhui on 17/03/18.
//  Copyright © 2018 JCH. All rights reserved.
//

import Foundation

public protocol StorageDelegate: class {
    func save()
}

/// Represents an object stored in Firebase database
public protocol FirebaseObject: Codable, Hashable {
    var id: String { get }
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

    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.id == rhs.id
    }
}
