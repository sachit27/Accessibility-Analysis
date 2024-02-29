# Accessibility of Green Recreational Spaces in Cities

This GitHub repository contains code and resources used in the research on the [accessibility of green recreational spaces in urban environments](https://ieeexplore.ieee.org/abstract/document/10214011). Utilizing Python and R, the repository contains functionalities for generating density maps, performing spatial point pattern analysis, and calculating walking time to the nearest green spaces.

<div align="center">
  <img src="/images/wf.png"/>
</div>


# Abstract
As our world becomes increasingly urbanized, smart cities are leading the way in using technology to create more efficient, connected, and sustainable environments. However, amidst all the talk of connectivity and smartness, it's crucial not to lose sight of one of the most basic human needs: access to nature in cities. This research describes a novel open-source framework for investigating the availability and accessibility of green recreation spaces using open-source data and statistical analytic approaches. The framework includes a comprehensive set of tools for data extraction, processing, analysis, and visualization, thereby enabling reproducible geospatial research. We test our framework on five international cities: Medellin, Milan, Chicago, Singapore, and Mumbai. Through geospatial analysis and statistical modeling of data sourced from OpenStreetMaps, we explore and comprehend the characteristics and distribution of spatial accessibility related to green recreation spaces in five cities. We find significant clustering of green recreation spaces in all these cities, indicating that a majority of such spaces are located in close proximity to each other within small areas. Our findings also shed light on the potential implications of unequal distribution of green recreation spaces for the health and well-being of city residents and highlight the need for policies and initiatives that promote equitable access to green recreation spaces in smart cities.

# Prerequisites
## Software Requirements
- Python 3.11.2
- R (Version 4.3.1)

## Libraries
- Python: branca, folium, geopandas, networkx, osmnx, pandas
- R: ggplot2, ggmap, osmdata, sp, spatstat, dplyr, spdep, tidyverse, spNetwork

# Usage

## Density Maps of Amenities (densitymaps.R)

This code generates a density map of amenities in a city.

### How to Run
- Open densitymaps.R in your R IDE.
- Make sure the data.csv file containing amenity data is in the working directory.
- Change the city name in the get_map( getbb('City'), source="stamen") line.
- Run the script.

## Spatial Point Pattern Analysis (point_pattern.R)

Performs a spatial point pattern analysis using several R libraries. It calculates nearest neighbor distances and provides a confidence interval.

### How to Run
- Open point_pattern.R in your R IDE.
- Make sure data.csv containing spatial data is in the working directory.
- Run the script.

## Accessibility Maps (accessibility.py)  

Uses OpenStreetMap data to calculate the walking time to the nearest green recreational space in a city. It outputs a heatmap map and prints the average and longest walking times to the console.

<div align="center">
  <img src="/images/hm.png"/>
</div>


### How to Run

- Open accessibility.py in your Python IDE.
- To change the city, update the line G = ox.graph_from_place("Madrid, Spain", network_type="walk", buffer_dist = 500).
- Run the script.

### Code Structure
- accessibility.py: For generating accessibility maps.
- densitymaps.R: For creating density maps of amenities.
- point_pattern.R: For spatial point pattern analysis.
- data.csv: CSV file containing amenity data for the densitymaps.R and point_pattern.R scripts.

### Citation

For citing this research, please use:

[J. Martinez and S. Mahajan, "Smart Cities and Access to Nature: A Framework for Evaluating Green Recreation Space Accessibility," in IEEE Access, vol. 11, pp. 102014-102024, 2023, doi: 10.1109/ACCESS.2023.3303571.](https://ieeexplore.ieee.org/abstract/document/10214011)

