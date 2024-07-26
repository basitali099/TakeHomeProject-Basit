//
//  ARDetailView.swift
//  FitMatch-Basit
//
//  Created by basit ch on 7/24/24.
//

import SwiftUI
import RealityKit
import ARKit

// View representing the detail view of a selected item
struct DetailView: View {
    let item: DetailModel 
    
    var body: some View {
        ZStack {
            // AR view container for displaying the 3D model
            ARViewContainer(usdzFileName: item.filenameWithExt)
                .edgesIgnoringSafeArea(.all)
        }
        .background(
            BackgroundGradientView()
                .edgesIgnoringSafeArea(.all)
        )
        .navigationTitle(item.name)
    }
}

// View representing the AR view container
struct ARViewContainer: UIViewRepresentable {
    let usdzFileName: String
    
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)
        context.coordinator.setupGestures(for: arView) // Setup gestures for AR interaction
        loadModel(named: usdzFileName, into: arView, context: context) // Load the 3D model into the AR view
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    // Function to load the 3D model into the AR view
    private func loadModel(named usdzFileName: String, into arView: ARView, context: Context) {
        guard let url = Bundle.main.url(forResource: usdzFileName, withExtension: nil) else {
            print("Failed to load \(usdzFileName)")
            return
        }
        
        do {
            let entity = try Entity.load(contentsOf: url)
            let anchor = AnchorEntity()
            anchor.addChild(entity)
            arView.scene.anchors.append(anchor)
            context.coordinator.modelEntity = entity
        } catch {
            print("Error loading USDZ file: \(error.localizedDescription)")
        }
        
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = [.horizontal, .vertical]
        configuration.environmentTexturing = .automatic
        arView.session.run(configuration)
    }
    
    // Coordinator class to handle AR interactions
    class Coordinator: NSObject {
        var modelEntity: Entity?
        var lastScale: CGFloat = 1.0
        var lastTranslation: CGPoint = .zero
        
        // Setup gestures for the AR view
        func setupGestures(for arView: ARView) {
            let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(handlePinch(_:)))
            let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
            
            arView.addGestureRecognizer(pinchGesture)
            arView.addGestureRecognizer(panGesture)
        }
        
        // Handle pinch gesture for scaling the 3D model
        @objc func handlePinch(_ gesture: UIPinchGestureRecognizer) {
            guard let entity = modelEntity else { return }
            let scale = gesture.scale
            
            switch gesture.state {
            case .began, .changed:
                entity.scale *= SIMD3<Float>(repeating: Float(scale / lastScale))
                lastScale = scale
            case .ended:
                lastScale = 1.0
            default:
                break
            }
        }
        
        // Handle pan gesture for translating the 3D model
        @objc func handlePan(_ gesture: UIPanGestureRecognizer) {
            guard let entity = modelEntity else { return }
            let translation = gesture.translation(in: gesture.view)
            
            switch gesture.state {
            case .began, .changed:
                let delta = SIMD3<Float>(Float(translation.x - lastTranslation.x) / 1000, 0, Float(translation.y - lastTranslation.y) / 1000)
                entity.position += delta
                lastTranslation = translation
            case .ended:
                lastTranslation = .zero
            default:
                break
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(item: DetailModel(name: "Item 1", fileName: "robot.usdz"))
    }
}
