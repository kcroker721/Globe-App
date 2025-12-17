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
        scnView.autoenablesDefaultLighting = false // We're using custom lighting
        
        // Clean background like Globle - soft gradient or solid color
        scnView.backgroundColor = UIColor(red: 0.95, green: 0.96, blue: 0.98, alpha: 1.0)
        
        // Better rendering quality
        scnView.antialiasingMode = .multisampling4X
        
        // Add tap gesture recognizer for selecting countries
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
        
        // Create the globe (Earth sphere) - similar to Globle game
        let globe = SCNSphere(radius: 1.0)
        globe.segmentCount = 100 // Higher segments for smoother appearance
        
        // Create material with simple, clean look like Globle
        let material = SCNMaterial()
        
        // Base color - ocean blue like Globle
        material.diffuse.contents = UIColor(red: 0.35, green: 0.55, blue: 0.75, alpha: 1.0)
        
        // Specular for slight shininess
        material.specular.contents = UIColor(white: 0.2, alpha: 1.0)
        material.shininess = 0.1
        
        // For a more realistic look, uncomment this when you add texture:
        // material.diffuse.contents = UIImage(named: "earth_texture")
        
        globe.materials = [material]
        
        let globeNode = SCNNode(geometry: globe)
        globeNode.name = "globe"
        scene.rootNode.addChildNode(globeNode)
        
        // Slow, gentle rotation like Globle (slower = more elegant)
        let rotation = SCNAction.rotateBy(x: 0, y: CGFloat.pi * 2, z: 0, duration: 120) // 2 minutes per rotation
        let repeatRotation = SCNAction.repeatForever(rotation)
        globeNode.runAction(repeatRotation)
        
        // Add camera with better positioning
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.camera?.fieldOfView = 60 // Wider field of view
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 2.5) // Closer for better view
        scene.rootNode.addChildNode(cameraNode)
        
        // Main directional light (simulates sun) - positioned like Globle
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light?.type = .directional
        lightNode.light?.color = UIColor.white
        lightNode.light?.intensity = 1000
        lightNode.eulerAngles = SCNVector3(x: -.pi / 3, y: .pi / 4, z: 0)
        scene.rootNode.addChildNode(lightNode)
        
        // Ambient light for overall illumination (not too dark)
        let ambientLightNode = SCNNode()
        ambientLightNode.light = SCNLight()
        ambientLightNode.light?.type = .ambient
        ambientLightNode.light?.color = UIColor(white: 0.4, alpha: 1.0) // Brighter ambient
        scene.rootNode.addChildNode(ambientLightNode)
        
        // Add subtle fill light from opposite side
        let fillLightNode = SCNNode()
        fillLightNode.light = SCNLight()
        fillLightNode.light?.type = .directional
        fillLightNode.light?.color = UIColor(white: 0.3, alpha: 1.0)
        fillLightNode.light?.intensity = 300
        fillLightNode.eulerAngles = SCNVector3(x: .pi / 6, y: -.pi / 2, z: 0)
        scene.rootNode.addChildNode(fillLightNode)
        
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
