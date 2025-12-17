# Globe Travel App

A beautiful iOS app that lets you track your travels on an interactive 3D globe. Mark countries and US states you've visited by adding photos, which will fill in the shape of the location on the globe.

## Features

- 🌍 **Interactive 3D Globe** - Smoothly rotating Earth with SceneKit
- 🗺️ **Country & State Borders** - Visualize all countries and US states
- 📸 **Photo Albums** - Create albums for each location you visit
- ✂️ **Shape Masking** - Photos are masked to the shape of countries/states
- 🔍 **Zoom & Select** - Tap to select locations and view your photos
- 💾 **Persistent Storage** - Your travels are saved locally

## Project Structure

```
GlobeTravelApp/
├── Views/
│   ├── ContentView.swift          # Main app view
│   ├── GlobeView.swift             # 3D globe rendering with SceneKit
│   └── LocationAlbumView.swift     # Photo album for each location
├── Models/
│   ├── Location.swift              # Country/state data model
│   └── TravelPhoto.swift           # Photo data model
├── ViewModels/
│   ├── GlobeViewModel.swift        # Globe state management
│   └── LocationAlbumViewModel.swift # Album management
├── Utilities/
│   ├── GeoJSONLoader.swift         # Load country/state borders
│   └── ImageMaskUtility.swift      # Mask images to shapes
└── Resources/
    └── (GeoJSON files will go here)
```

## Getting Started

### Prerequisites

- **Xcode 15.0+** (for iOS 17+ support)
- **macOS Ventura or later**
- **Apple Developer Account** (for device testing)

### Setting Up in Xcode

Since this is a Swift project, you'll need to create an Xcode project:

1. **Open Xcode**
2. **Create a new project**: File → New → Project
3. Choose **iOS** → **App** template
4. Configure your project:
   - Product Name: `GlobeTravelApp`
   - Interface: `SwiftUI`
   - Language: `Swift`
   - Bundle Identifier: `com.yourname.GlobeTravelApp`
5. Save it in this directory (`globe app/`)
6. **Copy the source files** from the `GlobeTravelApp/` folder into your Xcode project

### Adding Files to Xcode

1. In Xcode, right-click on your project in the Navigator
2. Select "Add Files to GlobeTravelApp..."
3. Add each folder:
   - Views
   - Models
   - ViewModels
   - Utilities
   - Resources

### Required Capabilities

Make sure these are enabled in your Xcode project:

1. Go to **Target → Signing & Capabilities**
2. Add **Photo Library** permissions (already in Info.plist)

## Creating a GitHub Repository

To push this project to GitHub:

```bash
# Initialize git (if not already done)
cd "/Users/kcroker/globe app"
git init

# Add all files
git add .

# Commit
git commit -m "Initial commit: Globe Travel App structure"

# Create repo on GitHub (via browser or GitHub CLI)
# Then add remote and push:
git remote add origin https://github.com/yourusername/globe-travel-app.git
git branch -M main
git push -u origin main
```

Or use **GitHub CLI**:

```bash
cd "/Users/kcroker/globe app"
git init
git add .
git commit -m "Initial commit: Globe Travel App structure"
gh repo create globe-travel-app --public --source=. --remote=origin --push
```

## Next Steps - Implementation TODOs

### 1. Add Earth Texture
- Download a high-resolution Earth texture map
- Add to Resources folder
- Update `GlobeView.swift` to use the texture

### 2. GeoJSON Data
Download GeoJSON files for:
- World countries: [Natural Earth Data](https://www.naturalearthdata.com/)
- US states: [US Census Bureau](https://www.census.gov/geographies/mapping-files.html)

Add to `Resources/` folder and implement `GeoJSONLoader.swift`

### 3. Border Rendering
- Parse GeoJSON coordinates
- Convert lat/long to 3D coordinates on sphere
- Draw borders as SCNNode lines on the globe

### 4. Location Detection
- Implement tap detection to identify which country/state was tapped
- Use reverse geocoding or coordinate-in-polygon tests

### 5. Image Masking
- Implement `ImageMaskUtility.swift` to mask photos to country shapes
- Create bezier paths from GeoJSON polygons
- Apply Core Graphics masking

### 6. Persistent Storage
- Add CoreData or use UserDefaults/FileManager
- Save visited locations and photos
- Load on app launch

### 7. Photo Features
- Implement photo import from library
- Add photo metadata (date, location)
- Create thumbnail generation
- Add delete functionality

## Technologies Used

- **SwiftUI** - Modern UI framework
- **SceneKit** - 3D graphics and globe rendering
- **PhotosUI** - Photo picker integration
- **CoreLocation** - Geographic coordinates
- **Combine** - Reactive data flow

## License

This project is open source and available under the MIT License.

## Contributing

Feel free to submit issues and pull requests!

---

Built with ❤️ for travelers who want to visualize their adventures.
