//
//  Protocols.swift
//  DingPod
//
//  Created by Jiang Chunhui on 17/03/18.
//  Copyright © 2018 JCH. All rights reserved.
//

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

    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.id == rhs.id
    }
}
