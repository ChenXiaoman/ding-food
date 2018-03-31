//
//  OrderStatus.swift
//  ding
//
//  Created by Jiang Chunhui on 18/03/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

public enum OrderStatus: String, Codable {
    case rejected = "Rejected"
    case preparing = "Preparing"
    case ready = "Ready"
    case collected = "Collected"
}
