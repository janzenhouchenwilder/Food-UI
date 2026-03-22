//
//  SessionManager.swift
//  Food
//
//  Created by Janzen Houchen-Wilder on 3/21/26.
//

import Foundation

class SessionManager: ObservableObject {
    @Published var userId: String? = nil
    
    var isLoggedIn: Bool {
        userId != nil
    }
    
    func signIn(userId: String) {
        self.userId = userId
    }
    
    func signOut() {
        self.userId = nil
    }
}
