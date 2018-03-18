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
public struct Review: FirebaseObject {
    public let id: String
    public var rating: Rating
    public var reviewText: String
}
