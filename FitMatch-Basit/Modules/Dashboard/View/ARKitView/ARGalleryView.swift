//
//  ARGalleryVie.swift
//  FitMatch-Basit
//
//  Created by basit ch on 7/24/24.
//

import SwiftUI
import RealityKit
import ARKit

// View representing the gallery for ARKit
struct GalleryView: View {
    @ObservedObject var viewModel: DetailViewModel
    @EnvironmentObject var signInViewModel: SignInViewModel
    
    // Define columns for the grid layout
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    // LazyVGrid for displaying items in a grid
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(viewModel.items, id: \.id) { item in
                            // Navigation link to the detail view for each item
                            NavigationLink(destination: DetailView(item: item)) {
                                ItemThumbnailView(item: item) // Thumbnail view for the item
                            }
                        }
                    }
                    .padding()
                }
                // Information text for ARKit usage
                Text("ARkit won't render on simulator. \nPlease test this using a real device.")
                    .padding(.bottom, 20)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .center)
            }
            .background(BackgroundGradientView())
            .navigationTitle("ARkit Gallery")
        }
    }
}

// View representing a thumbnail for an item
struct ItemThumbnailView: View {
    let item: DetailModel
    
    var body: some View {
        ZStack {
            ThumbnailView(usdzFileName: item.filenameWithExt)
                .scaledToFit()
                .background(Color.red)
                .cornerRadius(10)
                .shadow(radius: 5)
            VStack {
                Spacer()
                Text(item.name)
                    .font(.body)
                    .frame(maxWidth: .infinity)
                    .background(BackgroundGradientView())
            }
        }
    }
}

struct GalleryView_Previews: PreviewProvider {
    static var previews: some View {
        GalleryView(viewModel: DetailViewModel())
            .environmentObject(SignInViewModel())
    }
}
