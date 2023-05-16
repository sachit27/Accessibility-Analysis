# Load required libraries
library(sp)
library(rgeos)
library(spdep)
library(spatstat)
library(rgdal)

# Read in the data. The data should have the "id", latitude and longitude data.
data <- read.csv("data.csv")

# Convert the data to a spatial points data frame
coords <- data[,c("lon","lat")]
spatial_data <- SpatialPointsDataFrame(coords, data)

# Perform point pattern analysis
ppa <- ppp(spatial_data$lon, spatial_data$lat, window = owin(c(min(spatial_data$lon), max(spatial_data$lon)), c(min(spatial_data$lat), max(spatial_data$lat))))
envelope <- envelope(ppa, Kest, nsim = 500)

# Plot the results
plot(envelope)

# Create a neighbor list object
nb <- dnearneigh(spatial_data, d1 = 0, d2 = 1000)

# Convert neighbor list to listw object
listw <- nb2listw(nb, style = "W")

# histogram of nearest neighbor distances (inspired by https://www.mattpeeples.net/modules/PointPattern.html)
hist(nndist(ppa), breaks = 50, xlab = "Distance", main = "Nearest Neighbor Distances")
# calculate envelope around histogram
n.dist <- nndist(ppa) * 111320  #calculate neareast neighbor distances in meters
nb <- 50
# set up seq of nb points between 0 and max nndist
z.seq <- seq(0, max(n.dist), length.out = nb)
# plot histogram of original data
hist(n.dist, breaks = z.seq, xlab = "Distance (m)", main = "NN Distances with Confidence Interval")

# calculate nearest neighbor distances for 1000 simulated point patterns and
# then bin into z.seq
nn.hist <- lapply(rpoispp(density(ppa, sigma = 0.75), nsim = 1000), 
                  function(x) nndist(x) * 111320)
z.int <- lapply(nn.hist, findInterval, vec = z.seq)

# create a matrix containing the values for binned results for all 1000
# simulated runs
z.set <- matrix(NA, length(z.seq), 1000)
for (i in 1:1000) {
  temp1 <- (table(z.int[[i]])/sum(table(z.int[[i]]))) * nrow(data)
  temp2 <- as.numeric(names(temp1))
  for (j in temp2) {
    z.set[j, i] <- temp1[j]
  }
}

# calculate quantiles at 0.05 and 0.95 for each bin in the histogram
q.int <- apply(z.set, 1, quantile, na.rm = T, probs = c(0.05, 0.95))

# add polygon for confidence interval
x <- c(z.seq, rev(z.seq))
y <- c(q.int[1, ], rev(q.int[2, ]))
y[is.na(y)] <- 0
polygon(x, y, col = rgb(0, 0, 1, 0.3))
