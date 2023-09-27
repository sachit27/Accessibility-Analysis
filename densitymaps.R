# Load required libraries
library(ggplot2)      # For data visualization
library(ggmap)        # For plotting maps
library(osmdata)      # For OpenStreetMap data
library(sp)           # For spatial data
library(spatstat)     # For spatial statistics
library(dplyr)        # For data manipulation
library(spdep)        # For spatial dependence
library(tidyverse)    # For data manipulation and visualization
library(spNetwork)    # For spatial network analysis

# Data Preparation

## Read amenity data from CSV file
data <- read.csv("data.csv")

## Remove duplicates based on longitude and latitude
data <- data %>% distinct(lon, lat)

# Map Preparation

## Retrieve map of the specified city (Change city name as needed)
map <- get_map(getbb('City'), source = "stamen")

## Create ggmap object from the map
mapPoints <- ggmap(map)

# Density Map Visualization

## Generate density map and add customization
mapPoints + 
  stat_density2d(aes(fill = ..level..), alpha = .5, h = .02, geom = "polygon", data = data) + 
  scale_fill_viridis_c() + 
  theme(legend.position = 'center') + 
  theme(text = element_text(size = 18))
