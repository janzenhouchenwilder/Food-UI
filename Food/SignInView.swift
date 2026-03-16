//
//  SignInView.swift
//  Food
//
//  Created by Janzen Houchen-Wilder on 3/15/26.
//

import SwiftUI

struct SignInView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    
    @StateObject private var vm = AuthViewModel()
    
    var body: some View {
        VStack (spacing: 16) {
            Text("Sign In")
                .font(.title)
                .bold()
                .padding()
            TextField("Email", text: $email)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
                .keyboardType(.emailAddress)
                .multilineTextAlignment(.center)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal)

            SecureField("Password", text: $password)
                .multilineTextAlignment(.center)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal)
            
            if let msg = vm.errorMessage {
                Text(msg)
                    .foregroundStyle(.red)
                    .padding(.horizontal)
            }

            if vm.isLoading {
                ProgressView()
            }

            Button("Sign In") {
                Task {
                    await signIn()
                }
            }
            .buttonStyle(.borderedProminent)
            .disabled(vm.isLoading)
        }
        .padding()
    }
    
    private func signIn() async {
        let trimmedEmail = email.trimmingCharacters(in: .whitespacesAndNewlines)

        guard !trimmedEmail.isEmpty else {
            vm.errorMessage = "Enter email"
            return
        }

        guard !password.isEmpty else {
            vm.errorMessage = "Enter password"
            return
        }
        
        await vm.signIn(email: email, password: password)
    }
}

#Preview {
    SignInView()
}
