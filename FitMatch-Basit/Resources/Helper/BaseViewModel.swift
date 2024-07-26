//
//  BaseViewModel.swift
//  FitMatch-Basit
//
//  Created by basit ch on 7/24/24.
//

import Foundation

// Base ViewModel class for managing common functionalities
class BaseViewModel: NSObject, ObservableObject {
    
    @Published var isPresentAlert = false
    @Published var alertTitle = ""
    @Published var isLoading = false

    // Function to show an alert with an error object
    func showAlert(error: Error) {
        DispatchQueue.main.async {
            self.isPresentAlert = true
            self.alertTitle = error.localizedDescription
        }
        debugPrint(error)
    }
    
    // Function to show an alert with an error message
    func showAlert(error: String) {
        DispatchQueue.main.async {
            self.isLoading = false
            self.isPresentAlert = true
            self.alertTitle = error
        }
        debugPrint(error)
    }
    
    // Function to hide the alert
    func hideAlert() {
        DispatchQueue.main.async {
            self.isPresentAlert = false
            self.alertTitle = ""
        }
    }
}
