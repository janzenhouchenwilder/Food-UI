//
//  APIClient.swift
//  Food
//
//  Created by Janzen Houchen-Wilder on 1/6/26.
//

import Foundation

enum APIError: Error, LocalizedError {
    case badStatus(Int)
    case invalidURL
    case invalidResponse
    case decodingFailed
    case serverError(Int)
    case networkError

    var errorDescription: String? {
        switch self {
        case .badStatus(let code):
            return "Bad HTTP status: \(code)"
        case .invalidURL:
            return "Invalid request URL."
        case .invalidResponse:
            return "Invalid response from server."
        case .decodingFailed:
            return "Unable to get food data."
        case .serverError(let code):
            return "Server error (\(code))."
        case .networkError:
            return "Network connection error."
        }
    }
}

final class APIClient {
    
}

extension APIClient {
    func getFoods(food: String) async throws -> [Food] {
        let encoded = food.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? food
        guard let url = URL(string: "http://127.0.0.1:5000/food/\(encoded)") else {
            throw APIError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        if let http = response as? HTTPURLResponse {
            print("HTTP status:", http.statusCode)
        }

        print("Raw JSON:", String(data: data, encoding: .utf8) ?? "<not utf8>")
        
        do {
            //let responseData = try JSONDecoder().decode(Foods.self, from: data)
            let decoded = try JSONDecoder().decode(FoodSearchResponse.self, from: data)
            return decoded.foods.food
        } catch {
            do {
                return try JSONDecoder().decode([Food].self, from: data)
            } catch {
                throw APIError.decodingFailed
            }
        }
    }
}

extension APIClient {
    func getFoodById(food: currentFood) async throws -> Food {
        let encoded = food.fatsecret_food_id
        guard let url = URL(string: "http://127.0.0.1:5000/food/id/\(encoded)") else {
            throw APIError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        if let http = response as? HTTPURLResponse {
            print("HTTP status:", http.statusCode)
        }
        
        do {
            let decoded = try JSONDecoder().decode(FoodByIdResponse.self, from: data)
            var foodResponse = await foodBuilder(foodById: decoded, food: food)
            return foodResponse
        } catch {
            throw APIError.decodingFailed
        }
    }
    
    private func foodBuilder(foodById: FoodByIdResponse, food: currentFood) async -> Food {
        var serving: ServingDetail? = nil
        for item in foodById.food.servings.serving {
            if Int((Double(item.calories) ?? 0).rounded()) == food.calories && Int((Double(item.carbohydrate) ?? 0).rounded()) == food.carbs
                && Int((Double(item.fat) ?? 0).rounded()) == food.fat {
                serving = item
                break
            }
        }
        
        return Food(
            brand_name: food.food_brand,
                food_id: String(food.fatsecret_food_id),
                food_name: food.food_name,
                food_type: food.food_type ?? "Generic",
                food_url: food.food_url ?? "Generic",
                food_description: FoodDescription(
                    serving_size: String(food.serving_amount),
                    calories: "\(food.calories) cal",
                    fat: "\(food.fat) g",
                    carbs: "\(food.carbs) g",
                    protein: "\(food.protein) g"
                )
            )
    }
}

extension APIClient {
    func getRecipes(searchTerm: String,
                    maxCalories: Int?,
                    maxPrepTime: Int?,
                    maxFatPercent: Int?,
                    maxCarbs: Int?) async throws -> [Recipe] {
        guard let url = URL(string: "http://127.0.0.1:5000/recipe") else {
            throw APIError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let recipe = RecipesSearchRequest(method:"",
                                          search_expression:searchTerm,
                                          calories_to:maxCalories,
                                          carb_percentage_to:maxCarbs, 
                                          fat_percentage_to:maxFatPercent,
                                          prep_time_to:maxPrepTime
        )
        
        request.httpBody = try JSONEncoder().encode(recipe)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
//        if let http = response as? HTTPURLResponse {
//            print("HTTP status:", http.statusCode)
//        }
//        
//        print("Raw JSON:", String(data: data, encoding: .utf8) ?? "<not utf8>")
        
        do {
            let decoded = try JSONDecoder().decode(RecipesResponse.self, from: data)
            return decoded.recipes.recipe ?? []
        } catch DecodingError.keyNotFound(let key, let context) {
            print("Missing key:", key.stringValue, context.debugDescription)
            throw APIError.decodingFailed
        }
    }
}
