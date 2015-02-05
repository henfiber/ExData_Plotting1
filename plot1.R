# Dataset available from UC Irvine ML repo : http://archive.ics.uci.edu/ml/
# * Load data from https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
# * Got from: https://archive.ics.uci.edu/ml/datasets/Individual+household+electric+power+consumption
# Description of the dataset
# * Measurements of electric power consumption in one household with
# * a one-minute sampling rate over a period of almost 4 years.
# * Different electrical quantities and some sub-metering values are available.


# Set working directory
setwd("~/projects/datasciencespec/datasciencecoursera-projects/eda/ExData_Plotting1/")

# Directly read compressed zip file, no need to unzip - use unz function 
data <- read.table(unz("data/household_power_consumption.zip", "household_power_consumption.txt"),
                   na.strings = "?", sep=";", header =T, quote="", nrows=1000)





