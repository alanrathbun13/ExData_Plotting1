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

#Create a separate date variable
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

#Make First Plot -- Histogram of Global Active Power
#Plot data without axes; red color for bars; titles for main and x axis
with(dfplots, hist(Global_active_power, col = "red" , axes = FALSE,
xlab = "Global Active Power (kilowatts)",main = "Global Active Power"))
axis(1, at = c(0, 2, 4, 6)) #Adding x axis 
par(cex.axis=0.70) #Set scale for text size on y-axis to fit all tick labels  
axis(2, at = c(0, 200, 400, 600, 800, 1000, 1200)) #Adding y axis

#Copy graph in screen device to PNG file
setwd("ExData_Plotting1") #Change working directory to location of github repo
dev.copy(png, "plot1.png", width = 480, height = 480, units = "px") #Copy to PNG device
dev.off() #Finish





