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
household_power_consumption$Sub_metering_1 <- as.numeric(household_power_consumption$Sub_metering_1)
household_power_consumption$Sub_metering_2 <- as.numeric(household_power_consumption$Sub_metering_2)
household_power_consumption$Sub_metering_3 <- as.numeric(household_power_consumption$Sub_metering_3)
household_power_consumption$Voltage <- as.numeric(household_power_consumption$Voltage)
household_power_consumption$Global_reactive_power <- as.numeric(household_power_consumption$Global_reactive_power)

#create date-time object
household_power_consumption$date_time <- paste(as.character(household_power_consumption$Date), household_power_consumption$Time)
household_power_consumption$date_time <- strptime(household_power_consumption$date_time, format = "%Y-%m-%d %H:%M:%OS")

#choose graphic device
png(file="plot4.png")

#set up 2 rows and 2 columns for plots
par(mfrow = c(2,2))

#top-left plot
with(household_power_consumption, plot(date_time, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power"))

#top-right plot
with(household_power_consumption, plot(date_time, Voltage, type = "l", xlab = "datetime", ylab = "Voltage"))

# bottom-left plot -prepare for plotting
x <- household_power_consumption$date_time
y1 <- household_power_consumption$Sub_metering_1
y2 <- household_power_consumption$Sub_metering_2
y3 <- household_power_consumption$Sub_metering_3

#plot
plot(x, y1, type = "l", ylab = "Energy sub metering", xlab = "")
lines(x, y2, type = "l", col = "red")
lines(x, y3, type = "l", col = "blue")
legend("topright", inset = 0.01, legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = 1, box.lty = 0)

#bottom-right
with(household_power_consumption, plot(date_time, Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power"))

#turn off graphic device
dev.off()