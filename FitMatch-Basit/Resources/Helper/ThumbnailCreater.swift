//
//  ThumbnailCreater.swift
//  FitMatch-Basit
//
//  Created by basit ch on 7/24/24.
//

import SwiftUI
import QuickLookThumbnailing

// View representing a thumbnail for a USDZ file
struct ThumbnailView: View {
    let usdzFileName: String 
    
    var body: some View {
        if let image = generateThumbnail(for: usdzFileName) {
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
        } else {
            // Display a placeholder image if the thumbnail generation fails
            ZStack {
                Image(systemName: "square.slash")
                    .scaledToFit()
                    .frame(width: 100, height: 100)
            }
        }
    }
    
    // Function to generate a thumbnail for a USDZ file
    func generateThumbnail(for filename: String) -> UIImage? {
        guard let url = Bundle.main.url(forResource: filename, withExtension: nil) else { return nil }
        let size = CGSize(width: 100, height: 100)
        let scale = UIScreen.main.scale
        
        let options = QLThumbnailGenerator.Request(fileAt: url, size: size, scale: scale, representationTypes: .thumbnail)
        
        var thumbnail: UIImage?
        let semaphore = DispatchSemaphore(value: 0)
        
        QLThumbnailGenerator.shared.generateBestRepresentation(for: options) { (thumbnailRepresentation, error) in
            if let thumbnailRepresentation = thumbnailRepresentation {
                thumbnail = thumbnailRepresentation.uiImage
            }
            semaphore.signal()
        }
        
        semaphore.wait()
        return thumbnail
    }
}
