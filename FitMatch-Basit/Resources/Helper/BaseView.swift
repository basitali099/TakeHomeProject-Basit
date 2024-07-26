//
//  BaseView.swift
//  FitMatch-Basit
//
//  Created by basit ch on 7/24/24.
//

import Foundation
import SwiftUI

// View representing a background gradient
struct BackgroundGradientView: View {
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .top, endPoint: .bottom)
            .edgesIgnoringSafeArea(.all)
    }
}

// View representing a sign-out button
struct SignOutButton: View {
    @EnvironmentObject var signInViewModel: SignInViewModel
    
    var body: some View {
        Button {
            // Toggle the authentication status
            signInViewModel.isAuthenticated.toggle()
        } label: {
            HStack {
                Image(systemName: "rectangle.portrait.and.arrow.right")
                    .foregroundStyle(.white)
                Text("Log Out")
                    .foregroundColor(.white)
            }
        }
    }
}
