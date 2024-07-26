//
//  SignInView.swift
//  FitMatch-Basit
//
//  Created by basit ch on 7/24/24.
//

import SwiftUI

// View representing the sign-in screen
struct SignInView: View {
    @EnvironmentObject var viewModel: SignInViewModel
    @FocusState private var isInputActive: Bool
    
    var body: some View {
        NavigationStack {
            ZStack {
                BackgroundGradientView() 
                VStack {
                    headerView
                    inputFields
                    signInButton
                }
                .padding(.horizontal)
            }
            .alert(isPresented: $viewModel.isPresentAlert) {
                Alert(title: Text(viewModel.alertTitle))
            }
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        isInputActive = false
                    }
                }
            }
        }
    }
    
    // Header view with the app title
    private var headerView: some View {
        Text("FitMatch:AI")
            .font(.largeTitle)
            .fontWeight(.bold)
            .foregroundColor(.white)
            .padding(.bottom, 40)
    }
    
    // View containing the input fields for username and password
    private var inputFields: some View {
        VStack(alignment: .leading, spacing: 20) {
            usernameField
            passwordField
        }
        .focused($isInputActive)
    }
    
    // Username input field
    private var usernameField: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Username")
                .foregroundColor(.white)
                .font(.headline)
            
            TextField("Enter your username", text: $viewModel.user.username)
                .padding()
                .background(Color.white.opacity(0.8))
                .cornerRadius(10)
        }
    }
    
    // Password input field
    private var passwordField: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Password")
                .foregroundColor(.white)
                .font(.headline)
            
            SecureField("Enter your password", text: $viewModel.user.pass)
                .padding()
                .background(Color.white.opacity(0.8))
                .cornerRadius(10)
        }
    }
    
    // Sign-in button with loading indicator
    private var signInButton: some View {
        Button(action: {
            if !viewModel.isLoading {
                viewModel.signIn()
                isInputActive = false
            }
        }) {
            Text(viewModel.isLoading ? "" : "Sign In")
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .cornerRadius(10)
        }
        .padding(.vertical, 40)
        .overlay {
            if viewModel.isLoading {
                ProgressView() // Show loading indicator while signing in
            }
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
            .environmentObject(SignInViewModel())
    }
}
