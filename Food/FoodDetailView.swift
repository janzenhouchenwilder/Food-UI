//
//  FoodDetailView.swift
//  Food
//
//  Created by Janzen Houchen-Wilder on 3/3/26.
//

import SwiftUI

struct FoodDetailView: View {
    let food: Food
    
    @State private var recipeText: String = ""
    @State private var maxCalories: String = ""
    @State private var maxFatPercent: String = ""
    @State private var maxPrepTime: String = ""
    @State private var maxCarbs: String = ""
    
    @StateObject private var vm: RecipeViewModel = RecipeViewModel()
    
    var body: some View {
        ScrollView {
                VStack(alignment: .center, spacing: 12) {
                    Text(food.food_name)
                        .font(.title)
                        .bold()
                    if let brand = food.brand_name {
                        Text(brand).foregroundStyle(.secondary)
                            .font(.title3)
                    }
                    
                    VStack {
                        Text("Serving Size")
                        Text("\(food.food_description.serving_size)")
                            .fontWeight(.regular)
                        
                        Text("Calories")
                        Text("\(food.food_description.calories)")
                            .fontWeight(.regular)
                        
                        Text("Fat")
                        Text("\(food.food_description.fat)")
                            .fontWeight(.regular)
                        
                        Text("Carbs")
                        Text("\(food.food_description.carbs)")
                            .fontWeight(.regular)
                        
                        Text("Protein")
                        Text("\(food.food_description.protein)")
                            .fontWeight(.regular)
                    }
                    .font(.body)
                    .bold()                       // makes the labels bold
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity)
                    
                    HStack {
                        if let url = URL(string: food.food_url) {
                            Link("Open source page", destination: url)
                        }
                    }
                    
                    //            Spacer()
                    
                    Divider().padding(.vertical, 8)
                
                    VStack(alignment: .center, spacing: 12) {
                        Text("Recipes")
                            .font(.title2)
                            .bold()
                            .frame(maxWidth: .infinity, alignment: .center)
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
                        }
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
                            ProgressView()
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
                                    Text(
                                        recipe.recipe_ingredients.ingredient.first ?? ""
                                    )
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                                }
                            }
                        }
//                        .scrollDismissesKeyboard(.interactively)
                        .frame(height: UIScreen.main.bounds.height * 0.62)
                }
            }
            .padding()
        }
        .navigationTitle("Food")
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
