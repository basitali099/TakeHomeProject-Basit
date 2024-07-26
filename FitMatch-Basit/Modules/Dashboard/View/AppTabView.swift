//
//  AppTabView.swift
//  FitMatch-Basit
//
//  Created by basit ch on 7/24/24.
//

import SwiftUI

// View representing the main tab view of the application
struct AppTabView: View {
    @State var selectedTab: TabSection = .sceneKit
    @StateObject var viewModel = DetailViewModel() 
    
    var body: some View {
        TabView {
            // SceneKit gallery view
            SKGalleryView(viewModel: viewModel)
                .id(TabSection.sceneKit)
                .tag(TabSection.sceneKit)
                .tabItem {
                    Image(systemName: "square.stack.3d.down.right")
                    Text("Scenekit")
                }
            // ARKit gallery view
            GalleryView(viewModel: viewModel)
                .id(TabSection.arKit)
                .tag(TabSection.arKit)
                .tabItem {
                    Image(systemName: "square.stack.3d.down.right")
                    Text("ARKit")
                }
        }
        .tint(.white)
    }
}
