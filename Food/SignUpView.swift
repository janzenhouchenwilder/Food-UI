//
//  SignUpView.swift
//  Food
//
//  Created by Janzen Houchen-Wilder on 3/15/26.
//

import SwiftUI

struct SignUpView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    
    @StateObject private var vm: AuthViewModel = AuthViewModel()
    
    var body: some View {
        if vm.didSendConfirmationEmail {
            VStack(spacing: 16) {
                Text("Check your email")
                    .font(.title)
                    .bold()
                
                Text(
                    "We sent you a confirmation link. Please verify your email before signing in."
                )
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            }
        } else {
            VStack(spacing: 16) {
                Text("Create Account")
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
                
                SecureField("Confirm Password", text: $confirmPassword)
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
                
                Button("Sign Up") {
                    Task {
                        await signUp()
                    }
                }
                .buttonStyle(.borderedProminent)
                .disabled(vm.isLoading)
            }
            .padding()
        }
    }
    
    private func signUp() async {
        let trimmedEmail = email.trimmingCharacters(in: .whitespacesAndNewlines)

        guard !trimmedEmail.isEmpty else {
            vm.errorMessage = "Email is required"
            return
        }

        guard !password.isEmpty else {
            vm.errorMessage = "Password is required"
            return
        }

        guard password == confirmPassword else {
            vm.errorMessage = "Passwords do not match"
            return
        }

        await vm.signUp(email: trimmedEmail, password: password)
    }
}

#Preview {
    SignUpView()
}
