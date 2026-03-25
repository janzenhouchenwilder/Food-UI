//
//  HomeViewModel.swift
//  Food
//
//  Created by Janzen Houchen-Wilder on 3/21/26.
//

import Foundation

@MainActor
final class HomeViewModel: ObservableObject {
    @Published var todaysFood: [currentFood] = []
    @Published var foodResult: [Food] = []
    @Published var totalCalories: Int = 0
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let foodService = FoodService()
    
    func getTodaysFood(userId: String) async {
        isLoading = true
        errorMessage = nil
        
        do {
            let foods = try await FoodService.shared.getFoods(userId: userId)
            self.totalCalories = foods.reduce(0) { total, food in
                total + Int(Double(food.calories) * food.total_servings)
            }
            await MainActor.run {
                self.todaysFood = foods
            }
        } catch {
            print("Failed to fetch today's foods: \(error)")
        }
        
        isLoading = false
    }
    
    func addFood(userId: String, food: Food, servings: Double) async -> Bool {
        isLoading = true
        errorMessage = nil
        
        let calories: Int = Int(
            (Double(
                food.food_description.calories
                    .replacingOccurrences(of: "[^0-9.]", with: "", options: .regularExpression)
            ) ?? 0).rounded()
        )
        let serving_amount = Int(food.food_description.serving_size.filter { $0.isNumber }) ?? 0
        let newFood: currentFood = currentFood(
            id:food.id,
            user_id: userId,
            food_name:food.food_name,
            calories: calories,
            serving_amount: serving_amount,
            serving_unit: String(food.food_description.serving_size.filter { $0.isLetter }),
            protein: Int(
                (Double(
                    food.food_description.protein
                        .replacingOccurrences(of: "[^0-9.]", with: "", options: .regularExpression)
                ) ?? 0).rounded()
            ),
            fat: Int(
                (Double(
                    food.food_description.fat
                        .replacingOccurrences(of: "[^0-9.]", with: "", options: .regularExpression)
                ) ?? 0).rounded()
            ),
            carbs: Int(
                (Double(
                    food.food_description.carbs
                        .replacingOccurrences(of: "[^0-9.]", with: "", options: .regularExpression)
                ) ?? 0).rounded()
            ),
            fatsecret_food_id: Int64(food.id) ?? 0,
            created_at:ISO8601DateFormatter().string(from: Date()),
            eaten_at:ISO8601DateFormatter().string(from: Date()),
            total_servings:servings
        )
        
        do {
            let foodSaved = await FoodService.shared.addFood(userId: userId, food: newFood)
            if !foodSaved {
                errorMessage = "Failed to save food. Please try again."
                return false
            }
        }
        
        isLoading = false
        return true
    }
}
