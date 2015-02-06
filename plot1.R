# Dataset available from UC Irvine ML repo : http://archive.ics.uci.edu/ml/
# * Load data from https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
# * Got from: https://archive.ics.uci.edu/ml/datasets/Individual+household+electric+power+consumption
# Description of the dataset
# * Measurements of electric power consumption in one household with
# * a one-minute sampling rate over a period of almost 4 years.
# * Different electrical quantities and some sub-metering values are available.

# Set working directory
setwd("~/projects/datasciencespec/datasciencecoursera-projects/eda/ExData_Plotting1/")

if(!file.exists("data/household_power_consumption.zip")){
    stop("The file 'data/household_power_consumption.zip was not found in the current working directory")
}

colnames <- as.character(read.table(unz("data/household_power_consumption.zip", "household_power_consumption.txt"),
                            sep=";", header=F, quote="", comment.char = '', colClasses = "character", nrows = 1))

# Directly read compressed zip file, no need to unzip - use unz function 
# Each day has 1440 minutes, two days 2880 minutes
# 1/2/2007 starts at row 66638, therefore we can 'skip = 66637' lines and read 'nrows = 2880' rows
data <- read.table(unz("data/household_power_consumption.zip", "household_power_consumption.txt"),
           na.strings = "?", sep=";", header=F, quote="", comment.char = '',
           colClasses = c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"),
           col.names = colnames,
           skip = 66637, nrows = 2880)  # read 2-day (2880) observations, skip the first 66637 (up to 31/1/2007)


