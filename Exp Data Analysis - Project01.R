
# SET WORKING DIRECTORY 
setwd("C:/CHITRESH - DUMPS/COURSEERA - DATA SCIENTIST TOOLBOX/EXPLORATORY DATA ANALYSIS/household_power_consumption")

# LOADING DATA

filename  = "./household_power_consumption.txt"
data <- read.table(filename,header = TRUE,sep = ";",numerals  = "no.loss",strip.white = TRUE)


data[,1] <- as.Date(data[,1],format = "%d/%m/%Y" )
data[,3] <- as.numeric(data[,3])
data[,4] <- as.numeric(data[,4])
data[,5] <- as.numeric(data[,5])
data[,6] <- as.numeric(data[,6])
data[,7] <- as.numeric(data[,7])
data[,8] <- as.numeric(data[,8])
data[,9] <- as.numeric(data[,9])


study_data <- subset(data,Date == "2007-02-01" | Date == "2007-02-02")
rm("data")

## Merging the date and time to create the date time object

DATE <- as.character(study_data$Date)
TIME <- as.character(study_data$Time)
date_time <- paste(DATE,TIME,sep = " ",collapse = NULL)

## Converting the Char data to DateTime Class

datetime <- strptime(date_time,tz = "GMT" ,format = "%Y-%m-%d %H:%M:%S")

## Merging the data to the Study Data

study_data <- cbind(datetime,study_data)
names(study_data) <- tolower(names(study_data))

## Creating the Final dataset for creation of Graphs

study_data <- study_data[,-c(2:3)]


# PLOTTING GRAPHS ON THE DATA SET study_data

######################################################################

## Plot 1

hist(as.numeric(study_data$global_active_power),xlab = "Global Active Power (Kilowatts)",ylab = "Frequency",col = "red",main = "Global Active Power")


###################################################################

## Plot 2


plot(as.POSIXlt(study_data$datetime),study_data$global_active_power,xlab = "",ylab = "Global Active Power (kilowatts)" , type = "n")
lines(as.POSIXlt(study_data$datetime),study_data$global_active_power,col = "red")

##################################################################

## Plot 3

plot(study_data$datetime,study_data$sub_metering_1,xlab = "",ylab = "Energy Sub Metering", type = "n")
lines(study_data$datetime,study_data$sub_metering_1,col = "black")
lines(study_data$datetime,study_data$sub_metering_2,col = "red")
lines(study_data$datetime,study_data$sub_metering_3,col = "blue")
legend("topright",lty = 1,lwd = 2,legend = c("Sub_Metering_1","Sub_Metering_2","Sub_Metering_3"),col = c("black","red","blue"))

#################################################################

## Plot 4

par(mfrow = c(2,2) , mar = c(4,4,2,2))

plot(study_data$datetime,study_data$global_active_power,xlab = "",ylab = "Global Active Power",type = "n")
lines(study_data$datetime,study_data$global_active_power,col = "black")

plot(study_data$datetime,study_data$voltage,xlab = "datetime",ylab = "Voltage",type = "n")
lines(study_data$datetime,study_data$voltage,col = "black")


plot(study_data$datetime,study_data$sub_metering_1,xlab = "",ylab = "Energy Sub Metering", type = "n")
lines(study_data$datetime,study_data$sub_metering_1,col = "black")
lines(study_data$datetime,study_data$sub_metering_2,col = "red")
lines(study_data$datetime,study_data$sub_metering_3,col = "blue")
legend("topright",lty = 1,lwd = 2,legend = c("Sub_Metering_1","Sub_Metering_2","Sub_Metering_3"),col = c("black","red","blue"))


plot(study_data$datetime,study_data$global_reactive_power,xlab = "datetime",ylab = "Global Reactive Power",type = "n")
lines(study_data$datetime,study_data$global_reactive_power,col = "black")


###########################################################




