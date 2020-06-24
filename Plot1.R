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

#open the png graphics device, call the hist function from the base plotting system and close the png device

png("plot1.png")
hist(pwr2days$Global_active_power, col = "red", main = "Global Active Power", xlab = "Gloabl Active Power (killowatts" , ylab = "Frequency")
dev.off()
