# Globe Travel App - Resources

This folder should contain:

## Earth Texture
- `earth_texture.jpg` - High resolution Earth day texture
- `earth_specular.jpg` - Specular map for realistic lighting
- `earth_normal.jpg` - Normal map for surface detail

You can download free Earth textures from:
- [Solar System Scope](https://www.solarsystemscope.com/textures/)
- [NASA Visible Earth](https://visibleearth.nasa.gov/)

## GeoJSON Border Data

### Countries
- `countries.geojson` - World country borders
- Download from: [Natural Earth Data](https://www.naturalearthdata.com/downloads/110m-cultural-vectors/)

### US States
- `us-states.geojson` - US state borders  
- Download from: [US Census Bureau](https://www.census.gov/geographies/mapping-files.html)

## Installation

1. Download the required files from the links above
2. Add them to this Resources folder
3. In Xcode, add them to your project target
4. Update `GeoJSONLoader.swift` to load these files

## File Formats

- Textures: JPG or PNG (2048x1024 or higher)
- GeoJSON: Standard GeoJSON format with polygon coordinates
