//
//  SKDetailView.swift
//  FitMatch-Basit
//
//  Created by basit ch on 7/24/24.
//

import SwiftUI
import SceneKit

// View representing the detail view for a SceneKit item
struct SKDetailView: View {
    @EnvironmentObject var signInViewModel: SignInViewModel 
    var item: DetailModel
    
    var body: some View {
        ZStack {
            BackgroundGradientView()
            if let url = item.url, let scene = try? SCNScene(url: url) {
                SceneView(scene: scene, options: [.autoenablesDefaultLighting, .allowsCameraControl, .rendersContinuously]) // Scene view for displaying the 3D model
                    .background(Color.gray.opacity(0.3))
                    .cornerRadius(10)
                    .padding()
                    .navigationTitle(item.name)
            } else {
                Text("Unable to load model")
            }
        }
    }
}
