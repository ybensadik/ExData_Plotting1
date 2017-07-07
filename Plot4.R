# change system language to English
Sys.setlocale("LC_TIME", "English")

# Define which data file to read
# IMPORTANT: you should set the value of the parameter "file" to the path where
# you stored the .txt data file.
file <- "./household_power_consumption.txt"

#read raw data file
rawData <- read.table(file, header=TRUE,  sep=";", stringsAsFactors=FALSE, dec=".")

#select only rows with date 1/2/2007 and 2/2/2007
subsetData <- rawData[rawData$Date %in% c("1/2/2007","2/2/2007") ,]

# open plot device in right size
png("plot4.png", width=480, height=480)

#setup plot area with 4 plots in a 2x2 matrix
par(mfrow=c(2,2), oma=c(0.25, 0.25, 0.25, 0.25), mar=c(4, 3.75, 1, 1.5))

################################################################
##################### start TOP LEFT plot ######################
################################################################

# convert plotting variable to numeric format
globalActivePower <- as.numeric(subsetData$Global_active_power)

#Now plot to the opened plot device
with(subsetData, plot(as.POSIXct(paste(Date,Time), format="%d/%m/%Y %H:%M:%S"), globalActivePower, type="l", xlab = "", ylab = "Global Active Power"))

################################################################
##################### end TOPT LEFT plot #######################
################################################################



################################################################
##################### start TOP RIGHT plot #####################
################################################################

# convert plotting variable to numeric format
voltage <- as.numeric(subsetData$Voltage) # convert plotting variable to numeric format

#Now plot to the opened plot device
with(subsetData, plot(as.POSIXct(paste(Date,Time), format="%d/%m/%Y %H:%M:%S"), voltage, type="l", xlab = "datetime", ylab = "Voltage"))

################################################################
##################### end TOP RIGHT plot #######################
################################################################


################################################################
##################### start BOTTOM LEFT plot ###################
################################################################

# convert plotting variables to numeric format
submetering1 <- as.numeric(subsetData$Sub_metering_1)
submetering2 <- as.numeric(subsetData$Sub_metering_2)
submetering3 <- as.numeric(subsetData$Sub_metering_3)

# Now plot submetering variables to the opened plot device
# ylim parameter sets the maximu value of the y-axis to the largest value found in the three variables plotted.
# use par function after each plot to add the second plot to the first one instead of overwriting it.
with(subsetData, plot(as.POSIXct(paste(Date,Time), format="%d/%m/%Y %H:%M:%S"), ylim=c(0,max(submetering1, submetering2, submetering3)), submetering1, col="black", type="l", xlab = "", ylab = "Energy sub metering"))

par(new=TRUE)
with (subsetData, plot(as.POSIXct(paste(Date,Time), format="%d/%m/%Y %H:%M:%S"), ylim=c(0,max(submetering1, submetering2, submetering3)), submetering2, col="red", type="l", xlab = "", ylab = "Energy sub metering"))

par(new=TRUE)
with (subsetData, plot(as.POSIXct(paste(Date,Time), format="%d/%m/%Y %H:%M:%S"), ylim=c(0,max(submetering1, submetering2, submetering3)), submetering3, col="blue", type="l", xlab = "", ylab = "Energy sub metering"))

# Add a legend
legend ("topright", cex = 0.95, lty=1, lwd=2, col = c("black", "red","blue"), legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"))

################################################################
##################### end BOTTOM LEFT plot #####################
################################################################


################################################################
##################### start BOTTOM RIGHT plot ##################
################################################################

# convert plotting variable to numeric format
globalReactivePower <- as.numeric(subsetData$Global_reactive_power)

#Now plot to the opened plot device
with(subsetData, plot(as.POSIXct(paste(Date,Time), format="%d/%m/%Y %H:%M:%S"), globalReactivePower, type="l", xlab = "datetime", ylab = "Global_reactive_power"))

################################################################
##################### end BOTTOM RIGHT plot ####################
################################################################


#close plot device
dev.off()