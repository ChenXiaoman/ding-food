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

    /// Converts a given `FirebaseObject` into dictionary format so that it can be
    /// directly added to the database as a new child node. It will simply return
    /// an empty dictionary if the conversion fails.
    public var dictionary: [String: Any] {
        guard let data = try? JSONEncoder().encode(self),
            let obj = try? JSONSerialization.jsonObject(with: data, options: .allowFragments),
            let dict = obj as? [String: Any] else {
            return [:]
        }
        return dict
    }

    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.id == rhs.id
    }
}
