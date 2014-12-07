library(dplyr) # install.packages("dplyr") if you don't have this library on your system
library(data.table) # assumes library "data.table" already installed. Used to fast-read the data file.

# Replace the following with the correct folder on your machine
#setwd("C:\\Users\\G\\SkyDrive\\Documents\\Coursera\\Exploratory analysis")

url="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
urlfile = "exdata-data-household_power_consumption.zip"
file="household_power_consumption.txt"

# download the file if you don't already have it in your working directory
if (!file.exists(urlfile))
  download.file(url, destfile=urlfile)

# unzip the file if you haven't already done so in your working directory
if (!file.exists(file)) {
  unzip("exdata-data-household_power_consumption.zip")
}

# The file is large. Load it the first time in a variable called "data"
# and check for the existence of this variable in future runs of the program
# if the variable already exists, simply read it
# if the variable doesn't exist, load the data from the file on disk
if (!exists("mydata")) {
  mydata <- fread(file, sep=";", na.strings="?", header=TRUE)
}

x <- tbl_df(mydata)

# Filter the object for the two dates required by the instructions
# there's no need to cast the dates to other data types yet
# Simply treat them as strings for the purpose of this exercise
filtered <- filter(x,  Date=="1/2/2007"| Date=="2/2/2007")

# Add a new field in the data frame concatenating the date and time columns
filtered <- mutate(filtered, newDate=paste(Date, Time))
filtered$newDate <- strptime(filtered$newDate, format="%d/%m/%Y %H:%M:%S") #convert to a datetime object

par(mfrow = c(2,2))

# First draw on the screen device

  # Top left plot
  plot(filtered$newDate, filtered$Global_active_power, type="l", ylab="Global Active Power", xlab="")
  
  # Top right plot
  plot(filtered$newDate, filtered$Voltage, xlab="datetime", ylab="", type="l")
  
  # Bottom left plot
  plot(filtered$newDate, filtered$Sub_metering_1, type="l", ylab="Energy sub metering", xlab="")
  points(filtered$newDate, filtered$Sub_metering_2, type="l", col="red")
  points(filtered$newDate, filtered$Sub_metering_3, type="l", col="blue")
  legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty="n", col=c("black","red", "blue"), lty=c(1,1,1))
  
  # Bottom right plot
  plot(filtered$newDate, filtered$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")


# Now draw the same plots into a png file
png("plot4.png")

par(mfrow = c(2,2))
# Top left plot
plot(filtered$newDate, filtered$Global_active_power, type="l", ylab="Global Active Power", xlab="")

# Top right plot
plot(filtered$newDate, filtered$Voltage, xlab="datetime", ylab="", type="l")

# Bottom left plot
plot(filtered$newDate, filtered$Sub_metering_1, type="l", ylab="Energy sub metering", xlab="")
points(filtered$newDate, filtered$Sub_metering_2, type="l", col="red")
points(filtered$newDate, filtered$Sub_metering_3, type="l", col="blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty="n", col=c("black","red", "blue"), lty=c(1,1,1))

# Bottom right plot
plot(filtered$newDate, filtered$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power", lwd=1)

dev.off()
