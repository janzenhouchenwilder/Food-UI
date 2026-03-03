//
//  AuthViewModel.swift
//  Food
//
//  Created by Janzen Houchen-Wilder on 1/14/26.
//

import Foundation

@MainActor
final class AuthViewModel: ObservableObject {
    @Published var token: String?
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let apiClient = APIClient()

    func login() async {
        isLoading = true
        errorMessage = nil

        do {
            let result = try await apiClient.authenticate()
            token = result.token
        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }
}
