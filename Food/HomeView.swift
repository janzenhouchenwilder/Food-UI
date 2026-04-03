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
            ZStack {
                // BACKGROUND
                LinearGradient(
                    colors: [Color.blue.opacity(0.08), Color.green.opacity(0.3)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()

                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 450)
                    .opacity(0.2)

                VStack(spacing: 20) {
                    
                    if session.userId == nil {
                        Text("Welcome")
                            .font(.largeTitle)
                            .bold()
                            .foregroundStyle(.white)
                            .shadow(color: .black.opacity(0.3), radius: 2)
                        
                        // Sign In
                        NavigationLink {
                            SignInView()
                        } label: {
                            Text("Sign In")
                                .frame(maxWidth: 300)
                                .padding()
                                .background(Color.white.opacity(0.7))
                                .foregroundStyle(Color.green.opacity(0.6))
                                .cornerRadius(10)
                                .bold()
                        }
                        .padding(.horizontal)
                            
                        // Sign Up
                        NavigationLink {
                            SignUpView()
                        } label: {
                            Text("Sign Up")
                                .frame(maxWidth: 300)
                                .padding()
                                .background(Color.white.opacity(0.6))
                                .foregroundStyle(Color.green.opacity(0.6))
                                .cornerRadius(10)
                                .bold()
                        }
                        .padding(.horizontal)
                        
                    } else {
                        
                        // Calorie Card
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Today")
                                    .font(.headline)
                                    .opacity(0.9)

                                Text("\(vm.totalCalories)")
                                    .font(.largeTitle)
                                    .bold()

                                Text("calories")
                                    .font(.caption)
                                    .opacity(0.8)
                            }

                            Spacer()

                            Image(systemName: "flame.fill")
                                .font(.largeTitle)
                        }
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(
                            LinearGradient(
                                colors: [Color.blue, Color.purple],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .cornerRadius(12)
                        .shadow(radius: 5)
                        
                        Text("Today's Meals")
                            .font(.headline)
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal)
                        
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
                            .foregroundColor(.white)
                            .background(
                                LinearGradient(
                                    colors: [Color.green, Color.blue],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .cornerRadius(10)
                            .shadow(radius: 3)
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
            }
            .navigationTitle("NutriBook")
//            .toolbar {
//                ToolbarItem(placement: .principal) {
//                    Text("NutriBook")
//                        .foregroundStyle(.white)
//                        .font(.headline)
//                }
//            }
        }
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
