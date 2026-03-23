//
//  Food.swift
//  Food
//
//  Created by Janzen Houchen-Wilder on 2/2/26.
//

import Foundation

struct currentFood: Identifiable, Decodable {
    let id: String
    let name: String
    let calories: Int
    let date: Date
}

struct Food : Decodable, Identifiable {
    var brand_name: String?
//    var food_description: String
    var food_id: String
    var food_name: String
    var food_type: String
    var food_url: String
    var food_description: FoodDescription

    var id: String { food_id }
}

struct Foods : Decodable {
    var food: [Food]
    var max_results: String
    var page_number: String
    var total_results: String
}

struct FoodSearchResponse: Decodable {
    var foods: Foods
}

struct FoodDescription: Decodable {
    var serving_size: String
    var calories: String
    var fat: String
    var carbs: String
    var protein: String
}
