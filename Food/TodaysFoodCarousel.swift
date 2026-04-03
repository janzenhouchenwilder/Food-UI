//
//  TodaysFoodCarousel.swift
//  Food
//
//  Created by Janzen Houchen-Wilder on 3/23/26.
//

import SwiftUI

struct TodaysFoodCarousel: View {
    let foods: [currentFood]
    private let cardWidth: CGFloat = 150
    
    @StateObject private var vm = FoodViewModel()

    var body: some View {
        GeometryReader { geo in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 14) {
                    ForEach(foods, id: \.id) { food in
                        NavigationLink {
                            FoodDetailLoaderView(food: food)
                        } label: {
                            VStack(alignment: .leading, spacing: 10) {
                                
                                Text(food.food_name)
                                    .font(.headline)
                                    .lineLimit(2)

                                Spacer()

                                HStack {
                                    Image(systemName: "flame.fill")
                                        .foregroundColor(.orange)

                                    Text("\(food.calories) cal")
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                }
                            }
                            .padding()
                            .frame(width: cardWidth, height: 110, alignment: .topLeading)
                            .background(
                                LinearGradient(
                                    colors: [
                                        Color.blue.opacity(0.15),
                                        Color.purple.opacity(0.15)
                                    ],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .cornerRadius(12)
                            .shadow(color: .black.opacity(0.2), radius: 4, y: 2)
                        }
                        .buttonStyle(.plain) // prevents weird button styling
                    }
                }
                .frame(
                    minWidth: geo.size.width,
                    alignment: foods.count == 1 ? .center : .leading
                )
                .padding(.horizontal)
            }
        }
        .frame(height: 130)
    }
}

#Preview {
    TodaysFoodCarousel(foods: [currentFood]())
}
