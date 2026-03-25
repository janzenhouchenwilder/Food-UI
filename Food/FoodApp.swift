//
//  FoodApp.swift
//  Food
//
//  Created by Janzen Houchen-Wilder on 1/5/26.
//

import SwiftUI

@main
struct FoodApp: App {
    @StateObject var session = SessionManager()
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(session)
//                .preferredColorScheme(.dark)
//                .background(Color(.systemGray6))
        }
    }
}
