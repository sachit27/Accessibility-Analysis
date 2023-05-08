library(ggplot2)
library(ggmap)
library(osmdata)
library(sp)
library(spatstat)
library(dplyr)
library(spdep)
library(tidyverse)
library(spNetwork)
data <- read.csv("data.csv") #the data file includes data of the the amenities that are being analysed
data <- data %>% distinct(lon, lat)
map <- get_map( getbb('City'), source="stamen") #Change the name of the city
mapPoints <- ggmap(map)
mapPoints + stat_density2d(aes(fill = ..level..), alpha = .5, h = .02, geom = "polygon", data = data) + scale_fill_viridis_c() + theme(legend.position = 'center'+ theme(text = element_text(size=18)))
