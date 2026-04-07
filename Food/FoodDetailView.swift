//
//  FoodDetailView.swift
//  Food
//
//  Created by Janzen Houchen-Wilder on 3/3/26.
//

import SwiftUI

struct FoodDetailView: View {
    let food: Food
    var onAddFood: ((Food, Double) async -> Bool)?
    
    @State private var bannerMessage: String? = nil
    @State private var showBanner = false
    @State private var isSuccess = true
    @State private var recipeText: String = ""
    @State private var maxCalories: String = ""
    @State private var maxFatPercent: String = ""
    @State private var maxPrepTime: String = ""
    @State private var maxCarbs: String = ""
    @State private var servings: String = ""
    
    @StateObject private var vm: RecipeViewModel = RecipeViewModel()
    
    var body: some View {
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

            ScrollView {
                VStack(alignment: .center, spacing: 12) {
                    Text(food.food_name)
                        .font(.title)
                        .bold()
                        .foregroundStyle(.white)

                    if let brand = food.brand_name {
                        Text(brand)
                            .foregroundStyle(.white.opacity(0.8))
                            .font(.title3)
                    }
                    
                    VStack {
                        Text("Serving Size")
                        Text("\(food.food_description.serving_size)")
                        
                        Text("Calories")
                        Text("\(food.food_description.calories)")
                        
                        Text("Fat")
                        Text("\(food.food_description.fat)")
                        
                        Text("Carbs")
                        Text("\(food.food_description.carbs)")
                        
                        Text("Protein")
                        Text("\(food.food_description.protein)")
                    }
                    .font(.body)
                    .bold()
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(.white)
                    
                    VStack {
                        TextField("Servings", text: $servings)
                            .keyboardType(.numberPad)
                            .textFieldStyle(.roundedBorder)
                    }.padding(.horizontal, 16)
                    
                    Button("Add Food") {
                        Task {
                            let servingsSize = Double(servings) ?? 1.0
                            let success = await onAddFood?(food, servingsSize) ?? false
                            
                            bannerMessage = success ? "Food added!" : "Failed to add food"
                            showBanner = true
                            isSuccess = success
                            
                            DispatchQueue.main
                                .asyncAfter(deadline: .now() + 2) {
                                    showBanner = false
                                }
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    
                    HStack {
                        if let url = URL(string: food.food_url) {
                            Link("Open source page", destination: url)
                                .foregroundStyle(.white)
                        }
                    }
                    
                    Divider().padding(.vertical, 8)
                    
                    VStack(alignment: .center, spacing: 12) {
                        Text("Recipes")
                            .font(.title2)
                            .bold()
                            .frame(maxWidth: .infinity, alignment: .center)
                            .foregroundStyle(.white)

                        HStack {
                            TextField("Max calories", text: $maxCalories)
                                .keyboardType(.numberPad)
                                .textFieldStyle(.roundedBorder)
                            TextField("Max fat %", text: $maxFatPercent)
                                .keyboardType(.numberPad)
                                .textFieldStyle(.roundedBorder)
                            TextField("Max prep \n(min)", text: $maxPrepTime)
                                .keyboardType(.numberPad)
                                .textFieldStyle(.roundedBorder)
                        }.padding(.horizontal, 16)
                        HStack {
                            TextField("Max carbs %", text: $maxCarbs)
                                .keyboardType(.numberPad)
                                .textFieldStyle(.roundedBorder)
                        }.frame(width:120)
                        
                        Button("Find Recipes...") {
                            Task {
                                await searchRecipes()
                                print(vm.recipeResult.count)
                            }
                        }
                        .buttonStyle(.borderedProminent)

                        if vm.isLoading {
                            ProgressView().tint(.white)
                        }
                        
                        if let msg = vm.errorMessage {
                            Text(msg)
                                .foregroundStyle(.red)
                                .padding(.horizontal)
                        }
                        
                        List(vm.recipeResult) { recipe in
                            NavigationLink {
                                RecipeDetailView(recipe: recipe)
                            } label: {
                                VStack(alignment: .leading) {
                                    Text(recipe.recipe_name)
                                        .font(.headline)
                                        .foregroundStyle(.white)

                                    Text(recipe.recipe_ingredients.ingredient.first ?? "")
                                        .font(.caption)
                                        .foregroundStyle(Color(red: 0.0, green: 0.8, blue: 0.3))
                                }
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
//                                .background(.ultraThinMaterial) // glass
                                .cornerRadius(12)
                            }
                            .listRowBackground(Color.clear)
                        }
                        .scrollContentBackground(.hidden) // key
                        .background(Color.clear)
                        .frame(height: UIScreen.main.bounds.height * 0.62)
                    }
                }
                .padding()
            }
            .navigationTitle("Food")

            if let message = bannerMessage, showBanner {
                Text(message)
                    .padding()
                    .background(isSuccess ? Color.green : Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .padding(.top, 50)
                    .transition(.opacity)
            }
        }
        .animation(.easeInOut, value: showBanner)
    }
    
    private func searchRecipes() async {
        let trimmed = food.food_name.trimmingCharacters(
            in: .whitespacesAndNewlines
        )
        guard !trimmed.isEmpty else { return }
        let maxCals: Int? = !maxCalories.isEmpty ? Int(maxCalories) : nil
        let maxFatPer: Int? = !maxFatPercent.isEmpty ? Int(maxFatPercent) : nil
        let maxPT: Int? = !maxPrepTime.isEmpty ? Int(maxPrepTime) : nil
        let maxCarb: Int? = !maxCarbs.isEmpty ? Int(maxCarbs) : nil
        await vm
            .getRecipes(
                searchTerm:trimmed,
                maxCalories: maxCals,
                maxPrepTime: maxPT,
                maxFatPercent: maxFatPer,
                maxCarbs:maxCarb
            )
    }
}

#Preview {
    FoodDetailView(
food: Food(
        brand_name: "Example Brand",
        food_id: "1",
        food_name: "Example Food",
        food_type: "Generic",
        food_url: "https://example.com",
        food_description: FoodDescription(
            serving_size: "100 grams",
            calories: "100kcal",
            fat: "0.5g",
            carbs: "2g",
            protein: "1g"
        )
)
    )
}
