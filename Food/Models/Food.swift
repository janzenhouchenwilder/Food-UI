//
//  Food.swift
//  Food
//
//  Created by Janzen Houchen-Wilder on 2/2/26.
//

import Foundation

struct currentFood: Identifiable, Decodable {
    let id: String
    let user_id: String
    let food_name: String
    let calories: Int
    let serving_amount: Int
    let serving_unit: String
    let protein: Int
    let fat: Int
    let carbs: Int
    let fatsecret_food_id: Int64
    let created_at: String
    let eaten_at: String
    let total_servings: Double
    let food_url: String?
    let food_type: String?
    let food_brand: String?
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

//Search by id

struct FoodByIdResponse: Decodable {
    let food: FoodById
}

struct FoodById: Decodable {
    let food_id: String
    let food_name: String
    let food_type: String
    let food_url: String
    let servings: ServingsResponse
}

struct ServingsResponse: Decodable {
    let serving: [ServingDetail]
}

struct ServingDetail: Decodable, Identifiable {
    let calcium: String
    let calories: String
    let carbohydrate: String
    let cholesterol: String
    let fat: String
    let fiber: String
    let iron: String
    let measurement_description: String
    let metric_serving_amount: String
    let metric_serving_unit: String
    let monounsaturated_fat: String
    let number_of_units: String
    let polyunsaturated_fat: String
    let potassium: String
    let protein: String
    let saturated_fat: String
    let serving_description: String
    let serving_id: String
    let serving_url: String
    let sodium: String
    let sugar: String
    let vitamin_a: String
    let vitamin_c: String

    var id: String { serving_id }
}
