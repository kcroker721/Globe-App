//
//  ContentView.swift
//  GlobeTravelApp
//
//  Created on December 17, 2025
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = GlobeViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                // Globe view will go here
                GlobeView(viewModel: viewModel)
                
                VStack {
                    Spacer()
                    
                    // Status bar at bottom
                    if let selectedLocation = viewModel.selectedLocation {
                        Text(selectedLocation.name)
                            .font(.headline)
                            .padding()
                            .background(.ultraThinMaterial)
                            .cornerRadius(10)
                            .padding()
                    }
                }
            }
            .navigationTitle("Travel Globe")
            .navigationBarTitleDisplayMode(.inline)
            .sheet(item: $viewModel.selectedLocation) { location in
                LocationAlbumView(location: location)
            }
        }
    }
}

#Preview {
    ContentView()
}
