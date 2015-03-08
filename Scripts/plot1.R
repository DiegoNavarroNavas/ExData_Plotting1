## Read the complete data set
print("Reading 'household_power_consumption.txt'")
Consumption <- read.table("household_power_consumption.txt",
                          sep=";",
                          header=TRUE,
                          na.strings = "?",
                          colClasses=c(rep("character",2),rep("numeric",2)))

## Transform dates and times
print("Transforming Dates and Times")
Consumption$Date <- as.Date(Consumption$Date, format="%d/%m/%Y")
Consumption$Time <- paste(Consumption$Date,Consumption$Time)
Consumption$Time <- strptime(Consumption$Time, format="%Y-%m-%d %H:%M:%S")

## Create a subset with only 2007-02-01 and 2007-02-02 data
print("Subsetting dates 2007-02-01 and 2007-02-02")
ConsumptionSUB <- subset(Consumption, Date=="2007-02-01" | Date=="2007-02-02")

## Plot the graph
print("Plotting and saving Histogram")
graphics.off()
png(filename = "plot1.png", width = 480, height = 480, units = "px")
hist(ConsumptionSUB$Global_active_power,
     col="red",
     main="Global Active Power",
     xlab="Global Active Power (kilowatts)",
     ylab="Frequency")
graphics.off()