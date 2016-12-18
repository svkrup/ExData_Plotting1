# This script creates a png image of a plot for the variables 'Global active power' and 'DateTime' from the dataset 'Electric power consumption' 
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
 
 # Create plot and save as image
 png(filename="Plot2.png")
 with(hpcfeb07.df, plot(DateTime, Global_active_power, type="n", xlab="", ylab="Global Active Power (kilowatts)"))
 with(hpcfeb07.df, lines(DateTime, Global_active_power, pch=16))
 dev.off()