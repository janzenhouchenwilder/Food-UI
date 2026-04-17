//
//  RecipeDetailView.swift
//  Food
//
//  Created by Janzen Houchen-Wilder on 3/5/26.
//

import Foundation
import SwiftUI

struct RecipeDetailView: View {
    let recipe: Recipe
    
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

            VStack(spacing: 8) {
                // TOP SECTION
                Spacer()
                VStack(alignment: .center, spacing: 4) {
                    Text(recipe.recipe_name)
                        .font(.title)
                        .bold()
                        .foregroundStyle(.white)

                    Text(recipe.recipe_description)
                        .foregroundStyle(.white.opacity(0.9))
                        .padding(8)

                    Text("Calories")
                        .foregroundStyle(Color.green)
                    Text("\(recipe.recipe_nutrition.calories)g")
                        .foregroundStyle(.white)

                    Text("Carbs")
                        .foregroundStyle(Color.green)
                    Text("\(recipe.recipe_nutrition.carbohydrate)g")
                        .foregroundStyle(.white)

                    Text("Fat")
                        .foregroundStyle(Color.green)
                    Text("\(recipe.recipe_nutrition.fat)g")
                        .foregroundStyle(.white)

                    Text("Protein")
                        .foregroundStyle(Color.green)
                    Text("\(recipe.recipe_nutrition.protein)g")
                        .foregroundStyle(.white)
                }
                .font(.body)
                .bold()
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity)
                .padding(.horizontal)
                
                Spacer()
                
                ScrollView {
                    VStack(spacing: 0) {
                        ForEach(recipe.recipe_ingredients.ingredient, id: \.self) { i in
                            Text(i)
                                .foregroundStyle(.white)
                                .font(.headline)
                                .bold()
                                .multilineTextAlignment(.center)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 10)

                            Divider()
                                .background(Color.white.opacity(0.2)) 
                        }
                    }
                    .padding(.horizontal, 8)
                }
            }
        }
    }
}

#Preview {
    let recipe = Recipe(recipe_id:"1", recipe_name:"blueberry",recipe_description: "A delicious recipe", recipe_image: nil,recipe_ingredients: RecipeIngredients(ingredient: ["blueberry","bagel","peanut butter chocolate"]),recipe_nutrition:RecipeNutrition(calories:"200",carbohydrate: "20",fat: "12",protein: "12"),
                        recipe_types: RecipeTypes(recipe_type: ["Healthy"]))
    RecipeDetailView(recipe: recipe)
}
    

//struct RecipeDetailView: View {
//    let recipe: Recipe
//    
//    var body: some View {
//        ZStack {
//            LinearGradient(
//                colors: [Color.blue.opacity(0.3), Color.green.opacity(0.3)],
//                startPoint: .topLeading,
//                endPoint: .bottomTrailing
//            )
//            .ignoresSafeArea()
//            
//            Image("logo")
//                .resizable()
//                .scaledToFit()
//                .frame(width: 450)
//                .opacity(0.10)
//            
//            VStack(alignment: .center, spacing: 4) {
//                Text(recipe.recipe_name)
//                    .font(.title)
//                    .bold()
//                    .foregroundStyle(.green)
//                
//                Text(recipe.recipe_description)
//                    .fontWeight(.regular)
//                    .foregroundStyle(.green.opacity(0.9))
//
//                Text("Calories")
//                    .foregroundStyle(Color.green)
//                Text("\(recipe.recipe_nutrition.calories)g")
//                    .foregroundStyle(.green)
//
//                Text("Carbs")
//                    .foregroundStyle(Color.green)
//                Text("\(recipe.recipe_nutrition.carbohydrate)g")
//                    .foregroundStyle(.green)
//
//                Text("Fat")
//                    .foregroundStyle(Color.green)
//                Text("\(recipe.recipe_nutrition.fat)g")
//                    .foregroundStyle(.green)
//
//                Text("Protein")
//                    .foregroundStyle(Color.green)
//                Text("\(recipe.recipe_nutrition.protein)g")
//                    .foregroundStyle(.green)
//            }
//            .font(.body)
//            .bold()
//            .multilineTextAlignment(.center)
//            .frame(maxWidth: .infinity)
//            .padding(.horizontal)
//            
//            VStack {
//                Spacer()
//
//                List {
//                    ForEach(recipe.recipe_ingredients.ingredient, id: \.self) { i in
//                        Text(i)
//                            .foregroundStyle(.green)
//                    }
//                }
//                .scrollContentBackground(.hidden) // 👈 keeps gradient
//                .listRowBackground(Color.clear)   // 👈 transparent rows
//                .listRowSeparator(.visible)
//                .listRowSeparatorTint(.green.opacity(0.2))
//            }
//        }
//    }
//}

/*
 struct RecipeDetailView: View {
     let recipe: Recipe
     
     var body: some View {
         ZStack {
             // BACKGROUND (same as FoodView)
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

             VStack(alignment: .center, spacing: 4) {
                 Text(recipe.recipe_name)
                     .font(.title)
                     .bold()
                     .foregroundStyle(.white)

                 Text(recipe.recipe_description)
                     .fontWeight(.regular)
                     .foregroundStyle(.white.opacity(0.9))

                 Text("Calories")
                     .foregroundStyle(Color.green)
                 Text("\(recipe.recipe_nutrition.calories)g")
                     .foregroundStyle(.white)

                 Text("Carbs")
                     .foregroundStyle(Color.green)
                 Text("\(recipe.recipe_nutrition.carbohydrate)g")
                     .foregroundStyle(.white)

                 Text("Fat")
                     .foregroundStyle(Color.green)
                 Text("\(recipe.recipe_nutrition.fat)g")
                     .foregroundStyle(.white)

                 Text("Protein")
                     .foregroundStyle(Color.green)
                 Text("\(recipe.recipe_nutrition.protein)g")
                     .foregroundStyle(.white)
             }
             .font(.body)
             .bold()
             .multilineTextAlignment(.center)
             .frame(maxWidth: .infinity)
             .padding(.horizontal)

             VStack {
                 Spacer()

                 List {
                     ForEach(recipe.recipe_ingredients.ingredient, id: \.self) { i in
                         Text(i)
                             .foregroundStyle(.white)
                     }
                 }
                 .scrollContentBackground(.hidden) // 👈 keeps gradient
                 .listRowBackground(Color.clear)   // 👈 transparent rows
                 .listRowSeparator(.visible)
                 .listRowSeparatorTint(.white.opacity(0.2))
             }
         }
     }
 }
 
 */
