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
        VStack(alignment: .center, spacing: 12) {
            Text(recipe.recipe_name)
                .font(.title)
                .bold()
            Text(recipe.recipe_description)
                .fontWeight(.regular)
            Text(recipe.recipe_nutrition.calories)
                .fontWeight(.regular)
            Text(recipe.recipe_nutrition.carbohydrate)
                .fontWeight(.regular)
            Text(recipe.recipe_nutrition.fat)
                .fontWeight(.regular)
            Text(recipe.recipe_nutrition.protein)
                .fontWeight(.regular)
            
            List {
                ForEach(recipe.recipe_ingredients.ingredient, id: \.self) { i in
                    Text(i)
                }
            }
        }
    }
}
