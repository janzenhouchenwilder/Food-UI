//
//  TodayDetailViewModel.swift
//  Food
//
//  Created by Janzen Houchen-Wilder on 4/12/26.
//

import Foundation

@MainActor
final class TodayDetailViewModel: ObservableObject {
    @Published var todaysFood: [currentFood] = [currentFood]()
    var totalCalories: Int = 0
    var totalProtein: Int = 0
    var totalFat: Int = 0
    var totalCarbs: Int = 0
    
    init(todaysFood: [currentFood]) {
        self.todaysFood = todaysFood
        for food in todaysFood {
            self.totalCalories += Int((Double(food.calories) * food.total_servings).rounded())
            self.totalCarbs += Int((Double(food.carbs) * food.total_servings).rounded())
            self.totalFat += Int((Double(food.fat) * food.total_servings).rounded())
            self.totalProtein += Int((Double(food.protein) * food.total_servings).rounded())
        }
    }
}
