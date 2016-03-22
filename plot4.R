#R Script for Class Project Week 1 - Exploratory Data Analysis

#Get and set working directory where Electronic Power Consumption Data is Located
getwd() #Locating current working directory
setwd("Exploratory") #Setting directory where data is located; modify as necessary

#Read in Electric Power Consuption data
data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?")
head(data)
str(data)
#Date frame looks good

#Reformat date and time variables
##Date 
class(data$Date) # Check class of date variable
data$Date <- as.character(data$Date) # Convert to character
#Time
class(data$Time) #Check class of time variable
data$Time <- as.character(data$Time) # Convert to character

#Create a separate date variable and a variable with the day
data$Dates <- as.Date(data$Date, format = "%d/%m/%Y")

#Create a single character vector with date and time
data$DateTime <- paste(data$Date, data$Time, sep = " ")
#Convert data-time variable to POSIXlt
data$Dated <- strptime(data$DateTime, "%d/%m/%Y %H:%M:%S") # Convert to date
head(data$Dated) #Checking date

#Subset dataframe to dates 2007-02-01 and 2007-02-02
subdfone <- subset(data, data$Dates == "2007-02-01") #subset based on first date
subdftwo <- subset(data, data$Dates == "2007-02-02") #subset based on second data
dfplots <- rbind.data.frame(subdfone, subdftwo) #Append two subsetted data frames

#Make Fourth Plot -- Connected Line Plots for Various Relationships
#Create plot with four graphs; plot data with default axes

#Set screen device parameters
par(mfrow=c(2,2)) #Screen device with two rows and columns
par(mar=c(4, 5, 1, 4.5)) #Reset margins
par(cex.lab=0.8, cex.axis=0.8) #Resize font size for axis label and tick marks

#First Plot
with(dfplots, plot(Dated, Global_active_power, type = "l", ylab = "Global Active Power", xlab=""))

#Second Plot
with(dfplots, plot(Dated, Voltage, type = "l", ylab = "Voltage", xlab="datetime"))

#Third Plot
with(dfplots, plot(Dated, Sub_metering_1, type="n", axes = TRUE, ylab = "Energy sub metering", xlab = ""))
with(dfplots, lines(Dated, Sub_metering_1, col="black"))
with(dfplots, lines(Dated, Sub_metering_2, col="red"))
with(dfplots, lines(Dated, Sub_metering_3, col="blue"))
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black","red","blue"), lty = c(1,1,1), cex=0.75, bty="n")

#Fourth Plot
with(dfplots, plot(Dated, Global_reactive_power, type = "l", ylab = "Global Reactive Power", xlab="datetime"))

#Copy graph in screen device to PNG file
setwd("ExData_Plotting1") #Change working directory to location of github repo
dev.copy(png, "plot4.png") #Copy to PNG device
dev.off() #Finished!