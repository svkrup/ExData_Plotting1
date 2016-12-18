# This script creates an image that paints 4 graphs in a 2*2 plot 
# The data is from the dataset'Electric power consumption' 
# The plot maps the following variables against 'DateTime' (reading row-wise):
# Plot 1: 'Global power consumption'
# Plot 2: 'Voltage'
# Plot 3: 'Sub_metering_1', 'Sub_metering_2' and 'Sub_metering_3' 
# Plot 4: 'Reactive power consumption'
# The dataset captures the electric consumption data of a single household for a period of 4 years
# The graph shows the data for 2 days: 2/1/2007 and 2/2/2007
# Size of memory needed to load dataset= 2075259 rows*9 columns*8 bits/POWER(2,20)= 142 MB
 
# Read the data  
 hpc.df <- read.table("household_power_consumption.txt", nrows=5, sep=";", header=TRUE, stringsAsFactors=TRUE)
 hpc.class <- sapply(hpc.df, class)
 hpc.df <- read.table("household_power_consumption.txt", colClasses=hpc.class, sep=";", header=TRUE, stringsAsFactors=TRUE, na.strings="?", nrows=2076000)
 
 # Filter for the 2 days 
 hpcfeb07.df <- filter(hpc.df, Date=="1/2/2007" | Date=="2/2/2007")
 # Create variable that combines the Date and Time factors into a time variable
 hpcfeb07.df$DateTime <- paste(hpcfeb07.df$Date, hpcfeb07.df$Time, sep = " ")
 hpcfeb07.df$DateTime <- strptime(hpcfeb07.df$DateTime, format="%d/%m/%Y %H:%M:%S")
 
 # Draw the plots 
 png("Plot4.png")
 par(mfrow=c(2,2))
 # Draw Plot 1
 plot(hpcfeb07.df$DateTime, hpcfeb07.df$Global_active_power, type="n", xlab="", ylab="Global Active Power (kilowatts)")
 lines(hpcfeb07.df$DateTime, hpcfeb07.df$Global_active_power, pch=16)
 
 # Draw Plot 2
 plot(hpcfeb07.df$DateTime, hpcfeb07.df$Voltage, type="n", xlab="datetime", ylab="Voltage")
 lines(hpcfeb07.df$DateTime, hpcfeb07.df$Voltage, pch=16)
 
 # Draw Plot 3
 plot(hpcfeb07.df$DateTime, hpcfeb07.df$Sub_metering_1, type="n", xlab="", ylab="Energy sub metering")
 lines(hpcfeb07.df$DateTime, hpcfeb07.df$Sub_metering_1, pch=16, col="dark grey")
 lines(hpcfeb07.df$DateTime, hpcfeb07.df$Sub_metering_2, pch=16, col="red")
 lines(hpcfeb07.df$DateTime, hpcfeb07.df$Sub_metering_3, pch=16, col="blue")
 legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=c(1,1),col=c("dark gray","red", "blue"), bty="n")
 
 # Draw Plot 4
 plot(hpcfeb07.df$DateTime, hpcfeb07.df$Global_reactive_power, type="n", xlab="datetime", ylab="Global_reactive_power")
 lines(hpcfeb07.df$DateTime, hpcfeb07.df$Global_reactive_power, pch=16)
 
 dev.off()