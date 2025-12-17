//
//  Location.swift
//  GlobeTravelApp
//
//  Created on December 17, 2025
//

import Foundation
import CoreLocation

enum LocationType {
    case country
    case usState
}

struct Location: Identifiable, Codable, Hashable {
    let id: String // Country code or state abbreviation
    let name: String
    let type: LocationType
    let coordinates: [[CLLocationCoordinate2D]] // GeoJSON polygon coordinates
    
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
    
    init(id: String, name: String, type: LocationType, coordinates: [[CLLocationCoordinate2D]]) {
        self.id = id
        self.name = name
        self.type = type
        self.coordinates = coordinates
    }
}

extension LocationType: Codable {}
extension CLLocationCoordinate2D: Codable {
    enum CodingKeys: String, CodingKey {
        case latitude, longitude
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(latitude, forKey: .latitude)
        try container.encode(longitude, forKey: .longitude)
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let latitude = try container.decode(Double.self, forKey: .latitude)
        let longitude = try container.decode(Double.self, forKey: .longitude)
        self.init(latitude: latitude, longitude: longitude)
    }
}
