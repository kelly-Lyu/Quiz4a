#### Preamble ####
# Purpose: Simulation and Visulization
# Author: Kelly Lyu
# Date: 29 January 2024
# Contact: kelly.lyu@mail.utoronto.ca
# Pre-requisites: None

# Install and load necessary packages
install.packages("ggplot2")
install.packages("dplyr")
install.packages("tidyr")
library(ggplot2)
library(dplyr)
library(tidyr)
library(readr)

set.seed(177) # For reproducibility

# Set number of friends
n_friends <- 20

# Simulate correct heights
true_heights <- runif(n_friends, min = 140, max = 195)


# Simulate Edward's error 
edward_errors <- rep(2, n_friends)

# Simulate Hugo's random error
hugo_errors <- runif(n_friends, min = -5, max = 5)

# Simulate Lucy's smaller random error
lucy_errors <- runif(n_friends, min = -2, max = 2)

# Add errors to true heights
edward_heights <- true_heights + edward_errors
hugo_heights <- true_heights + hugo_errors
lucy_heights <- true_heights + lucy_errors

# Combine into a data frame
simulate_data <- data.frame(
  Friend = 1:n_friends,
  True_Height = true_heights,
  Edward = edward_heights,
  Hugo = hugo_heights,
  Lucy = lucy_heights
)

# View the data
print(simulate_data)

# Save the data
write_csv(simulate_data, "simulate.csv")

# Convert the data to long format
long_data <- gather(simulate_data, Key, Height, Edward:Lucy)

# Create height ranges with specific labels
breaks <- seq(140, 200, by = 5)
labels <- paste(head(breaks, -1), tail(breaks, -1), sep = "-")
long_data$HeightRange <- cut(long_data$Height, breaks = breaks, labels = labels, include.lowest = TRUE)

# Create the bar plot
ggplot(long_data, aes(x = HeightRange, fill = Key)) +
  geom_bar(position = "stack") +
  scale_fill_manual(values = c("Edward" = "blue", "Hugo" = "green", "Lucy" = "red")) +
  labs(title = "Height Measurements by Edward, Hugo, and Lucy",
       x = "Height Range",
       y = "Count") +
  theme_minimal()

