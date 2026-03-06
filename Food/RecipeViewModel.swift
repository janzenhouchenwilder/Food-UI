//
//  RecipeViewModel.swift
//  Food
//
//  Created by Janzen Houchen-Wilder on 3/5/26.
//

import Foundation

@MainActor
final class RecipeViewModel: ObservableObject {
    @Published var recipeResult: [Recipe] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let apiClient = APIClient()
    
    func getRecipes(searchTerm: String,
                    maxCalories: Int?,
                    maxPrepTime: Int?,
                    maxFatPercent: Int?,
                    maxCarbs: Int?) async {
        isLoading = true
        errorMessage = nil
        
        do {
            let result = try await apiClient.getRecipes(
                searchTerm: searchTerm,
                maxCalories: maxCalories,
                maxPrepTime: maxPrepTime,
                maxFatPercent: maxFatPercent,
                maxCarbs: maxCarbs
            )
            recipeResult = result
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
            errorMessage = "An error occurred while getting recipes. Please try again."
        }
        
        isLoading = false
        
    }
}
