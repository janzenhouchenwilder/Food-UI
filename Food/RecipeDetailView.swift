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
        }
    }
}
