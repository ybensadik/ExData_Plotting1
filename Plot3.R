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

# convert plotting variables to numeric format
submetering1 <- as.numeric(subsetData$Sub_metering_1)
submetering2 <- as.numeric(subsetData$Sub_metering_2)
submetering3 <- as.numeric(subsetData$Sub_metering_3)

# open plot device in right size
png("plot3.png", width=480, height=480)

# Now plot submetering variables to the opened plot device
# ylim parameter sets the maximu value of the y-axis to the largest value found in the three variables plotted.
# use par function after each plot to add the second plot to the first one instead of overwriting it.
with(subsetData, plot(as.POSIXct(paste(Date,Time), format="%d/%m/%Y %H:%M:%S"), ylim=c(0,max(submetering1, submetering2, submetering3)), submetering1, col="black", type="l", xlab = "", ylab = "Energy sub metering"))

par(new=TRUE)
with (subsetData, plot(as.POSIXct(paste(Date,Time), format="%d/%m/%Y %H:%M:%S"), ylim=c(0,max(submetering1, submetering2, submetering3)), submetering2, col="red", type="l", xlab = "", ylab = "Energy sub metering"))

par(new=TRUE)
with (subsetData, plot(as.POSIXct(paste(Date,Time), format="%d/%m/%Y %H:%M:%S"), ylim=c(0,max(submetering1, submetering2, submetering3)), submetering3, col="blue", type="l", xlab = "", ylab = "Energy sub metering"))

# Add a legend
legend ("topright", lty=1, lwd=2, col = c("black", "red","blue"), legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"))
#close plot device
dev.off()