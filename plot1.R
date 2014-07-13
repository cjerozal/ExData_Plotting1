# Creating a plot to match the provided Plot 1.

# TODO remove
# fileLocation <- "/home/cheryl/coursera/jh-data-science/working_directory/4-cp1/household_power_consumption.txt"

# TODO fill in
# download the data
# then read it in

# TODO bring back
# powerData <- read.csv(fileLocation, sep = ";", header = TRUE)

# helper function from
# http://stackoverflow.com/questions/3418128/how-to-convert-a-factor-to-an-integer-numeric-without-a-loss-of-information
as.numeric.factor <- function(x) {as.numeric(levels(x))[x]}

# We only want to plot the data from 2007-02-01 and 2007-02-02
currentPowerData <- powerData[powerData$Date == "1/2/2007" |
                              powerData$Date == "2/2/2007", ]

png(file = "plot1.png")
library(datasets)

hist(as.numeric.factor(currentPowerData$Global_active_power),
     col = "red",
     xlab = "Global Active Power (kilowatts)",
     main = "Global Active Power",
     breaks = 12)

dev.off()
