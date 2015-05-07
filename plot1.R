##############################################################
# =============================================
# Exploratory Data Analysis - Course Project 1
# =============================================
##############################################################
# Examine how household energy usage varies over
# a 2-day period in February, 2007
# Plot 1
##############################################################


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

# Transform the Global_active_power to numeric
power$Global_active_power <- as.numeric(power$Global_active_power)

# Open the png device
png("plot1.png", width=480, height=480)

# Plot the diagram
hist(power$Global_active_power, 
     main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", 
     ylab="Frequency", 
     col="Red")

# Remove the dataframe
rm(power)

# Close the device
dev.off()