//
//  SignInViewModel.swift
//  FitMatch-Basit
//
//  Created by basit ch on 7/24/24.
//

import SwiftUI

// ViewModel for handling sign-in logic
class SignInViewModel: BaseViewModel {
    @Published var user = User()
    @Published var isAuthenticated = false 
    
    // Initializer
    override init() {}
}

// Extension for SignInViewModel containing the sign-in function
extension SignInViewModel {
    
    // Function to handle sign-in logic
    func signIn() {
        let hardcodedUsername = "user"
        let hardcodedPassword = "pass123"
        
        // Check if the username is empty
        guard !user.username.isEmpty else {
            showAlert(error: "Please enter username")
            return
        }
        
        // Check if the password is empty
        guard !user.pass.isEmpty else {
            showAlert(error: "Please enter password")
            return
        }
        
        // Validate the credentials
        if user.username == hardcodedUsername && user.pass == hardcodedPassword {
            isLoading = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                withAnimation {
                    self.isAuthenticated = true
                    self.isLoading = false
                }
            }
        } else {
            showAlert(error: "Invalid username or password")
        }
    }
}
