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

#add the column with date and time combined
data1$datetime <-paste(data1$Date, data1$Time)
data1$posixDate <-strptime(data1$datetime, "%d/%m/%Y %H:%M:%S")

#create desired plot and copy it to a file
plot(data1$posixDate, data1$Sub_metering_1, type ="l", xlab="", ylab="Energy sub metering")
lines(data1$posixDate, data1$Sub_metering_2, col="red")
lines(data1$posixDate, data1$Sub_metering_3, col="blue")
legend("topright", col=c("black","red","blue"), c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=c(1,1), lwd=c(1,1))
dev.copy(png, file="plot3.png")
dev.off
