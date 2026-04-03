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
    
    @EnvironmentObject var session: SessionManager
    @Environment(\.dismiss) var dismiss
    
    @StateObject private var vm = AuthViewModel()
    
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

                VStack(spacing: 16) {
                    Text("Sign In")
                        .font(.largeTitle)
                        .bold()
                        .foregroundStyle(.white)
                        .shadow(color: .black.opacity(0.3), radius: 2)
                    
                    // Email
                    TextField("Email", text: $email)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                        .keyboardType(.emailAddress)
                        .padding()
                        .multilineTextAlignment(.center)
                        .background(Color.white.opacity(0.4))
                        .cornerRadius(10)
                        .padding(.horizontal)
                    
                    // Password
                    SecureField("Password", text: $password)
                        .padding()
                        .background(Color.white.opacity(0.4))
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.white)
                        .cornerRadius(10)
                        .padding(.horizontal)
                    
                    if let msg = vm.errorMessage {
                        Text(msg)
                            .foregroundStyle(.red)
                            .padding(.horizontal)
                    }

                    if vm.isLoading {
                        ProgressView()
                            .tint(.white)
                    }

                    // Sign In Button
                    Button(action: {
                        Task {
                            await signIn()
                        }
                    }) {
                        Text("Sign In")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(
                                Color.white.opacity(0.6)
                            )
                            .foregroundStyle(Color.green.opacity(0.6))
                            .bold()
                            .cornerRadius(10)
                    }
                    .disabled(vm.isLoading)
                    .padding(.horizontal)
                }
                .padding()
                .onChange(of: vm.didSignIn) { didSignIn in
                    if didSignIn, let userId = vm.userId {
                        session.signIn(userId: userId)
                        dismiss()
                    }
                }
            }
            .navigationTitle("Sign In")
            .navigationBarTitleDisplayMode(.inline)
        }
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
