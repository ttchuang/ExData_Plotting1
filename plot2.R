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
png(file="plot2.png", width = 480, height = 480, units = "px")
plot(powerData$Global_active_power ~ powerData$Datetime, xlab="",
              ylab="Global Active Power (kilowatts)", type="l")
dev.off()




