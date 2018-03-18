//
//  Protocols.swift
//  DingPod
//
//  Created by Jiang Chunhui on 17/03/18.
//  Copyright © 2018年 JCH. All rights reserved.
//

public protocol StorageDelegate: class {
    func save()
}

public protocol FirebaseObject: Codable, Hashable {
    var id: String { get }
}
