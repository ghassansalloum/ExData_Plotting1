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

hist(filtered$Global_active_power, col="red", main="Global active power", xlab="Global Active Power (kilowatts)")
dev.copy(png, "plot1.png") # the default height and width of png are 480x480
dev.off()