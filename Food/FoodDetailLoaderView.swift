//
//  FoodDetailLoaderView.swift
//  Food
//
//  Created by Janzen Houchen-Wilder on 4/1/26.
//

import SwiftUI

struct FoodDetailLoaderView: View {
    let food: currentFood
    @StateObject private var vm = FoodViewModel()

    var body: some View {
        Group {
            if let food = vm.detailedFood {
                FoodDetailView(food: food)
            } else if vm.isLoading {
                ProgressView()
            } else if let msg = vm.errorMessage {
                Text(msg)
                    .foregroundStyle(.red)
            } else {
                ProgressView()
            }
        }
        .task {
            await vm.getCurrentFoodDetails(food: food)
        }
    }
}

#Preview {
    FoodDetailLoaderView(food: currentFood(id: "", user_id: "", food_name: "generic", calories: 10, serving_amount: 10, serving_unit: "gram", protein: 5, fat: 2, carbs: 20, fatsecret_food_id: 1, created_at: "", eaten_at: "", total_servings: 1.0, food_url: "", food_type: "", food_brand: ""))
}
