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
                // Clean background like Globle
                Color(red: 0.95, green: 0.96, blue: 0.98)
                    .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    // Top bar with title
                    HStack {
                        Text("TRAVEL GLOBE")
                            .font(.system(size: 24, weight: .bold, design: .rounded))
                            .foregroundColor(.primary)
                        Spacer()
                        Button(action: {
                            // Settings action
                        }) {
                            Image(systemName: "gearshape")
                                .font(.system(size: 20))
                                .foregroundColor(.secondary)
                        }
                    }
                    .padding()
                    .background(.ultraThinMaterial)
                    
                    // Globe view - main focus like Globle
                    GlobeView(viewModel: viewModel)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    
                    // Bottom info bar
                    VStack(spacing: 8) {
                        if let selectedLocation = viewModel.selectedLocation {
                            Text(selectedLocation.name)
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(.primary)
                            
                            Button(action: {
                                // This will open the photo album
                            }) {
                                Text("View Photos")
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 24)
                                    .padding(.vertical, 12)
                                    .background(Color.blue)
                                    .cornerRadius(25)
                            }
                        } else {
                            Text("Tap a country or state to add photos")
                                .font(.system(size: 16))
                                .foregroundColor(.secondary)
                        }
                    }
                    .frame(height: 100)
                    .frame(maxWidth: .infinity)
                    .background(.ultraThinMaterial)
                }
            }
            .navigationBarHidden(true)
            .sheet(item: $viewModel.selectedLocation) { location in
                LocationAlbumView(location: location)
            }
        }
    }
}

#Preview {
    ContentView()
}
