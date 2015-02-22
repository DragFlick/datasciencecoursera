
# SET WORKING DIRECTORY - 
## Please set the path of the directory where the Power Consumption Text file is kept.

setwd("C:/CHITRESH - DUMPS/COURSEERA - DATA SCIENTIST TOOLBOX/EXPLORATORY DATA ANALYSIS/household_power_consumption")

# LOADING DATA
## Uploading data and subsetting the necessary data required for plots

filename  = "./household_power_consumption.txt"
data <- read.table(filename,header = TRUE,sep = ";",na.strings = "?",numerals  = "no.loss",strip.white = TRUE)


data[,1] <- as.Date(data[,1],format = "%d/%m/%Y" )
data[,3] <- as.numeric(data[,3])
data[,4] <- as.numeric(data[,4])
data[,5] <- as.numeric(data[,5])
data[,6] <- as.numeric(data[,6])
data[,7] <- as.numeric(data[,7])
data[,8] <- as.numeric(data[,8])
data[,9] <- as.numeric(data[,9])


StudyData <- subset(data,Date == "2007-02-01" | Date == "2007-02-02")
rm("data")

## Merging the date and time to create the date time object

DATE <- as.character(StudyData$Date)
TIME <- as.character(StudyData$Time)
DateTime <- paste(DATE,TIME,sep = " ",collapse = NULL)

## Converting the Char data to DateTime Class

datetime <- strptime(DateTime,tz = "GMT" ,format = "%Y-%m-%d %H:%M:%S")

## Merging the data to the Study Data

StudyData <- cbind(datetime,StudyData)
names(StudyData) <- tolower(names(StudyData))

## Creating the Final dataset for creation of Graphs

StudyData <- StudyData[,-c(2:3)]


# PLOTTING GRAPHS ON THE DATA SET StudyData


## Plot 1

jpeg(filename = "Plot01.jpg",width = 800,height = 600)
hist(as.numeric(StudyData$global_active_power),xlab = "Global Active Power (Kilowatts)",ylab = "Frequency",col = "red",main = "Global Active Power")
dev.off()

## Plot 2

jpeg(filename = "Plot02.jpg",width = 800,height = 600)
plot(as.POSIXlt(StudyData$datetime),StudyData$global_active_power,xlab = "",ylab = "Global Active Power (kilowatts)" , type = "n")
lines(as.POSIXlt(StudyData$datetime),StudyData$global_active_power,col = "red")
dev.off()

## Plot 3

jpeg(filename = "Plot03.jpg",width = 800,height = 600)
plot(StudyData$datetime,StudyData$sub_metering_1,xlab = "",ylab = "Energy Sub Metering", type = "n")
lines(StudyData$datetime,StudyData$sub_metering_1,col = "black")
lines(StudyData$datetime,StudyData$sub_metering_2,col = "red")
lines(StudyData$datetime,StudyData$sub_metering_3,col = "blue")
legend("topright",lty = 1,lwd = 2,legend = c("Sub_Metering_1","Sub_Metering_2","Sub_Metering_3"),col = c("black","red","blue"))
dev.off()

## Plot 4

jpeg(filename = "Plot04.jpg",width = 1200,height = 800)
par(mfrow = c(2,2) , mar = c(4,4,2,2))

plot(StudyData$datetime,StudyData$global_active_power,xlab = "",ylab = "Global Active Power",type = "n")
lines(StudyData$datetime,StudyData$global_active_power,col = "black")

plot(StudyData$datetime,StudyData$voltage,xlab = "datetime",ylab = "Voltage",type = "n")
lines(StudyData$datetime,StudyData$voltage,col = "black")

plot(StudyData$datetime,StudyData$sub_metering_1,xlab = "",ylab = "Energy Sub Metering", type = "n")
lines(StudyData$datetime,StudyData$sub_metering_1,col = "black")
lines(StudyData$datetime,StudyData$sub_metering_2,col = "red")
lines(StudyData$datetime,StudyData$sub_metering_3,col = "blue")
legend("topright",lty = 1,lwd = 2,legend = c("Sub_Metering_1","Sub_Metering_2","Sub_Metering_3"),col = c("black","red","blue"))

plot(StudyData$datetime,StudyData$global_reactive_power,xlab = "datetime",ylab = "Global Reactive Power",type = "n")
lines(StudyData$datetime,StudyData$global_reactive_power,col = "black")

dev.off()







