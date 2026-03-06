//
//  Recipe.swift
//  Food
//
//  Created by Janzen Houchen-Wilder on 3/5/26.
//

import Foundation

struct RecipesSearchRequest: Encodable {
    let method: String

    var recipe_types: String?
    var recipe_types_matchall: Bool?
    var search_expression: String?
    var must_have_images: Bool?

    var calories_from: Int?
    var calories_to: Int?
    var carb_percentage_from: Int?
    var carb_percentage_to: Int?
    var protein_percentage_from: Int?
    var protein_percentage_to: Int?
    var fat_percentage_from: Int?
    var fat_percentage_to: Int?
    var prep_time_from: Int?
    var prep_time_to: Int?

    var page_number: Int?
    var max_results: Int?
    var sort_by: String?
    var format: String?
}

struct RecipesResponse: Decodable {
    let recipes: Recipes
}

struct Recipes: Decodable {
    let max_results: String
    let page_number: String
    let recipe: [Recipe]?
    let total_results: String
}

struct Recipe: Decodable, Identifiable {
    let recipe_id: String
    let recipe_name: String
    let recipe_description: String
    let recipe_image: String?
    let recipe_ingredients: RecipeIngredients
    let recipe_nutrition: RecipeNutrition
    let recipe_types: RecipeTypes

    var id: String { recipe_id }
}

struct RecipeIngredients: Decodable {
    let ingredient: [String]
}

struct RecipeNutrition: Decodable {
    let calories: String
    let carbohydrate: String
    let fat: String
    let protein: String
}

struct RecipeTypes: Decodable {
    let recipe_type: [String]
}
