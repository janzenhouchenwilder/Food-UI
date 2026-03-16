//
//  ContentView.swift
//  Food
//
//  Created by Janzen Houchen-Wilder on 1/5/26.
//

import SwiftUI

struct ContentView: View {

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                
                NavigationLink("Foods") {
                    FoodView()
                }
                .buttonStyle(.borderedProminent)

                /*Button("Load Booking") {
                    Task { await vm.getFoods() }
                }
                .buttonStyle(.bordered)*/
                
                NavigationLink("Sign in") {
                    SignInView()
                }
                .buttonStyle(.automatic)
                
                NavigationLink("Sign up") {
                    SignUpView()
                }

            }
            .padding()
            .navigationTitle("Main")
        }
    }

}



#Preview {
    ContentView()
}
