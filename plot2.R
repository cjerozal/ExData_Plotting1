# Creating a plot to match the provided Plot 2.


fileLocation <- "/home/cheryl/coursera/jh-data-science/working_directory/4-cp1/household_power_consumption.txt"
powerData <- read.csv(fileLocation, sep = ";", header = TRUE,
                      colClasses = c("character", "character", rep("numeric", 7)),
                      na.strings = c("?"))
# We only want to plot the data from 2007-02-01 and 2007-02-02
currentPowerData <- powerData[powerData$Date == "1/2/2007" |
                                  powerData$Date == "2/2/2007", ]


library(datasets)
png(file = "plot2.png")

# add a column to the data for POSIXct datetimes
currentPowerData$datetime <- apply(currentPowerData, 1, function(row) {
    as.POSIXct(
        strptime(
            paste(row["Date"], row["Time"]),
            "%d/%m/%Y %H:%M:%S",
            tz = "GMT"),
        tz = "GMT")
})

with(currentPowerData,
     plot(datetime, Global_active_power,
          xaxt = "n", # remove default tick marks from x axis
          xlab = "",  # remove x axis title
          ylab = "Global Active Power (kilowatts)",
          type = "l"))

# GMT epoch times for Feb 1 2007, Feb 2 2007, and Feb 3 2007 (midnight)
labelNums <- c(1170288000, 1170374370, 1170460740)
# add day of week labels to x axis
axis(side = 1, at = labelNums, labels = c("Thu", "Fri", "Sat"))

dev.off()
