//
//  FoodHistoryView.swift
//  Food
//
//  Created by Janzen Houchen-Wilder on 4/13/26.
//

import SwiftUI

struct FoodHistoryView: View {
    @StateObject private var vm = FoodHistoryViewModel()
    @EnvironmentObject var session: SessionManager
    
    let range: HistoryRange
    
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Color.blue.opacity(0.08), Color.green.opacity(0.6)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(width: 600)
                .opacity(0.1)
            
            List {
                ForEach(vm.sortedDates, id: \.self) { date in
                    let foods = vm.foodsByDate[date] ?? []

                    Section(
                        header:
                            HStack {
                                Spacer()
                                
                                Text(date.formatted(date: .abbreviated, time: .omitted))
                                    .foregroundStyle(.white)
                                    .font(.headline)
                                    .padding(.vertical, 6)
                                    .padding(.horizontal, 12)
                                    .background(.ultraThinMaterial)
                                    .clipShape(Capsule())
                                
                                Spacer()
                            }
                    ) {
                        ForEach(foods) { food in
                            NavigationLink {
                                FoodDetailView(
                                    food: mapToFood(food),
                                    onAddFood: nil
                                )
                            } label: {
                                ZStack {
                                    VStack(spacing: 4) {
                                        Text(food.food_name)
                                            .font(.headline)
                                            .foregroundStyle(.white)
                                            .lineLimit(1)
                                        
                                        Text("\(food.calories) cal")
                                            .font(.caption)
                                            .foregroundStyle(.white.opacity(0.7))
                                    }
                                    .multilineTextAlignment(.center)
                                    
                                    HStack {
                                        Spacer()
                                        Image(systemName: "chevron.right")
                                            .foregroundStyle(.white.opacity(0.6))
                                    }
                                }
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(.ultraThinMaterial)
                                .clipShape(RoundedRectangle(cornerRadius: 16))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(Color.white.opacity(0.15), lineWidth: 1)
                                )
                                .shadow(color: .black.opacity(0.2), radius: 6, y: 3)
                                .padding(.horizontal, 4)
                                .padding(.vertical, 4)
                            }
                            .buttonStyle(.plain)
                            .listRowBackground(Color.clear)
                            .alignmentGuide(.listRowSeparatorLeading) { _ in 0 }
                            .alignmentGuide(.listRowSeparatorTrailing) { _ in 0 }
                        }
                    }
                }
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
            .contentMargins(.horizontal, 0)
            .safeAreaPadding(.horizontal, 12)
            .listRowSeparator(.visible)
            .listRowSeparatorTint(.white.opacity(0.2))
        }
        .navigationTitle("History")
        .task {
            if let userId = session.userId {
                let dateString = getStartDateString()
                await vm.getFoodsByDate(userId: userId, dateString: dateString)
            }
        }
    }
    
    private func getStartDateString() -> String {
        let calendar = Calendar.current
        let today = Date()
        
        let startDate: Date
        
        switch range {
        case .sevenDays:
            startDate = calendar.date(byAdding: .day, value: -7, to: today)!
        case .fourWeeks:
            startDate = calendar.date(byAdding: .day, value: -28, to: today)!
        }
        
        return startDate.ISO8601Format()
    }
    
    private func mapToFood(_ food: currentFood) -> Food {
        return Food(
            brand_name: food.food_brand,
            food_id: String(food.fatsecret_food_id),
            food_name: food.food_name,
            food_type: food.food_type ?? "",
            food_url: food.food_url ?? "",
            food_description: FoodDescription(
                serving_size: food.serving_unit,
                calories: String(food.calories),
                fat: String(food.fat),
                carbs: String(food.carbs),
                protein: String(food.protein)
            )
        )
    }
}

#Preview {
    FoodHistoryView(range: HistoryRange.sevenDays)
}
