//
//  FoodHistoryDetailView.swift
//  Food
//
//  Created by Janzen Houchen-Wilder on 4/13/26.
//

import Foundation

enum HistoryRange {
    case sevenDays
    case fourWeeks
}

@MainActor
final class FoodHistoryViewModel: ObservableObject {
    @Published var todaysFood: [currentFood] = []
    @Published var foodsByDate: [Date: [currentFood]] = [Date: [currentFood]]()
    @Published var sortedDates: [Date] = [Date]()
    @Published var totalCalories: Int = 0
    @Published var caloriesPerDay: Int = 0
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let foodService = FoodService()
    
    func getFoodsByDate(userId: String, dateString: String) async {
        isLoading = true
        errorMessage = nil
        
        do {
            let foods = await FoodService.shared.getFoodsByDate(userId: userId, dateString: dateString)
            self.foodsByDate = foods
            self.totalCalories = 0
            for food in foods {
                for datedFood in food.value {
                    self.totalCalories += datedFood.calories
                }
            }
            
            if foods.count > 0 {
                self.caloriesPerDay = self.totalCalories / foods.count
            } else {
                self.caloriesPerDay = 0
            }
            self.sortedDates =
                foodsByDate.keys.sorted(by: >)
        } catch {
            errorMessage = "Failed to get foods. Please try again."
        }
        
        isLoading = false
    }
}
