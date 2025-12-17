//
//  TravelPhoto.swift
//  GlobeTravelApp
//
//  Created on December 17, 2025
//

import Foundation
import UIKit

struct TravelPhoto: Identifiable, Codable {
    let id: UUID
    let locationId: String
    let imageData: Data
    let dateTaken: Date
    let latitude: Double?
    let longitude: Double?
    
    var image: UIImage? {
        UIImage(data: imageData)
    }
    
    init(id: UUID = UUID(), locationId: String, imageData: Data, dateTaken: Date = Date(), latitude: Double? = nil, longitude: Double? = nil) {
        self.id = id
        self.locationId = locationId
        self.imageData = imageData
        self.dateTaken = dateTaken
        self.latitude = latitude
        self.longitude = longitude
    }
}
