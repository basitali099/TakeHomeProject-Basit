//
//  DetailViewModel.swift
//  FitMatch-Basit
//
//  Created by basit ch on 7/26/24.
//

import SwiftUI

// ViewModel for handling the details of items
class DetailViewModel: BaseViewModel {
    @Published var items: [DetailModel] = []
    
    override init() {
        super.init()
        populateModel() 
    }
}

// Extension for DetailViewModel containing the function to populate the model
extension DetailViewModel {
    
    // Function to populate the model with predefined items
    func populateModel() {
        items = [
            DetailModel(name: "Robot", fileName: "robot"),
            DetailModel(name: "TV", fileName: "tv_retro"),
            DetailModel(name: "Shoes", fileName: "sneaker_airforce"),
            DetailModel(name: "Teapot", fileName: "teapot"),
            DetailModel(name: "Cup", fileName: "cup_saucer_set"),
            DetailModel(name: "Fender", fileName: "fender_stratocaster")
        ]
    }
}
