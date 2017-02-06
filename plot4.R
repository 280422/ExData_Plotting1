setwd("~/RStudio")

if(!file.exists('data')) dir.create('data')
fileUrl <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'

#uncompress the file if not already done
if(!file.exists('./data/household_power_consumption.zip')) 
  download.file(fileUrl, destfile = './data/household_power_consumption.zip')
  unzip('./data/household_power_consumption.zip', exdir = './data')

pwrcondata_full <- read.table("~/RStudio/data/household_power_consumption.txt", header = T, sep = ";", na.strings = "?")

# convert the date variable to Date class
pwrcondata_full$Date <- as.Date(pwrcondata_full$Date, format = "%d/%m/%Y")

# Subset the data
pwrcondata_sub <- subset(pwrcondata_full, subset = (Date >= "2007-02-01" & Date <= "2007-02-02"))

# Convert dates and times
pwrcondata_sub$datetime <- strptime(paste(pwrcondata_sub$Date, pwrcondata_sub$Time), "%Y-%m-%d %H:%M:%S")

## Plot Plot # 4

par(mfrow=c(2,2))
with(pwrcondata_sub, {
  plot(datetime,Global_active_power, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  plot(datetime,Voltage, type="l", 
       ylab="Voltage (volt)", xlab="")
  plot(datetime,Sub_metering_1, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(datetime,Sub_metering_2,col='Red')
  lines(datetime,Sub_metering_3,col='Blue')
  legend("topright", col=c("black", "red", "blue"),legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(datetime,Global_reactive_power, type="l", ylab="Global Rective Power (kilowatts)",xlab="")
}) 

## Saving to file
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()