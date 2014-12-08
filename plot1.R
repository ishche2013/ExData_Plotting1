#First run in terminlal to get subset for february data
#$ grep -e '/2/2007' household_power_consumption.txt > subset_household.txt

#install packages
install.packages("dplyr")
library(dplyr)

#read "february" subset data and assign column names
data <- read.table("subset_household.txt", sep=";", na.strings="?", stringsAsFactors = FALSE)
colnames(data) <- c("Date","Time","Global_active_power","Global_reactive_power",
                    "Voltage","Global_intensity","Sub_metering_1","Sub_metering_2",
                    "Sub_metering_3")

#subset data for first 2 days of the month 
data1 <- filter(data, as.Date(Date,"%d/%m/%Y") == "2007-02-01" | as.Date(Date,"%d/%m/%Y") == "2007-02-02")

#create desired plot and copy it to a file
hist(data1$Global_active_power, xlab="Global Active Power (kilowatts)", main="Global Active Power", col ="red")
dev.copy(png, file="plot1.png")
dev.off
