//
//  GeoJSONLoader.swift
//  GlobeTravelApp
//
//  Created on December 17, 2025
//

import Foundation
import CoreLocation

class GeoJSONLoader {
    
    /// Load country borders from GeoJSON file
    static func loadCountryBorders() -> [Location] {
        guard let url = Bundle.main.url(forResource: "countries", withExtension: "geojson"),
              let data = try? Data(contentsOf: url) else {
            print("Could not load countries.geojson")
            return []
        }
        return parseGeoJSON(data: data, type: .country)
    }
    
    /// Load US state borders from GeoJSON file
    static func loadUSStateBorders() -> [Location] {
        guard let url = Bundle.main.url(forResource: "us-states", withExtension: "geojson"),
              let data = try? Data(contentsOf: url) else {
            print("Could not load us-states.geojson")
            return []
        }
        return parseGeoJSON(data: data, type: .usState)
    }
    
    /// Parse GeoJSON and convert to Location objects
    static func parseGeoJSON(data: Data, type: LocationType) -> [Location] {
        // TODO: Implement full GeoJSON parsing
        // For now, return empty array until GeoJSON file is added
        // This will parse the GeoJSON and extract coordinates for each country/state
        
        do {
            if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
               let features = json["features"] as? [[String: Any]] {
                
                var locations: [Location] = []
                
                for feature in features {
                    // Extract properties
                    guard let properties = feature["properties"] as? [String: Any],
                          let name = properties["name"] as? String ?? properties["NAME"] as? String else {
                        continue
                    }
                    
                    // Use appropriate ID field based on type
                    let id = properties["iso_a2"] as? String ?? 
                            properties["ISO_A2"] as? String ??
                            properties["STUSPS"] as? String ?? // US state abbreviation
                            name.replacingOccurrences(of: " ", with: "_")
                    
                    // Extract geometry coordinates
                    guard let geometry = feature["geometry"] as? [String: Any],
                          let coordinates = geometry["coordinates"] as? [Any] else {
                        continue
                    }
                    
                    let coordRings = extractCoordinateRings(from: coordinates)
                    
                    let location = Location(
                        id: id,
                        name: name,
                        type: type,
                        coordinates: coordRings
                    )
                    locations.append(location)
                }
                
                return locations
            }
        } catch {
            print("Error parsing GeoJSON: \(error)")
        }
        
        return []
    }
    
    /// Helper to extract coordinate rings from GeoJSON coordinates
    private static func extractCoordinateRings(from coordinates: [Any]) -> [[CoordinatePair]] {
        var rings: [[CoordinatePair]] = []
        
        // Handle different geometry types (Polygon, MultiPolygon)
        func parseRing(_ ring: [Any]) -> [CoordinatePair] {
            var coords: [CoordinatePair] = []
            for point in ring {
                if let pair = point as? [Double], pair.count >= 2 {
                    coords.append(CoordinatePair(latitude: pair[1], longitude: pair[0]))
                }
            }
            return coords
        }
        
        for item in coordinates {
            if let ring = item as? [Any] {
                // Check if it's a ring of coordinates or another level of nesting
                if let firstItem = ring.first as? [Double] {
                    // It's a coordinate ring
                    rings.append(parseRing(ring))
                } else if let firstItem = ring.first as? [Any] {
                    // It's nested (MultiPolygon)
                    for subRing in ring {
                        if let subArray = subRing as? [Any] {
                            rings.append(parseRing(subArray))
                        }
                    }
                }
            }
        }
        
        return rings
    }
}
