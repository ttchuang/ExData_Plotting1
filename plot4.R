# Set working directory
setwd("./MOOC/Exploratory Data Analysis/project1")

# Read data into R objects
fileUrl <- "./data/household_power_consumption.txt"
powerRaw <- read.table(fileUrl,header=TRUE,sep=";",stringsAsFactors=FALSE, na.string="?")

# Extract complete cases and needed subset
powerComplete <- powerRaw[complete.cases(powerRaw),]
powerData <- powerComplete[grep("^[12]/2/2007",powerComplete$Date),]

# Remove powerRaw and powerComplete to clear memory
rm(powerRaw, powerComplete)  

# Concatenate Date and Time
# Convert Date/time to R objects
powerData$Datetime <- paste(powerData$Date,powerData$Time,sep=" ")
powerData$Datetime <- strptime(powerData$Datetime,format="%d/%m/%Y %H:%M:%S")
powerData$Datetime <- as.POSIXct(powerData$Datetime)

# Plotting
png(file="plot4.png", width = 480, height = 480, units = "px")
par(mfcol=c(2,2))

# Global Active Power
plot(powerData$Global_active_power ~ powerData$Datetime, xlab="",
     ylab="Global Active Power", type="l")

# Energy sub metering
with(powerData, plot(Sub_metering_1 ~ powerData$Datetime,type="l",
                     ylab="Energy sub metering",xlab=""))
with(powerData, lines(Sub_metering_2 ~ powerData$Datetime,col="red"))
with(powerData, lines(Sub_metering_3 ~ powerData$Datetime,col="blue"))
legend("topright",col=c("black","red","blue"),lty=c(1,1),bty="n",
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

# Voltage
plot(powerData$Voltage ~ powerData$Datetime,type="l",
                  xlab="dateime",ylab="Voltage")


# Global Reactive Power
plot(powerData$Global_reactive_power ~ powerData$Datetime,type="l",
                  xlab="datetime",ylab="Global_reactive_power")

dev.off()
par(mfcol=c(1,1))
