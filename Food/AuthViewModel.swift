//
//  AuthViewModel.swift
//  Food
//
//  Created by Janzen Houchen-Wilder on 3/15/26.
//

import Foundation

@MainActor
final class AuthViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var didSendConfirmationEmail = false
    @Published var didSignIn = false
    @Published var userId: String?
    
    
    func signUp(email: String, password: String) async {
        isLoading = true
        errorMessage = nil
        didSendConfirmationEmail = false
        defer { isLoading = false }
        
        do {
            try await AuthService.shared.signUp(email: email, password: password)
            didSendConfirmationEmail = true
            
        } catch {
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
    
    func signIn(email: String, password: String) async {
        isLoading = true
        errorMessage = nil
        didSignIn = false
        defer { isLoading = false }
        
        do {
            var response = try await AuthService.shared.signIn(email: email, password: password)
            didSignIn = true
            userId = response.id.uuidString
        } catch {
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
}
