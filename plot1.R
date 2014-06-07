# Set working directory
setwd("./MOOC/Exploratory Data Analysis/project1")

# Read data into R objects
fileUrl <- "./data/household_power_consumption.txt"
powerRaw <- read.table(fileUrl,header=TRUE,sep=";",stringsAsFactors=FALSE,na.string="?")

# Extract complete cases and needed subset
powerComplete <- powerRaw[complete.cases(powerRaw),]
powerData <- powerComplete[grep("^[12]/2/2007",powerComplete$Date),]


# Remove powerRaw and powerComplete to clear memory
rm(powerRaw, powerComplete)  

# Convert characters to numeric data
powerData$Global_active_power <- as.numeric(powerData$Global_active_power)

# Setup graphic device as PNG
png(file="plot1.png", width = 480, height = 480, units = "px")
hist(powerData$Global_active_power,main="Global Active Power",
          xlab="Global Active Power (kilowatts)", col="red")
dev.off()
