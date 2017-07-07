#change system language to English
Sys.setlocale("LC_TIME", "English")

# Define which data file to read
# IMPORTANT: you should set the value of the parameter "file" to the path where
# you stored the .txt data file.
file <- "./household_power_consumption.txt"

#read raw data file
rawData <- read.table(file, header=TRUE, sep=";", na.strings = "?", stringsAsFactors=FALSE, dec=".")

#select only rows with date 1/2/2007 and 2/2/200
subsetData <- rawData[rawData$Date %in% c("1/2/2007","2/2/2007") ,]

# convert plotting variable to numeric format
globalActivePower <- as.numeric(subsetData$Global_active_power)

# open plot device in right size
png("plot2.png", width=480, height=480)

#Now plot to the opened plot device
with(subsetData, plot(as.POSIXct(paste(Date,Time), format="%d/%m/%Y %H:%M:%S"), Global_active_power, type="l", xlab = "", ylab = "Global Active Power (kilowatts)"))

#close plot device
dev.off()