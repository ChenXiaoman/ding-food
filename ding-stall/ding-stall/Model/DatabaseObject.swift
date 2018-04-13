//
//  DatabaseObject.swift
//  ding
//
//  Created by Yunpeng Niu on 27/03/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import FirebaseDatabase

/**
 Each object that would be stored in Firebase database is a `DatabaseObject`. This protocol
 provides the basic capability, such as serialization.

 `DatabaseObject` conforms to `Codable` protocol. This is because we can think of Firebase
 database as a cloud-hosted JSON tree. Thus, it would be nice if we could use `Codable` types,
 which can be easily converted from/to JSON objects.

 `DatabaseObject` conforms to `Hashable` protocol. This is because each JSON node in Firebase
 database has a key, which should be unique. Thus, a certain `DatabaseObject` is identifiable
 by its key value, the `id` attribute.

 - Author: Group 3 @ CS3217
 - Date: March 2018
 */
public protocol DatabaseObject: Codable, Hashable {
    /// The identifier of a `DatabaseObject`, which must be unique among all homogenous
    /// objects. For instance, among all posts (which are stored at the path "/posts"
    /// in Firebase), their `id`s must all be unique.
    ///
    /// The underlying reason is that, a JSON object does not allow duplicate keys (since
    /// we can think of the Firebase database as a cloud-hosted JSON tree).
    var id: String { get }

    /// The path of a `DatabaseObject` type, at which all homogenous objects of this type
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
 Extension for `DatabaseObject`, which provides some utility methods ready for use.
 */
extension DatabaseObject {
    /// The hash value of a `DatabaseObject`.
    public var hashValue: Int {
        return id.hashValue
    }

    /// Two `DatabaseObject`s are equal as long as their identifiers are equal.
    /// - Parameters:
    ///    - lhs: The first object to compare.
    ///    - rhs: The second object to compare.
    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.id == rhs.id
    }

    /// Gets a unique `id` for this `DatabaseObject`. This property could be useful
    /// when you create a new object locally.
    public static var getAutoId: String {
        return DatabaseRef.getAutoId(of: Self.path)
    }

    /// Converts a given `DatabaseObject` into a dictionary format so that it can be
    /// directly added to the database as a new child node. It will simply return an
    /// empty dictionary if the conversion fails.
    ///
    /// Notice: The id of the `DatabaseObject` will not be serialized because it ought
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
    public static func deserialize(_ dict: [String: Any]) -> Self? {
        guard let data = try? JSONSerialization.data(withJSONObject: dict, options: .sortedKeys),
            let obj = try? JSONDecoder().decode(Self.self, from: data) else {
                return nil
        }
        return obj
    }

    /// Converts a given `DataSnapshot` to an array of a certain `Codable` object
    /// It will return nil if the conversion fails
    /// - Parameter dict: the dictionary to decode.
    /// - Returns: An array of object converted if conversion is successful; nil otherwise.
    public static func deserializeArray(_ snapshot: DataSnapshot) -> [Self]? {
        guard let dict = snapshot.value as? [String: Any] else {
            return nil
        }
        var objectArray = [Self]()
        dict.forEach { key, value in
            guard var objectDict = value as? [String: Any] else {
                return
            }
            objectDict["id"] = key
            guard let object = Self.deserialize(objectDict) else {
                return
            }
            objectArray.append(object)
        }
        return objectArray
    }

    /// This function will convert the a dictionary in (id, value) format to a dictionary of
    /// dictionaries in (id, value + id) format to prepare for subsequent deserialization.
    /// - Parameter dict: the nested dictionary of (id, value) pair.
    /// - Returns: a dictionary (id, value) whose value contains the id.
    public static func prepareNestedDeserialize(_ dict: [String: Any]) -> [String: [String: Any]]? {
        var menuDict = [String: [String: Any]]()
        dict.forEach { key, value in
            guard let valueDict = value as? [String: Any] else {
                return
            }
            menuDict[key] = valueDict
            menuDict[key]?["id"] = key
        }
        return menuDict
    }

    /// Saves this `DatabaseObject` to the Firebase database.
    ///
    /// Notice: It is possible to override the `CodingKeys` attribute if you do not want
    /// to save all attributes to the database or want to customize the key name for
    /// certain attributes.
    public func save() {
        DatabaseRef.setChildNode(of: Self.path, to: self)
    }

    /// Delete this `DatabaseObject` from the database
    public func delete() {
        DatabaseRef.deleteChildNode(of: Self.path + "/\(id)")
    }
}
