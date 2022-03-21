#download data
fileUrl = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile = "./exdata_data_household_power_consumption.zip")

#unzip data
unzip("./exdata_data_household_power_consumption.zip")

#read in data
household_power_consumption <- read.table("./household_power_consumption.txt", sep = ";", header = TRUE)

#format date
household_power_consumption$Date <- as.Date(household_power_consumption$Date, "%d/%m/%Y")

#Get data for 2007-02-01 and 2007-02-02
household_power_consumption <- household_power_consumption[household_power_consumption$Date == "2007-02-01" | 
                                                                   household_power_consumption$Date == "2007-02-02",]

#convert needed to numeric
household_power_consumption$Global_active_power <- as.numeric(household_power_consumption$Global_active_power)

#create date-time object
household_power_consumption$date_time <- paste(as.character(household_power_consumption$Date), household_power_consumption$Time)
household_power_consumption$date_time <- strptime(household_power_consumption$date_time, format = "%Y-%m-%d %H:%M:%OS")

#choose graphic device, plot, close graphic device
png(file="plot2.png")
with(household_power_consumption, plot(date_time, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (killowatts)"))
dev.off()