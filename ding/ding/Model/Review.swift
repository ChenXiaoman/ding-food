//
//  Review.swift
//  DingPod
//
//  Created by Jiang Chunhui on 17/03/18.
//  Copyright © 2018年 JCH. All rights reserved.
//

public struct Review: FirebaseObject {
    public var id: String
    public var rating: Rating
    public var reviewText: String

    public var hashValue: Int {
        return id.hashValue
    }

    public static func == (lhs: Review, rhs: Review) -> Bool {
        return lhs.id == rhs.id
            && lhs.rating == rhs.rating
            && lhs.reviewText == rhs.reviewText
    }
}
