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
        VStack(alignment: .center, spacing: 4) {
            Text(recipe.recipe_name)
                .font(.title)
                .bold()
            Text(recipe.recipe_description)
                .fontWeight(.regular)
            Text("Calories")
            Text("\(recipe.recipe_nutrition.calories)g")
                .fontWeight(.regular)
            Text("Carbs")
            Text("\(recipe.recipe_nutrition.carbohydrate)g")
                .fontWeight(.regular)
            Text("Fat")
            Text("\(recipe.recipe_nutrition.fat)g")
                .fontWeight(.regular)
            Text("Protein")
            Text("\(recipe.recipe_nutrition.protein)g")
                .fontWeight(.regular)
        }
        .font(.body)
        .bold()                       // makes the labels bold
        .multilineTextAlignment(.center)
        .frame(maxWidth: .infinity)
        
        List {
            ForEach(recipe.recipe_ingredients.ingredient, id: \.self) { i in
                Text(i)
            }
        }
        
    }
}
