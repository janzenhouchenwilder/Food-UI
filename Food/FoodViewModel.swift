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
    @Published var todaysFood: [currentFood] = []
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
        } catch let error as APIError {
            switch error {
            case .badStatus(let code):
                errorMessage = "Bad Http Status \(code)"
            case .invalidURL:
                errorMessage = "Invalid request URL."
            case .invalidResponse:
                errorMessage = "Server returned an invalid response."
            case .decodingFailed:
                errorMessage = "Unable to get food data."
            case .serverError(let code):
                errorMessage = "Server error: \(code)"
            case .networkError:
                errorMessage = "Network connection failed."
            }
        } catch {
            errorMessage = "An error occurred while getting foods. Please try again."
        }

        isLoading = false
    }
}
