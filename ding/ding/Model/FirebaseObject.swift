//
//  FirebaseObject.swift
//  ding
//
//  Created by Yunpeng Niu on 27/03/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import FirebaseDatabase

/**
 Each object that would be stored in Firebase database is a `FirebaseObject`. This protocol
 provides the basic capability, such as serialization.

 `FirebaseObject` conforms to `Codable` protocol. This is because we can think of Firebase
 database as a cloud-hosted JSON tree. Thus, it would be nice if we could use `Codable` types,
 which can be easily converted from/to JSON objects.

 `FirebaseObject` conforms to `Hashable` protocol. This is because each JSON node in Firebase
 database has a key, which should be unique. Thus, a certain `FirebaseObject` is identifiable
 by its key value, the `id` attribute.

 - Author: Group 3 @ CS3217
 - Date: March 2018
 */
public protocol FirebaseObject: Codable, Hashable {
    /// The identifier of a `FirebaseObject`, which must be unique among all homogenous
    /// objects. For instance, among all posts (which are stored at the path "/posts"
    /// in Firebase), their `id`s must all be unique.
    ///
    /// The underlying reason is that, a JSON object does not allow duplicate keys (since
    /// we can think of the Firebase database as a cloud-hosted JSON tree).
    var id: String { get }

    /// The path of a `FirebaseObject` type, at which all homogenous objects of this type
    /// would be stored under in Firebase.
    ///
    /// For instance, if we want to create blog systems, the path for `Post` type should
    /// be "/posts". Notice that the path should be a string with a "/" prefix but without
    /// a "/" suffix.
    ///
    /// We suggest the value of `path` should be a descriptive English word, usually in its
    /// plural form.
    static var path: String { get }
}

/**
 Extension for `FirebaseObject`, which provides some utility methods ready for use.
 */
extension FirebaseObject {
    /// The hash value of a `FirebaseObject`.
    public var hashValue: Int {
        return id.hashValue
    }

    /// Two `FirebaseObject`s are equal as long as their identifiers are equal.
    /// - Parameters:
    ///    - lhs: The first object to compare.
    ///    - rhs: The second object to compare.
    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.id == rhs.id
    }

    /// Gets a unique `id` for this `FirebaseObject`. This property could be useful
    /// when you create a new object locally.
    public static var getAutoId: String {
        return DatabaseRef.getAutoId(of: Self.path)
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
        return deserialize(dict)
    }

    /// Converts a given dictionary into a `Codable` object. It will simply return `nil` if the
    /// conversion fails.
    /// - Parameter dict: the dictionary to decode.
    /// - Returns: The object converted if conversion is successful; nil otherwise.
    static func deserialize(_ dict: [String: Any]) -> Self? {
        guard let data = try? JSONSerialization.data(withJSONObject: dict, options: .sortedKeys),
            let obj = try? JSONDecoder().decode(Self.self, from: data) else {
                return nil
        }
        return obj
    }

    /// This method will convert the a dictionary in (id, value) format to a dictionary of
    /// dictionaries in (id, value + id) format to prepare for subsequent deserialization.
    /// - Parameter dict: the nested dictionary of (id, value) pair.
    /// - Returns: a dictionary (id, value) whose value contains the id.
    static func prepareNestedDeserialize(_ dict: [String: Any]) -> [String: [String: Any]]? {
        var nestedDict = [String: [String: Any]]()
        dict.forEach { key, value in
            guard let valueDict = value as? [String: Any] else {
                return
            }
            nestedDict[key] = valueDict
            nestedDict[key]?["id"] = key
        }
        return nestedDict
    }

    /// Saves this `FirebaseObject` to the Firebase database.
    ///
    /// Notice: It is possible to override the `CodingKeys` attribute if you do not want
    /// to save all attributes to the database or want to customize the key name for
    /// certain attributes.
    public func save() {
        DatabaseRef.setChildNode(of: Self.path, to: self)
    }
}
