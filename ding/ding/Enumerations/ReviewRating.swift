//
//  ReviewRating.swift
//  ding
//
//  Created by Jiang Chunhui on 18/03/18.
//  Copyright © 2018年 CS3217 Ding. All rights reserved.
//

public enum Rating: Int, Codable {
    case excellent = 5
    case good = 4
    case average = 3
    case fair = 2
    case poor = 1
    case unjudged = 0
}
