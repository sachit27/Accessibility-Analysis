# Accessibility-Analysis

## Density maps of amenities

This code generates a density map of amenities in a city using the R programming language and several libraries, including ggplot2, ggmap, osmdata, sp, spatstat, dplyr, spdep, tidyverse, and spNetwork.

The data used in this analysis is stored in a CSV file named "data.csv". This data can be downloaded using the Python workflow. Before generating the map, the code first loads the necessary libraries and reads the CSV file using the read.csv function. The distinct function is used to remove any duplicate entries in the data based on their longitude and latitude coordinates.

Next, the get_map function is used to retrieve a map of the specified city using the Stamen source. You can change the name of the city by updating the argument in getbb function.

Finally, the stat_density2d function is used to generate the density map, which is plotted using the ggmap function. The scale_fill_viridis_c function is used to add a color scale to the legend, and the theme function is used to customize the legend position and text size.

To use this code, simply replace the name of the data file and the city name to generate a density map of amenities in the desired location.

## Spatial Point pattern analysis

This code performs spatial point pattern analysis using several R libraries including sp, rgeos, spdep, spatstat, and rgdal. The code reads in a csv file containing spatial data and converts it to a spatial points data frame. It then performs point pattern analysis and plots the results. The code also creates a neighbor list object, converts the neighbor list to a listw object, and calculates the nearest neighbor distances for 1000 simulated point patterns. Finally, the code calculates quantiles for each bin in the histogram and adds a polygon for the confidence interval.

Dependencies: sp, rgeos, spdep, spatstat, rgdal

Usage
1. Load the required libraries
2. Read in the data from a csv file
3. Convert the data to a spatial points data frame
4. Perform point pattern analysis and plot the results
5. Create a neighbor list object
6. Convert the neighbor list to a listw object
7. Calculate the nearest neighbor distances for 1000 simulated point patterns
8. Calculate quantiles for each bin in the histogram
9. Add a polygon for the confidence interval
