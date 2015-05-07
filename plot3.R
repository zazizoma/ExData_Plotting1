# Script to perform tasks required by Course Project 1 for Exploratory Data Analysis.
# 07 May 2015
# Plot 3

# Read data for Feb 1 2007 - Feb 2 2007
powerdata <- read.table('household_power_consumption.txt', as.is = TRUE, 
    skip = 66637, nrows = 2880, header =FALSE, sep =';', na.strings="?")

# Fix date format
powerdata$V1=as.Date(powerdata$V1,"%d/%m/%Y")

# Ensure plyr available
library(dplyr)
# Combine date and time information, assign column names
powerdata = powerdata %>% mutate(V1=paste(V1,V2)) %>% select(datetime=V1, active=V3, reactive=V4,
    voltage=V5, intensity=V6, meter1=V7, meter2=V8, meter3=V9)

# Fix date and time class
powerdata$datetime=strptime(powerdata$datetime, tz="EST", "%Y-%m-%d %H:%M:%S")

png("plot3.png")
with(powerdata, plot(datetime, meter1, type="l", col="black", xlab="",
    ylab="Energy sub metering"))
with(powerdata, lines(datetime, meter2, type="l", col="red"))
with(powerdata, lines(datetime, meter3, type="l", col="blue"))
legend("topright", c("sub_metering_1", "sub_metering_2", "sub_metering_3"), lty=1, 
    col=c("black", "red", "blue"))
dev.off()