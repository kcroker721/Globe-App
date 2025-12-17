//
//  GlobeView.swift
//  GlobeTravelApp
//
//  Created on December 17, 2025
//

import SwiftUI
import SceneKit

struct GlobeView: UIViewRepresentable {
    @ObservedObject var viewModel: GlobeViewModel
    
    func makeUIView(context: Context) -> SCNView {
        let scnView = SCNView()
        scnView.scene = createGlobeScene()
        scnView.allowsCameraControl = true
        scnView.autoenablesDefaultLighting = true
        scnView.backgroundColor = .black
        
        // Add tap gesture recognizer
        let tapGesture = UITapGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.handleTap(_:)))
        scnView.addGestureRecognizer(tapGesture)
        
        return scnView
    }
    
    func updateUIView(_ uiView: SCNView, context: Context) {
        // Update scene based on viewModel changes
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(viewModel: viewModel)
    }
    
    private func createGlobeScene() -> SCNScene {
        let scene = SCNScene()
        
        // Create the globe (Earth sphere)
        let globe = SCNSphere(radius: 1.0)
        
        // Add Earth texture (placeholder - you'll need to add actual texture)
        let material = SCNMaterial()
        material.diffuse.contents = UIColor.systemBlue
        material.specular.contents = UIColor.white
        globe.materials = [material]
        
        let globeNode = SCNNode(geometry: globe)
        scene.rootNode.addChildNode(globeNode)
        
        // Add rotation animation
        let rotation = SCNAction.rotateBy(x: 0, y: CGFloat.pi * 2, z: 0, duration: 60)
        let repeatRotation = SCNAction.repeatForever(rotation)
        globeNode.runAction(repeatRotation)
        
        // Add camera
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 3)
        scene.rootNode.addChildNode(cameraNode)
        
        // Add light
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light?.type = .omni
        lightNode.position = SCNVector3(x: 0, y: 10, z: 10)
        scene.rootNode.addChildNode(lightNode)
        
        // Add ambient light
        let ambientLightNode = SCNNode()
        ambientLightNode.light = SCNLight()
        ambientLightNode.light?.type = .ambient
        ambientLightNode.light?.color = UIColor.darkGray
        scene.rootNode.addChildNode(ambientLightNode)
        
        return scene
    }
    
    class Coordinator: NSObject {
        var viewModel: GlobeViewModel
        
        init(viewModel: GlobeViewModel) {
            self.viewModel = viewModel
        }
        
        @objc func handleTap(_ gestureRecognizer: UITapGestureRecognizer) {
            guard let scnView = gestureRecognizer.view as? SCNView else { return }
            let location = gestureRecognizer.location(in: scnView)
            
            let hitResults = scnView.hitTest(location, options: [:])
            if let hit = hitResults.first {
                // Handle location selection
                // This is where you'll detect which country/state was tapped
                print("Tapped globe at: \(hit.worldCoordinates)")
            }
        }
    }
}
