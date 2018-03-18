//
//  OrderStatus.swift
//  ding
//
//  Created by Jiang Chunhui on 18/03/18.
//  Copyright © 2018年 CS3217 Ding. All rights reserved.
//

public enum OrderStatus: Int, Codable {
    case preparing = 1
    case ready = 2
    case collected = 3
}
