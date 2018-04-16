//
//  Review.swift
//  DingPod
//
//  Created by Jiang Chunhui on 17/03/18.
//  Copyright © 2018 JCH. All rights reserved.
//

/**
 `Review` represents a user's review for a stall. After each order is completed (an
 `Order` becomes a `OrderHistory`), the user will be prompted to provide a `Review`
 for the stall where he/she purchases the food from.

 - Author: Group 3 @ CS3217
 - Date: March 2018
 */
public struct Review: DatabaseObject {
    public static let path = "/review"
    public static let stallIdPath = "/stallId"
    
    public let id: String
    public let stallId: String
    public var rating: Rating
    public var reviewText: String?
}

/**
 `Rating` is an enum representing a rating from 1 to 5. A higher raw value
 indicates a more positive response.
 */
public enum Rating: Int, Codable {
    case excellent = 5
    case good = 4
    case average = 3
    case fair = 2
    case poor = 1
    
    /// An array of ratings,
    /// from poor to excellent.
    static let allRatings = [Rating.poor, Rating.fair, Rating.average, Rating.good, Rating.excellent]
    
    /// An array of string representation of ratings,
    /// from poor to excellent.
    static let allStringsValueOfRatings = ["Bad", "Not good", "OK", "Good", "Excellent"]

}

// MARK: CustomStringConvertible
extension Rating: CustomStringConvertible {
    public var description: String {
        // Minus by 1 here because the lowest raw value starts from 1.
        return Rating.allStringsValueOfRatings[rawValue - 1]
    }
}
