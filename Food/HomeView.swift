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
                        
                    Text("Today")
                        .font(.title)
                        .bold()
                        
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
            .padding()
            .navigationTitle("Home")
        }
        .sheet(isPresented: $showFoodSearch) {
            FoodView { food in
                Task {
                    guard let userId = session.userId else { return }
                    await vm.addFood(userId, food)
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
