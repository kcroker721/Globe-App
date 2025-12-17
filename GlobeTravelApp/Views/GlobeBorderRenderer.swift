//
//  GlobeBorderRenderer.swift
//  GlobeTravelApp
//
//  Created on December 17, 2025
//

import SceneKit
import CoreLocation

class GlobeBorderRenderer {
    
    /// Add country/state borders to the globe
    static func addBorders(to globeNode: SCNNode, locations: [Location]) {
        for location in locations {
            let borderNode = createBorderNode(for: location)
            globeNode.addChildNode(borderNode)
        }
    }
    
    /// Create a border node for a specific location
    private static func createBorderNode(for location: Location) -> SCNNode {
        let borderNode = SCNNode()
        borderNode.name = "border_\(location.id)"
        
        // Convert coordinate rings to 3D paths on sphere
        for ring in location.coordinates {
            let vertices = ring.map { coordinate in
                convertCoordinateToSphere(
                    latitude: coordinate.latitude,
                    longitude: coordinate.longitude,
                    radius: 1.002 // Slightly larger than globe radius
                )
            }
            
            if vertices.count > 1 {
                // Create line geometry for the border
                let lineNode = createLineNode(from: vertices)
                borderNode.addChildNode(lineNode)
            }
        }
        
        return borderNode
    }
    
    /// Create a line node from vertices
    private static func createLineNode(from vertices: [SCNVector3]) -> SCNNode {
        var indices: [Int32] = []
        for i in 0..<(vertices.count - 1) {
            indices.append(Int32(i))
            indices.append(Int32(i + 1))
        }
        // Close the loop
        indices.append(Int32(vertices.count - 1))
        indices.append(0)
        
        let vertexSource = SCNGeometrySource(vertices: vertices)
        let indexData = Data(bytes: indices, count: indices.count * MemoryLayout<Int32>.size)
        let element = SCNGeometryElement(
            data: indexData,
            primitiveType: .line,
            primitiveCount: indices.count / 2,
            bytesPerIndex: MemoryLayout<Int32>.size
        )
        
        let geometry = SCNGeometry(sources: [vertexSource], elements: [element])
        
        // Style the border lines - subtle like Globle
        let material = SCNMaterial()
        material.diffuse.contents = UIColor(white: 0.3, alpha: 0.4) // Subtle gray
        material.lightingModel = .constant
        geometry.materials = [material]
        
        return SCNNode(geometry: geometry)
    }
    
    /// Convert lat/long to 3D coordinates on a sphere
    static func convertCoordinateToSphere(latitude: Double, longitude: Double, radius: Double = 1.0) -> SCNVector3 {
        // Convert degrees to radians
        let latRad = latitude * .pi / 180.0
        let lonRad = longitude * .pi / 180.0
        
        // Spherical to Cartesian conversion
        let x = radius * cos(latRad) * cos(lonRad)
        let y = radius * sin(latRad)
        let z = radius * cos(latRad) * sin(lonRad)
        
        return SCNVector3(x: Float(x), y: Float(y), z: Float(z))
    }
    
    /// Highlight a country when visited (change color like Globle does)
    static func highlightLocation(_ locationId: String, in scene: SCNScene, color: UIColor) {
        guard let borderNode = scene.rootNode.childNode(withName: "border_\(locationId)", recursively: true) else {
            return
        }
        
        // Change border color to show it's visited
        borderNode.enumerateChildNodes { node, _ in
            if let geometry = node.geometry {
                let material = SCNMaterial()
                material.diffuse.contents = color
                material.lightingModel = .constant
                geometry.materials = [material]
            }
        }
    }
    
    /// Create a filled country shape on the globe (for visited countries)
    static func fillLocation(_ location: Location, in globeNode: SCNNode, color: UIColor) {
        // TODO: Create a filled polygon geometry from coordinates
        // This would show the country as filled when visited
        // Similar to how Globle colors countries
    }
}
