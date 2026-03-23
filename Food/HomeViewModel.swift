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
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let foodService = FoodService()
    
    func getTodaysFood(_ userId: String, _ food: currentFood) async {
        isLoading = true
        errorMessage = nil
        
        do {
            let foodSaved = await FoodService.shared.addFood(userId: userId, food: food)
            if !foodSaved {
                errorMessage = "Failed to save food. Please try again."
            }
        }
        
        isLoading = false
    }
    
    func addFood(_ userId: String, _ food: Food) async {
        isLoading = true
        errorMessage = nil
        
        var calories: Int = Int(food.food_description.calories.filter { $0.isNumber }) ?? 0
        var newFood: currentFood = currentFood(
            id:food.id,
            name:food.food_name,
            calories: calories,
            date:Date()
        )
        
        do {
            let foodSaved = await FoodService.shared.addFood(userId: userId, food: newFood)
            if !foodSaved {
                errorMessage = "Failed to save food. Please try again."
            }
        }
        
        isLoading = false
    }
}
