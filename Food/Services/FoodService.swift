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
            try await client
                .from("foods")
                .insert([
                    "user_id": userId,
                    "name": food.name,
                    "calories": String(food.calories),
                    "date": ISO8601DateFormatter().string(from: food.date)
                ])
                .execute()
            return true
        } catch {
            return false
        }
    }
    
    func getFoods() async {
        
    }
}
