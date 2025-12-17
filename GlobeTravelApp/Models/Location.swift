//
//  Location.swift
//  GlobeTravelApp
//
//  Created on December 17, 2025
//

import Foundation
import CoreLocation

enum LocationType: Codable {
    case country
    case usState
}

struct Location: Identifiable, Codable {
    let id: String // Country code or state abbreviation
    let name: String
    let type: LocationType
    let coordinates: [[CoordinatePair]] // GeoJSON polygon coordinates
    
    enum CodingKeys: String, CodingKey {
        case id, name, type
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(type, forKey: .type)
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        type = try container.decode(LocationType.self, forKey: .type)
        coordinates = []
    }
    
    init(id: String, name: String, type: LocationType, coordinates: [[CoordinatePair]]) {
        self.id = id
        self.name = name
        self.type = type
        self.coordinates = coordinates
    }
}

// Custom coordinate type that's Codable and Hashable
struct CoordinatePair: Codable, Hashable {
    let latitude: Double
    let longitude: Double
    
    var clCoordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
    
    init(from coordinate: CLLocationCoordinate2D) {
        self.latitude = coordinate.latitude
        self.longitude = coordinate.longitude
    }
}
