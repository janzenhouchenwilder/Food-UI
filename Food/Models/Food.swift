//
//  Food.swift
//  Food
//
//  Created by Janzen Houchen-Wilder on 2/2/26.
//

import Foundation

struct Food : Decodable, Identifiable {
    var brand_name: String?
    var food_description: String
    var food_id: String
    var food_name: String
    var food_type: String
    var food_url: String

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
