#############################
#   Plot 3 - Sub Metering   #
#############################

# Check if project data folder exists. If it not exists, create a project data folder.

if (!file.exists("Project1Data")) 
{
  dir.create("Project1Data")
}

# Set file URL & the destination file. 

URL                 <-      "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
destfile            <-      "./Project1Data/household_power_consumption.zip"

# Download the file. Now, go to "./Project1Data" and extrac the file.

download.file(URL, destfile)

# Read full dataset.

dataset             <-      read.csv("./Project1Data/household_power_consumption.txt", header=T, sep=';', na.strings="?", 
                                     nrows=2075259, check.names=F, stringsAsFactors=F, comment.char="", quote='\"')
dataset$Date        <-      as.Date(dataset$Date, format="%d/%m/%Y")

# Subsetting the work data.

workdata            <-      subset(dataset, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))

# Rename the columns

names(workdata)     <-      c("date", "time", "active_power", "reactive_power", "voltage",
                              "intensity", "sub_metering_1", "sub_metering_2", 
                              "sub_metering_3")

# Convert dates and add a new date-time column

datetime            <-      paste(as.Date(workdata$date), workdata$time)
workdata$newtime    <-      as.POSIXct(datetime)

# Plot 

with(workdata, {
  plot(newtime, sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
  lines(newtime, sub_metering_2, col = "red")
  lines(newtime, sub_metering_3, col = "blue")
  legend("topright", col = c("black", "red", "blue"), cex = 0.8, lty = 1,
         legend = c("Sub_metering_1    ", 
                    "Sub_metering_2    ",
                    "Sub_metering_3    "))
  
})

# Saving to file

dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()
