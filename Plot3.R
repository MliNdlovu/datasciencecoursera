#create the working directory

if (!file.exists("data")) {
  dir.create("plotdata")
}

#downlide the file from the internet and read it into R

fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL, destfile = "plotdata/household_power_consumption.txt")
energy <- read.table("plotdata/household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?")

# susbetting to the two days of interest i.e 1/2/2007 and 2/2/2007 and sense checking the subseting

pwr2days <- subset(energy, energy$Date == "1/2/2007" | energy$Date == "2/2/2007")
dim(pwr2days)

# Transform the Date and Time variables to Date and POSIXit objects 

library(anytime)
date_n_time <- paste(pwr2days$Date, pwr2days$Time) 
datetime <- strptime(date_n_time, "%d/%m/%Y %H:%M:%S")

# Open png graphics device and call the plot function from the base plotting system
png("plot3.png")
plot(datetime, pwr2days$Sub_metering_1, type="l",xlab="",ylab="Energy sub metering")
lines(datetime,pwr2days$Sub_metering_2, col = "red")
lines(datetime,pwr2days$Sub_metering_2, col = "blue")
legend("topright", col = c("black","red","blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dev.off()