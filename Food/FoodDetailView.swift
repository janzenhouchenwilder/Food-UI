//
//  FoodDetailView.swift
//  Food
//
//  Created by Janzen Houchen-Wilder on 3/3/26.
//

import SwiftUI

struct FoodDetailView: View {
    let food: Food
    
    var body: some View {
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
                Text("\(food.food_description.calories)").fontWeight(.regular)

                Text("Fat")
                Text("\(food.food_description.fat)").fontWeight(.regular)

                Text("Carbs")
                Text("\(food.food_description.carbs)").fontWeight(.regular)

                Text("Protein")
                Text("\(food.food_description.protein)").fontWeight(.regular)
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
            
            Spacer()
        }
        .padding()
        .navigationTitle("Food")
    }
}

#Preview {
    FoodDetailView(food: Food(
        brand_name: "Example Brand",
        food_id: "1",
        food_name: "Example Food",
        food_type: "Generic",
        food_url: "https://example.com",
        food_description: FoodDescription(serving_size: "100 grams", calories: "100kcal", fat: "0.5g", carbs: "2g", protein: "1g")
    ))
}
