//
//  Review.swift
//  DingPod
//
//  Created by Jiang Chunhui on 17/03/18.
//  Copyright © 2018年 JCH. All rights reserved.
//

public struct Review {
    var rating: Rating
    var reviewText: String
}

public enum Rating: Int {
    case excellent = 5
    case good = 4
    case average = 3
    case fair = 2
    case poor = 1
    case unjudged = 0
}
