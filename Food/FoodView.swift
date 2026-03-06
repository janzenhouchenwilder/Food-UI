//
//  FoodView.swift
//  Food
//
//  Created by Janzen Houchen-Wilder on 3/2/26.
//

import Foundation
import SwiftUI


struct FoodView: View {
    @State private var foodText: String = ""
    @State private var isLoading = false
    @State private var error: String?
//    @FocusState private var foodFieldFocused: Bool
    @StateObject private var vm = FoodViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                TextField("Search food...", text: $foodText)
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal)
//                    .focused($foodFieldFocused)
                Button("Search") {
                    Task {
//                        foodFieldFocused = false
                        await searchFoods()
                    }
                }
                .buttonStyle(.borderedProminent)
                if vm.isLoading {
                    ProgressView()
                }
                
                if let msg = vm.errorMessage {
                    Text(msg)
                        .foregroundStyle(.red)
                        .padding(.horizontal)
                }
                
                List(vm.foodResult) { food in
                    NavigationLink {
                        FoodDetailView(food: food)
                    } label: {
                        VStack(alignment: .leading) {
                            Text(food.food_name)
                                .font(.headline)
                            
                            if let brand = food.brand_name {
                                Text(brand)
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                            
                            Text(food.food_description.serving_size)
                                .font(.caption)
                                .foregroundStyle(.secondary)
                                .lineLimit(2)
                        }
                    }
                }
                .scrollDismissesKeyboard(.interactively)
            }
        }
    }
    
    private func searchFoods() async {
        let trimmed = foodText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        await vm.getFoods(trimmed)
    }
}

#Preview {
    FoodView()
}
