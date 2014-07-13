# Creating a plot to match the provided Plot 1.


fileLocation <- "/home/cheryl/coursera/jh-data-science/working_directory/4-cp1/household_power_consumption.txt"
powerData <- read.csv(fileLocation, sep = ";", header = TRUE,
                      colClasses = c("character", "character", rep("numeric", 7)),
                      na.strings = c("?"))
# We only want to plot the data from 2007-02-01 and 2007-02-02
currentPowerData <- powerData[powerData$Date == "1/2/2007" |
                              powerData$Date == "2/2/2007", ]


library(datasets)
png(file = "plot1.png")

hist(currentPowerData$Global_active_power,
     col = "red",
     xlab = "Global Active Power (kilowatts)",
     main = "Global Active Power",
     breaks = 12)

dev.off()
