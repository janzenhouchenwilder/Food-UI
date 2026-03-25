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

    var body: some View {
        GeometryReader { geo in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(foods, id: \.id) { food in
                        VStack(alignment: .leading, spacing: 8) {
                            Text(food.food_name)
                                .font(.headline)
                                .lineLimit(2)

                            Text("\(food.calories) cal")
                                .font(.subheadline)
                        }
                        .padding()
                        .frame(width: cardWidth, height: 100, alignment: .topLeading)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                    }
                }
                .frame(
                    minWidth: geo.size.width,
                    alignment: foods.count == 1 ? .center : .leading
                )
                .padding(.horizontal)
            }
        }
        .frame(height: 120)
    }
}

#Preview {
    TodaysFoodCarousel(foods: [currentFood]())
}
