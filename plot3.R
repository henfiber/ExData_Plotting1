# Plot3 - Co-plots of energy sub-metering over time (2007-02-01, 2007-02-01)
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
plot3 <- function() {
    
    par(ps = 14)  # Set point size of text to 14, to match the assignment figures
    
    # Add the first line plot
    plot(epc_data$Date,epc_data$Sub_metering_1,
         type="l",
         xlab="", ylab="Energy sub metering")
    
    # Adding the extra line-plots
    lines(epc_data$Date,epc_data$Sub_metering_2,col="red")
    lines(epc_data$Date,epc_data$Sub_metering_3,col="blue")
    
    # Add the top-right legend
    legend("topright",
           legend = c("Sub_metering_1  ", "Sub_metering_2  ", "Sub_metering_3  "),
           col = c("black","red","blue"),
           cex = .9,
           lty = c(1,1), lwd = c(1,1))
    
    # Saving to a 480x480 png file
    dev.copy(png, file="plot3.png", width=480, height=480)
    dev.off()
    
    cat("plot3.png has been created in", getwd())
}



# Load the dataset only if it has not been already loaded
if(!exists("epc_data") || is.null(epc_data)) {
    epc_data <- load_data()
}

plot3()


