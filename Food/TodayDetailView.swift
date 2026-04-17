//
//  TodayDetailView.swift
//  Food
//
//  Created by Janzen Houchen-Wilder on 4/12/26.
//

import SwiftUI

struct TodayDetailView: View {
    let todaysFood: [currentFood] = [currentFood]()
    
    @StateObject private var vm: TodayDetailViewModel
    init(todaysFood: [currentFood]) {
        _vm = StateObject(wrappedValue: TodayDetailViewModel(todaysFood: todaysFood))
    }
    
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Color.blue.opacity(0.08), Color.green.opacity(0.6)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(width: 600)
                .opacity(0.6)
            
            VStack(spacing: 16) {
                
                Text("Today")
                    .font(.largeTitle)
                    .bold()
                    .foregroundStyle(.white)

                // MAIN CALORIES CARD
                VStack {
                    Text("Calories")
                        .font(.headline)
                        .opacity(0.8)

                    Text("\(vm.totalCalories)")
                        .font(.system(size: 40, weight: .bold))
                }
                .foregroundStyle(.white)
                .frame(maxWidth: 200)
                .padding()
                .background(.ultraThinMaterial)
                .cornerRadius(16)

                // MACROS GRID
                HStack(spacing: 12) {
                    statCard(title: "Carbs", value: "\(vm.totalCarbs)g")
                    statCard(title: "Fat", value: "\(vm.totalFat)g")
                    statCard(title: "Protein", value: "\(vm.totalProtein)g")
                }
            }
            .padding()
        }
    }
    
    func statCard(title: String, value: String) -> some View {
        VStack {
            Text(value)
                .font(.title2)
                .bold()
            
            Text(title)
                .font(.caption)
                .opacity(0.8)
        }
        .foregroundStyle(.white)
        .frame(maxWidth: 75)
        .frame(height: 80)
        .padding()
        .background(.ultraThinMaterial)
        .cornerRadius(12)
    }
}

#Preview {
    TodayDetailView(
            todaysFood: [
                currentFood(
                    id: "",
                    user_id: "",
                    food_name: "Oatmeal",
                    calories: 150,
                    serving_amount: 2,
                    serving_unit: "100 g",
                    protein: 7,
                    fat: 0,
                    carbs: 29,
                    fatsecret_food_id: 1000,
                    created_at: "12-04-2026",
                    eaten_at: "12-04-2026",
                    total_servings: 2.0,
                    food_url: nil,
                    food_type: nil,
                    food_brand: nil
                )
            ]
        )
}
