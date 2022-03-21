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

#choose graphic device, plot, close graphic device
png(file="plot1.png")
with(household_power_consumption, hist(Global_active_power, main = "Global Active Power", 
                                       xlab = "Global Active Power (killowatts)", col = "red"))
dev.off()