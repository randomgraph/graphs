# Data columns
#
# Date: Date in format d/m/yyyy
# Time: time in format hh:mm:ss
# Global_active_power: household global minute-averaged active power (in kilowatt)
# Global_reactive_power: household global minute-averaged reactive power (in kilowatt)
# Voltage: minute-averaged voltage (in volt)
# Global_intensity: household global minute-averaged current intensity (in ampere)
# Sub_metering_1: energy sub-metering No. 1 (in watt-hour of active energy). It corresponds to the kitchen, containing mainly a dishwasher, an oven and a microwave (hot plates are not electric but gas powered).
# Sub_metering_2: energy sub-metering No. 2 (in watt-hour of active energy). It corresponds to the laundry room, containing a washing-machine, a tumble-drier, a refrigerator and a light.
# Sub_metering_3: energy sub-metering No. 3 (in watt-hour of active energy). It corresponds to an electric water-heater and an air-conditioner.


# Read data and filter needed dates 
data <- read.csv(file="household_power_consumption.txt",head=TRUE,sep=";", dec=".", na.strings = "?",
                 colClasses=c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"))
data <- subset(data, Date=="1/2/2007" | Date=="2/2/2007")

# Create date time field
data$datetime <- as.POSIXct(paste(data$Date, data$Time), format="%d/%m/%Y %H:%M:%S")

# Remove NA lines
data <- data[complete.cases(data),]

# We want week days in english ...
Sys.setlocale("LC_ALL", "English")

# Plot 3. 
plot(data$datetime, data$Sub_metering_1, type="l", col="black", ylab="Energy sub metering", xlab="")
lines(data$datetime, data$Sub_metering_2, type="l", col="red",   ylab="Energy sub metering", xlab="")
lines(data$datetime, data$Sub_metering_3, type="l", col="blue",  ylab="Energy sub metering", xlab="")
legend("topright", lwd=1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# Repeat same to file (dev.copy() doesn't always produce exact copy)
png(filename="plot3.png", width=480, height=480)
plot(data$datetime, data$Sub_metering_1, type="l", col="black", ylab="Energy sub metering", xlab="")
lines(data$datetime, data$Sub_metering_2, type="l", col="red",   ylab="Energy sub metering", xlab="")
lines(data$datetime, data$Sub_metering_3, type="l", col="blue",  ylab="Energy sub metering", xlab="")
legend("topright", lwd=1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()
