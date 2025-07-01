# Orbital Mechanics and Ground Track Visualization Project

## Description

This MATLAB project simulates satellite orbits and visualizes their ground tracks on Earth. It includes tools for:
- Converting between Earth-Centered, Earth-Fixed (ECEF) and geodetic coordinates
- Solving Kepler's equation for orbital mechanics calculations
- Transforming between different reference frames
- Visualizing 3D orbits around Earth
- Plotting ground tracks on a 2D map

The project demonstrates fundamental concepts in astrodynamics and satellite tracking, providing both numerical calculations and graphical outputs.

## Key Features

- **ECEF to Geodetic Conversion**: `ECEF2geodetic.m` converts Cartesian coordinates to latitude, longitude, and height
- **Kepler's Equation Solver**: `kepler_E.m` implements an iterative solution for eccentric anomaly
- **Orbit Simulation**: `project_test.m` simulates a satellite orbit with configurable parameters
- **3D Visualization**: Includes Earth sphere with topography and 3D orbit plotting
- **Ground Track Visualization**: Plots the satellite's path over Earth's surface
- **Reference Frame Transformations**: Handles conversions between orbital and Earth-fixed frames

## Getting Started

### Prerequisites

- MATLAB (tested on R2016b and later)
- Image Processing Toolbox (for ground track background image)

### Installation

1. Clone this repository or download the files
2. Add all files to your MATLAB path
3. Run `project_test.m` to see the demonstration

## Usage

The main demonstration can be run by executing `project_test.m`. This script:

1. Sets up orbital parameters (semi-major axis, eccentricity, inclination, etc.)
2. Simulates the orbit over 3 complete revolutions
3. Generates three figures:
   - 2D plot of the orbit in the orbital plane
   - 3D visualization of the orbit around Earth
   - Ground track on a world map

You can modify the initial parameters in `project_test.m` to simulate different orbits.

## File Descriptions

- `ECEF2geodetic.m`: Converts ECEF coordinates to geodetic coordinates
- `kepler_E.m`: Solves Kepler's equation for eccentric anomaly
- `transformation.m`: Creates transformation matrices between reference frames
- `earth_sphere.m`: Generates an Earth-sized sphere with topography (from MathWorks)
- `project_test.m`: Main demonstration script
- `playing_with_earth_fun.m`: Simple example of Earth sphere visualization
- `test.m`: Simple test script (not core functionality)
- `ChatGPT.m`: Experimental orbital calculation script (not used in main demo)
- `license.txt`: Software license

## Customization

To simulate different orbits, modify these parameters in `project_test.m`:
- `a`: Semi-major axis (meters)
- `e`: Eccentricity (0 for circular orbits)
- `i`: Inclination (radians)
- `w`: Argument of perigee (radians)
- `raan`: Right ascension of ascending node (radians)
- `nu_0`: Initial true anomaly (radians)
- `n_orbits`: Number of orbits to simulate

## License

This project includes code from MathWorks under the license terms in `license.txt`. Other code is available for use under similar terms.

## Acknowledgments

- Uses `earth_sphere.m` from MathWorks for Earth visualization
- Inspired by fundamental astrodynamics principles and equations

## Future Work

Potential enhancements:
- Add TLE parsing for real satellite data
- Implement more sophisticated perturbation models
- Create interactive parameter controls
- Add velocity vector visualization
- Extend to multi-satellite constellations
