//
//  FoodType.swift
//  ding
//
//  Created by Calvin Tantio on 17/3/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

/**
 Enumeration of food type.
 The raw value is the text that is displayed on the picker.
 */
public enum FoodType: String, Codable {
    case main = "Main"
    case soup = "Soup"
    case dessert = "Dessert"
    case drink = "Drink"
}
