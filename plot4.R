# Plot4 - multiple plots for (2007-02-01, 2007-02-01)
# * Measurements of electric power consumption in one household with
# * a one-minute sampling rate over a period of almost 4 years.
# * More information about the dataset here:
# * https://archive.ics.uci.edu/ml/datasets/Individual+household+electric+power+consumption

# Load the dataset with this function
load_data <- function() {
    
    # Check if the file exists
    if(!file.exists("data/household_power_consumption.zip")){
        stop("File 'data/household_power_consumption.zip was not found
             in the current working directory")
    }
    
    # Since, we're going to read speficic rows from the file, we need to get the
    # column names from the first row of the dataset.
    colnames <- as.character(read.table(unz("data/household_power_consumption.zip",
                                            "household_power_consumption.txt"),
                                        sep=";", quote="", comment.char = '',
                                        header=F, colClasses = "character",
                                        nrows = 1)) # read only the first row
    
    
    # Optimizing the data loading step
    # Each day has 60*24 = 1440 minutes, two days have 2880 => read 2880 rows
    # 1/2/2007 starts at row 66638 => we can skip 66637 lines
    # How did we find 66638? Use the right tool for the job:
    # Shell> unzip -p household_power_consumption.zip | grep '^1/2/2007' -n | head -n1
    
    # Directly read the compressed zip file, no need to unzip - use unz() 
    data <- read.table(unz("data/household_power_consumption.zip",
                           "household_power_consumption.txt"),
                       sep=";", header=F, quote="", comment.char = '',
                       colClasses = c("character","character", rep("numeric",7) ),
                       na.strings = c("?", "ΝΑ"),
                       col.names = colnames,
                       skip = 66637, nrows = 2880)
    
    
    # Concatenate Date and Time columns and convert to POSIXct 
    data$Date <- as.POSIXct(paste(data$Date, data$Time), format = "%d/%m/%Y %H:%M:%S")
    data$Time <- NULL  # Drop the Time column - not needed any more
    data  # return the loaded data
}



# Performing the plot
plot4 <- function() {

    # Set multiple plots per graphic - ordered row-wise
    par(mfrow=c(2,2))
    
    
    # The first line plot, Global_active_power over time
    plot(epc_data$Date,epc_data$Global_active_power,
         type="l",
         xlab="", ylab="Global Active Power")
    
    
    # The second line plot, Voltage over time
    plot(epc_data$Date,epc_data$Voltage,
         type="l",
         xlab="datetime", ylab="Voltage")
    
    
    
    # The third plot, energy sub-metering over time
    plot(epc_data$Date,epc_data$Sub_metering_1,
         type="l",
         xlab="", ylab="Energy sub metering")
    # Add the extra lines
    lines(epc_data$Date,epc_data$Sub_metering_2,col="red")
    lines(epc_data$Date,epc_data$Sub_metering_3,col="blue")
    # Add the legend
    legend("topright",
           legend = c(" Sub_metering_1", " Sub_metering_2", " Sub_metering_3"),
           col=c("black","red","blue"), 
           lty=c(1,1), bty="n", cex=.5) # bty removes the box, cex shrinks the text
    
    
    
    # The 4th plot - Global_reactive_power over time
    plot(epc_data$Date,epc_data$Global_reactive_power,
         type="l",
         xlab="datetime", ylab="Global_reactive_power")
    
    
    # Saving to a 480x480 png file
    dev.copy(png, file="plot4.png", width=480, height=480)
    dev.off()
    
    cat("plot4.png has been created in", getwd())
}



# Load the dataset only if it has not been already loaded
if(!exists("epc_data") || is.null(epc_data)) {
    epc_data <- load_data()
}

plot4()
