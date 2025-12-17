//
//  GlobeViewModel.swift
//  GlobeTravelApp
//
//  Created on December 17, 2025
//

import Foundation
import Combine

class GlobeViewModel: ObservableObject {
    @Published var selectedLocation: Location?
    @Published var visitedLocations: [Location] = []
    
    init() {
        // Load visited locations from storage
        loadVisitedLocations()
    }
    
    func selectLocation(_ location: Location) {
        selectedLocation = location
    }
    
    func addVisitedLocation(_ location: Location) {
        if !visitedLocations.contains(where: { $0.id == location.id }) {
            visitedLocations.append(location)
            saveVisitedLocations()
        }
    }
    
    private func loadVisitedLocations() {
        // TODO: Load from UserDefaults or CoreData
        // For now, start with empty array
    }
    
    private func saveVisitedLocations() {
        // TODO: Save to UserDefaults or CoreData
    }
}
