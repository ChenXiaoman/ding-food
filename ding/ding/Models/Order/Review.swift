//
//  Review.swift
//  DingPod
//
//  Created by Jiang Chunhui on 17/03/18.
//  Copyright © 2018 JCH. All rights reserved.
//

/**
 Represents a user's review for a stall.
 After each order is completed, user will be prompted to provide
 a review for the stall where he/she purchase the food from.
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
 Represent the rating while reviewing
 A larger rawValue means a better rating
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

/// The string representation of the rating
extension Rating: CustomStringConvertible {
    public var description: String {
        // Minus 1 because the lowest raw value starts from 1.
        return Rating.allStringsValueOfRatings[rawValue - 1]
    }
    
    
}
