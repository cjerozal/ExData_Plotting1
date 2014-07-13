# Creating a plot to match the provided Plot 4.


fileLocation <- "/home/cheryl/coursera/jh-data-science/working_directory/4-cp1/household_power_consumption.txt"
powerData <- read.csv(fileLocation, sep = ";", header = TRUE,
                      colClasses = c("character", "character", rep("numeric", 7)),
                      na.strings = c("?"))
# We only want to plot the data from 2007-02-01 and 2007-02-02
currentPowerData <- powerData[powerData$Date == "1/2/2007" |
                                  powerData$Date == "2/2/2007", ]


library(datasets)
png(file = "plot4.png")

# set up four slots for subplots within this plot
originalMfcol <- par("mfcol")
par(mfcol = c(2, 2))

# add a column to the data for POSIXct datetimes
currentPowerData$datetime <- apply(currentPowerData, 1, function(row) {
    as.POSIXct(
        strptime(
            paste(row["Date"], row["Time"]),
            "%d/%m/%Y %H:%M:%S",
            tz = "GMT"),
        tz = "GMT")
})

# GMT epoch times and labels for Feb 1 2007, Feb 2 2007, and Feb 3 2007 (midnight)
labelNums <- c(1170288000, 1170374370, 1170460740)
labels <- c("Thu", "Fri", "Sat")


# Upper left subplot

with(currentPowerData,
     plot(datetime, Global_active_power,
          xaxt = "n", # remove default tick marks from x axis
          xlab = "",  # remove x axis title
          ylab = "Global Active Power",
          type = "l"))

# add day of week labels to x axis
axis(side = 1, at = labelNums, labels = labels)


# Lower left subplot

# create chart to start from
with(currentPowerData,
     plot(datetime, Sub_metering_1,
          type = "n",
          xaxt = "n", # remove default tick marks from x axis
          xlab = "",  # remove x axis title
          ylab = "Energy sub metering"))

# add day of week labels to x axis
axis(side = 1, at = labelNums, labels = labels)

# add data for each type of submetering
with(currentPowerData,
     points(datetime, Sub_metering_1, type = "l"))
with(currentPowerData,
     points(datetime, Sub_metering_2, col = "red", type = "l"))
with(currentPowerData,
     points(datetime, Sub_metering_3, col = "blue", type = "l"))

# add legend
legend("topright", lty = "solid",
       col = c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))


# Upper right subplot

with(currentPowerData,
     plot(datetime, Voltage,
          xaxt = "n", # remove default tick marks from x axis
          type = "l"))

# add day of week labels to x axis
axis(side = 1, at = labelNums, labels = labels)


# Lower right subplot

with(currentPowerData,
     plot(datetime, Global_reactive_power,
          xaxt = "n", # remove default tick marks from x axis
          type = "l"))

# add day of week labels to x axis
axis(side = 1, at = labelNums, labels = labels)


# restore original subplot settings
par(mfcol = originalMfcol)

dev.off()
