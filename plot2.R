library(dplyr)

# Replace the following with the correct folder on your machine
setwd("C:\\Users\\G\\SkyDrive\\Documents\\Coursera\\Exploratory analysis")
file="household_power_consumption.txt"

if (!file.exists(file)) {
  unzip("exdata-data-household_power_consumption.zip")
}

# The file is large. Load it the first time in a variable called "data"
# and check for the existence of this variable in future runs of the program
# if the variable already exists, simply read it
# if the variable doesn't exist, load the data from the file on disk
if (!exists("mydata")) {
  mydata <- read.table(file, sep=";", na.string="?", header=TRUE)
}

x <- tbl_df(mydata)

# Filter the object for the two dates required by the instructions
# there's no need to cast the dates to other data types yet
# Simply treat them as strings for the purpose of this exercise
filtered <- filter(x,  Date=="1/2/2007"| Date=="2/2/2007")

#print(with(filtered, strptime(paste(Date, Time), format="%d/%m/%Y %H:%M:%S")))
filtered <- mutate(filtered, newDate=paste(Date, Time))
filtered$newDate <- strptime(filtered$newDate, format="%d/%m/%Y %H:%M:%S")

plot(filtered$newDate, filtered$Global_active_power, type="l", ylab="Global Active Power (kilowatts)", xlab="")
dev.copy(png, "plot2.png") # the default height and width of png are 480x480
dev.off()