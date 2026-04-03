//
//  FoodService.swift
//  Food
//
//  Created by Janzen Houchen-Wilder on 3/21/26.
//

import Foundation

//struct currentFood: Identifiable, Decodable {
//    let id: String
//    let name: String
//    let calories: Int
//    let date: Date
//}

final class FoodService {
    static let shared = FoodService()
    
    init() {}
    
    private let client = SupabaseManager.shared.client
    
    func addFood(userId: String, food: currentFood) async -> Bool {
        do {
            let now = Date()
            let calendar = Calendar.current

            let hour = calendar.component(.hour, from: now)
            let minute = calendar.component(.minute, from: now)

            let totalMinutes = hour * 60 + minute

            let meal_type: String

            if totalMinutes < (11 * 60 + 30) {
                meal_type = "Breakfast"
            } else if totalMinutes < (14 * 60 + 30) {
                meal_type = "Lunch"
            } else {
                meal_type = "Dinner"
            }
            
            let response = try await client
                .from("food_logs")
                .insert([
                    "user_id": userId,
                    "food_name": food.food_name,
                    "calories": String(food.calories),
                    "carbs": String(food.carbs),
                    "fat": String(food.fat),
                    "protein": String(food.protein),
                    "serving_amount": String(food.serving_amount),
                    "serving_unit": food.serving_unit,
                    "meal_type": meal_type,
                    "fatsecret_food_id": String(food.fatsecret_food_id),
                    "eaten_at": food.eaten_at,
                    "created_at": food.created_at,
                    "total_servings": String(food.total_servings),
                    "food_url": food.food_url,
                    "food_type": food.food_type,
                    "food_brand": food.food_brand
                    
                ])
                .execute()
            print(response)
            return true
        } catch {
            print(error)
            return false
        }
    }
    
    func getFoods(userId: String) async -> [currentFood] {
        do {
            let startOfDay = Calendar.current.startOfDay(for: Date())
                
            let response = try await client
                .from("food_logs")
                .select()
                .eq("user_id", value: userId)
                .gte("created_at", value: startOfDay.ISO8601Format())
                .execute()
            print(response.data)
            let foods: [currentFood] = try JSONDecoder().decode([currentFood].self, from: response.data)
            return foods
        } catch {
            print("Failed to fetch today's foods: \(error)")
        }
        
        return [currentFood]()
    }
}
