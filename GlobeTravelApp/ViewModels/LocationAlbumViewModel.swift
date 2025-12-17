//
//  LocationAlbumViewModel.swift
//  GlobeTravelApp
//
//  Created on December 17, 2025
//

import Foundation
import SwiftUI
import PhotosUI
import Combine

@MainActor
class LocationAlbumViewModel: ObservableObject {
    @Published var photos: [TravelPhoto] = []
    
    func loadPhotos(from items: [PhotosPickerItem], for location: Location) async {
        for item in items {
            if let data = try? await item.loadTransferable(type: Data.self) {
                let photo = TravelPhoto(locationId: location.id, imageData: data)
                // Already on MainActor, no need for MainActor.run
                photos.append(photo)
                // TODO: Save to persistent storage
            }
        }
    }
    
    func loadPhotosForLocation(_ locationId: String) {
        // TODO: Load photos from CoreData or file system
    }
}
