//
//  SKGalleryView.swift
//  FitMatch-Basit
//
//  Created by basit ch on 7/24/24.
//

import SwiftUI
import SceneKit

// View representing the SceneKit gallery
struct SKGalleryView: View {
    @ObservedObject var viewModel: DetailViewModel
    
    // Columns for the grid layout
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                // LazyVGrid for displaying items in a grid
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(viewModel.items, id: \.id) { item in
                        NavigationLink {
                            SKDetailView(item: item)
                                .aspectRatio(1.0, contentMode: .fit)
                        } label: {
                            SKCardView(item: item)
                                .aspectRatio(1.0, contentMode: .fit)
                        }
                    }
                }
                .padding(16)
            }
            .background(
                BackgroundGradientView()
                    .edgesIgnoringSafeArea(.all)
            )
            .navigationTitle("SceneKit Gallery")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    SignOutButton()
                }
            }
        }
    }
}

// View representing a card for an item in the SceneKit gallery
struct SKCardView: View {
    var item: DetailModel
    
    var body: some View {
        ZStack {
            Color.white.cornerRadius(8).shadow(radius: 3)
            let scene = try? SCNScene(url: item.url!)
            // Scene view for displaying the 3D model
            SceneView(scene: scene, options: [.autoenablesDefaultLighting, .allowsCameraControl])
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.gray.opacity(0.3))
                .cornerRadius(8)
                .padding(4)
        }
        .overlay {
            VStack {
                Spacer()
                Text(item.name)
                    .font(.body)
                    .foregroundStyle(.black)
                    .frame(maxWidth: .infinity)
                    .background(BackgroundGradientView())
            }
        }
    }
}
