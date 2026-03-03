//
//  AuthView.swift
//  Food
//
//  Created by Janzen Houchen-Wilder on 1/14/26.
//

import SwiftUI

struct AuthView: View {
    @StateObject private var vm = AuthViewModel()

    var body: some View {
        VStack(spacing: 20) {

            Button("Authenticate") {
                Task { await vm.login() }
            }
            .buttonStyle(.borderedProminent)

            if vm.isLoading {
                ProgressView("Logging in…")
            }

            if let token = vm.token {
                Text("Token: \(token)")
                    .textSelection(.enabled) // copy/paste friendly
                    .padding()
            }

            if let error = vm.errorMessage {
                Text("Error: \(error)")
                    .foregroundStyle(.red)
            }
        }
        .padding()
        .navigationTitle("Login")
    }
}


#Preview {
    AuthView()
}
