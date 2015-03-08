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
png(filename = "plot4.png", width = 480, height = 480, units = "px")
par(mfrow = c(2,2))
# Top-Left plot
plot(ConsumptionSUB$Time, ConsumptionSUB$Global_active_power,
     type="l",
     ylab="Global Active Power (kilowatts)",
     xlab="")

# Top-Right plot
plot(ConsumptionSUB$Time, ConsumptionSUB$Voltage,
     type="l",
     ylab="Voltage",
     xlab="datetime")

# Bottom-Left plot
plot(ConsumptionSUB$Time, ConsumptionSUB$Sub_metering_1, type="n", ylab="Energy sub metering", xlab="")
        lines(ConsumptionSUB$Time, ConsumptionSUB$Sub_metering_1, col="black")
        lines(ConsumptionSUB$Time, ConsumptionSUB$Sub_metering_2, col="red")
        lines(ConsumptionSUB$Time, ConsumptionSUB$Sub_metering_3, col="blue")
        legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
               lwd=c(rep(2,3)),
               col=c("black","red","blue"))

# Bottom-Right plot
plot(ConsumptionSUB$Time, ConsumptionSUB$Global_reactive_power,
     type="l",
     ylab="Global_reactive_power",
     xlab="datetime")

graphics.off()