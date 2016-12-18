# This script creates a plot from the dataset'Electric power consumption' 
# The plot maps the variables 'Sub_metering_1', 'Sub_metering_2' and 'Sub_metering_3' against 'DateTime' 
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

 # Create the plot and legend
 png(filename="Plot3.png")
 with(hpcfeb07.df, plot(DateTime, Sub_metering_1, type="n", xlab="", ylab="Energy sub metering"))
 with(hpcfeb07.df, lines(DateTime, Sub_metering_1, pch=16, col="dark grey"))
 with(hpcfeb07.df, lines(DateTime, Sub_metering_2, pch=16, col="red"))
 with(hpcfeb07.df, lines(DateTime, Sub_metering_3, pch=16, col="blue"))
 legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=c(1,1),col=c("dark gray","red", "blue"))
 dev.off()