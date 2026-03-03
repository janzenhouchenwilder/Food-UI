//
//  FoodViewModel.swift
//  Food
//
//  Created by Janzen Houchen-Wilder on 2/4/26.
//

import Foundation

@MainActor

final class FoodViewModel: ObservableObject {
    @Published var foodResult: [Food] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let apiClient = APIClient()
    
//    func searchFood() -> Foods {
//        var foods = Foods(food)
//        
//        
//        //Call the api to get foods
//        
//        return foods
//    }
    
    func getFoods(_ food: String) async {
        isLoading = true
        errorMessage = nil

        do {
            let result = try await apiClient.getFoods(food: food)
            foodResult = result
        } catch {
            errorMessage = (error as? LocalizedError)?.errorDescription
                ?? error.localizedDescription
        }

        isLoading = false
    }
}
