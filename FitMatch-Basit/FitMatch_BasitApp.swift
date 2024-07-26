//
//  FitMatch_BasitApp.swift
//  FitMatch-Basit
//
//  Created by basit ch on 7/24/24.
//

import SwiftUI

@main
// Main application struct conforming to the App protocol
struct FitMatch_BasitApp: App {
    // State object to manage the sign-in view model
    @StateObject var viewModel = SignInViewModel()
    
    var body: some Scene {
        WindowGroup {
            // Check if the user is authenticated
            if viewModel.isAuthenticated {
                // Show the main tab view if authenticated
                AppTabView()
                    .environmentObject(viewModel)
                    .preferredColorScheme(.dark)
            } else {
                // Show the sign-in view if not authenticated
                SignInView()
                    .environmentObject(viewModel)
            }
        }
    }
}
