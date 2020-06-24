#create the working directory

if (!file.exists("data")) {
  dir.create("plotdata")
}

#downlide the file from the internet and read it into R

fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL, destfile = "plotdata/household_power_consumption.txt")
energy <- read.table("plotdata/household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?")

#quick check that data is read in correctly

names(energy)
dim(energy)
head(energy, n = 3)

# susbetting to the two days of interest i.e 1/2/2007 and 2/2/2007 and sense checking the subseting

pwr2days <- subset(energy, energy$Date == "1/2/2007" | energy$Date == "2/2/2007")
dim(pwr2days)

# Transform the Date and Time variables to Date and POSIXit objects 

library(anytime)
date_n_time <- paste(pwr2days$Date, pwr2days$Time) 
datetime <- strptime(date_n_time, "%d/%m/%Y %H:%M:%S")

#call the plot function from the base plotting system

png("plot4.png")
par(mfrow = c(2,2),mar = c(4, 4, 2, 1), oma = c(0, 0, 2, 0))
plot(datetime, pwr2days$Global_active_power, type="l",xlab="",ylab="Global Active Power (kilowatts)")
plot(datetime, pwr2days$Voltage, type="l",xlab="datetime",ylab="Voltage")
plot(datetime, pwr2days$Sub_metering_1, type="l",xlab="",ylab="Energy sub metering");lines(datetime,pwr2days$Sub_metering_2, col = "red");lines(datetime,pwr2days$Sub_metering_3, col = "blue");legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
plot(datetime, pwr2days$Global_reactive_power, type="l",xlab="datetime",ylab="Global_reactive_power")

#Copy the plots to a png device


dev.off

