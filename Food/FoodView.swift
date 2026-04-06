//
//  FoodView.swift
//  Food
//
//  Created by Janzen Houchen-Wilder on 3/2/26.
//

import Foundation
import SwiftUI


struct FoodView: View {
    @Environment(\.dismiss) private var dismiss
    
    var onSelect: ((Food, Double) async -> Bool)?
    @State private var foodText: String = ""
    @State private var isLoading = false
    @State private var error: String?
//    @FocusState private var foodFieldFocused: Bool
    @StateObject private var vm = FoodViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                // BACKGROUND
                LinearGradient(
                    colors: [Color.blue.opacity(0.3), Color.green.opacity(0.3)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()

                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 450)
                    .opacity(0.10)

                VStack {
                    TextField("Search food...", text: $foodText)
                        .padding()
                        .textFieldStyle(.roundedBorder)
                        .background(.ultraThinMaterial)
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
                            .tint(.white)
                    }
                    
                    if let msg = vm.errorMessage {
                        Text(msg)
                            .foregroundStyle(.red)
                            .padding(.horizontal)
                    }
                    
                    List(vm.foodResult) { food in
                        NavigationLink {
                            FoodDetailView(food: food, onAddFood: onSelect)
                        } label: {
                            VStack(alignment: .leading) {
                                Text(food.food_name)
                                    .font(.headline)
                                    .foregroundStyle(.white)
                                    .lineLimit(1)
                                
                                if let brand = food.brand_name {
                                    Text(brand)
                                        .font(.caption)
//                                        .foregroundStyle(.green.opacity(0.8))
                                        .foregroundStyle(Color(red: 0.0, green: 0.8, blue: 0.3))
                                }
                                
                                Text(food.food_description.serving_size)
                                    .font(.caption)
                                    .foregroundStyle(Color.green.opacity(0.7))
                                    .lineLimit(2)
                            }
                            .padding(4)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .frame(height: 80)
                            .background(.ultraThinMaterial)
                            .cornerRadius(12)
                        }
                        .listRowBackground(Color.clear)
                    }
                    .scrollDismissesKeyboard(.interactively)
                    .scrollContentBackground(.hidden)
                    .listRowSpacing(10)
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Close") {
                        dismiss()
                    }
                    .foregroundStyle(.white)
                }
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
