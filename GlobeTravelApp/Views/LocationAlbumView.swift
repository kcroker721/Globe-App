//
//  LocationAlbumView.swift
//  GlobeTravelApp
//
//  Created on December 17, 2025
//

import SwiftUI
import PhotosUI

struct LocationAlbumView: View {
    let location: Location
    @StateObject private var viewModel = LocationAlbumViewModel()
    @State private var selectedPhotos: [PhotosPickerItem] = []
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], spacing: 10) {
                    ForEach(viewModel.photos) { photo in
                        Image(uiImage: photo.image)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 100, height: 100)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                }
                .padding()
            }
            .navigationTitle(location.name)
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    PhotosPicker(selection: $selectedPhotos, matching: .images) {
                        Image(systemName: "plus")
                    }
                }
            }
            .onChange(of: selectedPhotos) { newPhotos in
                Task {
                    await viewModel.loadPhotos(from: newPhotos, for: location)
                    selectedPhotos = []
                }
            }
        }
    }
}

#Preview {
    LocationAlbumView(location: Location(id: "US", name: "United States", type: .country, coordinates: []))
}
