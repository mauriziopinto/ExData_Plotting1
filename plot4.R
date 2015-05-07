##############################################################
# =============================================
# Exploratory Data Analysis - Course Project 1
# =============================================
##############################################################
# Examine how household energy usage varies over
# a 2-day period in February, 2007
# Plot 4
##############################################################

# Set the locale to English to have the Thu, Fri, Sat labels
Sys.setlocale("LC_TIME", "English") 

# Assign the fileName to load
fileName <- "household_power_consumption.txt"
# Assign the url of the zipped file (if not already downloaded)
fileUrl <- "http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

# Check if the file has been already downloaded previously
if(!file.exists(fileName)) {
        # Create a temporary file
        temp <- tempfile()
        # Download the zipped file
        download.file(fileUrl,temp)
        # Unzip the file in the working directory
        file <- unzip(temp)
        # Delete the temporary file
        unlink(temp)
}

# Load the whole file
allPowerData <- read.table(fileName, header=TRUE, sep=";", stringsAsFactors=FALSE, na.strings="?", dec=".")

# Since we are going to subset on dates, transform
# the Date column to the correct type
allPowerData$Date <- as.Date(allPowerData$Date, format="%d/%m/%Y")

# Select only the observation from the dates 2007-02-01 and 2007-02-02.
power <- subset(allPowerData, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))

# Remove the whole dataframe, because we are going to use only the subset
rm(allPowerData)

# Convert dates
power$Datetime <- as.POSIXct(paste(as.Date(power$Date), power$Time))

# Transform the Global_active_power to numeric
power$Global_active_power <- as.numeric(power$Global_active_power)

# Open the png device
png("plot4.png", width=480, height=480)

# Create four slots for the plots
par(mfrow = c(2, 2)) 

# Plot 1
plot(power$Datetime, 
     power$Global_active_power, 
     type="l", 
     xlab="", 
     ylab="Global Active Power")

# Plot 2
datetime <- power$Datetime
plot(datetime,
     as.numeric(power$Voltage),
     type="l",
     ylab="Voltage")

# Plot 3
with(power, {

        plot(datetime, 
             Sub_metering_1,
             type="l",
             ylab="Energy sub metering",
             xlab="")
        
        lines(datetime, Sub_metering_2, type="l", col="red")
        lines(datetime, Sub_metering_3, type="l", col="blue")
        legend("topright", 
               c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
               lwd=0, 
               col=c("black", "red", "blue"),
               bty="n")
})

# Plot 4
with(power, {
        plot(Global_reactive_power ~ datetime,
     type="l")
})

# Remove the objects
rm(power)
rm(datetime)

# Close the device
dev.off()