# Load libraries
library(fmsb)
library(dplyr)

# Read in the file
distances <- read.csv("Book3.csv")

# Assume the structure is:
# Metro | Thredbo | Perisher | Charlotte.Pass | Selwyn | Falls.Creek | Mt.Hotham | Mt.Buller | Mt.Stirling | Mt.Baw.Baw

# Function to plot spider chart for a single resort
plot_resort_radar <- function(resort_name, df) {
  
  # Extract distances for the given resort
  temp <- df %>%
    select(Metro, all_of(resort_name))
  
  # Prepare data frame for fmsb
  radar_data <- data.frame(t(temp[[resort_name]]))
  colnames(radar_data) <- temp$Metro
  
  # fmsb requires two extra rows: max and min
  radar_data <- rbind(
    rep(1000, ncol(radar_data)),  # upper limit
    rep(0, ncol(radar_data)),     # lower limit
    radar_data
  )
  
  # Plot radar chart
  radarchart(
    radar_data,
    axistype = 1,
    pcol = "blue", pfcol = scales::alpha("blue", 0.3), plwd = 3,
    cglcol = "black", cglty = 1, axislabcol = "black", caxislabels = seq(0, 1000, 200), cglwd = 0.8,
    vlcex = 0.8,
    title = paste("Distance (km) from Metros to", resort_name)
  )
}

# Example: Plot for Thredbo
plot_resort_radar("Thredbo", distances)

# You can loop through all resorts if you want
resorts <- colnames(distances)[-1]  # all except Metro
for (r in resorts) {
  plot_resort_radar(r, distances)
}

