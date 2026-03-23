//
//  AuthService.swift
//  Food
//
//  Created by Janzen Houchen-Wilder on 3/15/26.
//

import Foundation
import Supabase

final class AuthService {
    static let shared = AuthService()
    
    private let client = SupabaseManager.shared.client
    
    private init() {}
    
    func signUp(email: String, password: String) async throws {
        try await client.auth.signUp(email: email, password: password)
    }
    
    func signIn(email: String, password: String) async throws -> User {
        let response = try await client.auth.signIn(email: email, password: password)
        return response.user
    }
    
    func signOut() async throws {
        try await client.auth.signOut()
    }
    
    func getCurrentUser() async throws -> User? {
        return try await client.auth.user()
    }

    func getCurrentUserId() async throws -> UUID? {
        let user = try await client.auth.user()
        return user.id
    }
}
