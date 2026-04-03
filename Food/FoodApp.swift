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
    
    init()
    {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]

        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(session)
//                .preferredColorScheme(.dark)
//                .background(Color(.systemGray6))
        }
    }
}
