//
//  FoodLog.swift
//  Food
//
//  Created by Janzen Houchen-Wilder on 3/10/26.
//

import Foundation

struct FoodLog: Encodable {
    let user_id: String
    let food_name: String
    let calories: Int
    let carbs: Int
    let protein: Int
    let fat: Int
    let serving_size: String
    let eaten_at: Date
    let create_at: Date
}
