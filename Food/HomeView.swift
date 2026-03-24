//
//  HomeView.swift
//  Food
//
//  Created by Janzen Houchen-Wilder on 3/20/26.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var session: SessionManager
    @StateObject private var vm = HomeViewModel()
        
    @State private var showFoodSearch = false

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                    
                if session.userId == nil {
                    // MARK: - Not Logged In
                    Text("Welcome")
                        .font(.largeTitle)
                        .bold()
                        
                    NavigationLink("Sign In") {
                        SignInView()
                    }
                    .buttonStyle(.borderedProminent)
                        
                    NavigationLink("Sign Up") {
                        SignUpView()
                    }
                    .buttonStyle(.bordered)
                        
                } else {
                    // MARK: - Logged In
                        
                    VStack(spacing: 6) {
                        Text("Today")
                            .font(.title)
                            .bold()

                        Text("\(vm.totalCalories) cal")
                            .font(.title2)
                            .fontWeight(.semibold)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                    
                    TodaysFoodCarousel(foods: vm.todaysFood)
                        
                    Button(action: {
                        showFoodSearch = true
                    }) {
                        HStack {
                            Image(systemName: "plus.circle.fill")
                            Text("Add Food").bold()
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }
                    .padding(.horizontal)
                        
                    Spacer()
                }
            }
            .task(id: session.userId) {
                if let userId = session.userId {
                    await vm.getTodaysFood(userId: userId)
                }
            }
            .padding()
            .navigationTitle("Home")
        }
        .background(Color(.systemBackground))
        .sheet(isPresented: $showFoodSearch) {
            FoodView { food, servings in
                guard let userId = session.userId else { return false }

                let success = await vm.addFood(userId: userId, food: food, servings: servings)

                if success {
                    await vm.getTodaysFood(userId: userId)
                }

                return success
            }
        }
    }
}

#Preview {
    HomeView()
}
