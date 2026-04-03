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
        NavigationView {
            ZStack {
                // BACKGROUND
                LinearGradient(
                    colors: [Color.blue.opacity(0.3), Color.green.opacity(0.3)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()

                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 450)
                    .opacity(0.10)

                if vm.didSendConfirmationEmail {
                    VStack(spacing: 16) {
                        Text("Check your email")
                            .font(.largeTitle)
                            .bold()
                            .foregroundStyle(.white)
                            .shadow(color: .black.opacity(0.3), radius: 2)
                        
                        Text("We sent you a confirmation link. Please verify your email before signing in.")
                            .multilineTextAlignment(.center)
                            .foregroundStyle(.white.opacity(0.85))
                            .padding(.horizontal)
                    }
                    .padding()
                } else {
                    VStack(spacing: 16) {
                        Text("Create Account")
                            .font(.largeTitle)
                            .bold()
                            .foregroundStyle(.white)
                            .shadow(color: .black.opacity(0.3), radius: 2)
                        
                        // Email
                        TextField("Email", text: $email)
                            .textInputAutocapitalization(.never)
                            .autocorrectionDisabled()
                            .keyboardType(.emailAddress)
                            .multilineTextAlignment(.center)
                            .padding()
                            .background(Color.white.opacity(0.6))
                            .foregroundStyle(.white)
                            .cornerRadius(10)
                            .padding(.horizontal)
                            .frame(width: 350)
                        
                        // Password
                        SecureField("Password", text: $password)
                            .padding()
                            .multilineTextAlignment(.center)
                            .background(Color.white.opacity(0.6))
                            .foregroundStyle(.white)
                            .cornerRadius(10)
                            .padding(.horizontal)
                            .frame(width: 350)
                        
                        // Confirm Password
                        SecureField("Confirm Password", text: $confirmPassword)
                            .multilineTextAlignment(.center)
                            .padding()
                            .background(Color.white.opacity(0.6))
                            .foregroundStyle(.white)
                            .cornerRadius(10)
                            .padding(.horizontal)
                            .frame(width: 350)
                        
                        if let msg = vm.errorMessage {
                            Text(msg)
                                .foregroundStyle(.red)
                                .padding(.horizontal)
                        }
                        
                        if vm.isLoading {
                            ProgressView()
                                .tint(.white)
                        }
                        
                        // Sign Up Button
                        Button(action: {
                            Task {
                                await signUp()
                            }
                        }) {
                            Text("Sign Up")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(
                                    Color.white.opacity(0.6)
                                )
                                .foregroundStyle(Color.green.opacity(0.6))
                                .cornerRadius(10)
                                .frame(width: 350)
                        }
                        .disabled(vm.isLoading)
                        .padding(.horizontal)
                    }
                    .padding()
                }
            }
            .navigationTitle("Sign Up")
            .navigationBarTitleDisplayMode(.inline)
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
