# import data into R from file, convert first column to date format
household_power_consumption <- read.table("household_power_consumption.txt", sep=";", quote="\"", stringsAsFactors=FALSE)
household_power_consumption$V1 <- as.Date(household_power_consumption$V1, format = "%d/%m/%Y")

# set date limits
date1 <- as.Date("2007-02-01", format = "%Y-%m-%d")
date2 <- as.Date("2007-02-02", format = "%Y-%m-%d")

#subset household_power to include only data from date1 to date2 & create a new DateTime column 
#which combines Date and Time columns
household_power_subset <- subset (household_power_consumption, V1 >= date1 & V1 <= date2)
household_power_subset$DateTime <- strptime(paste(household_power_subset$V1, household_power_subset$V2), "%Y-%m-%d %H:%M:%S") 

## create and output plot3.png showing 4 plots: 
## 1. Global Active Power, 2. Voltage, 3. Energy sub metering, 4. Global Reactive Power
png(file = "plot4.png", width = 480, height = 480)
par(mfrow = c(2, 2), mar = c(4, 5, 3, 3)) 

plot (household_power_subset$DateTime, household_power_subset$V3, type="l", xlab = "DateTime", ylab = "Global Active Power (kilowatts)")

plot (household_power_subset$DateTime, household_power_subset$V5, type="l", xlab = "DateTime", ylab = "Voltage")

with(household_power_subset, plot(DateTime, V7, ylab = "Energy sub metering", xlab = "DateTime", type="n"))
with(household_power_subset, lines(DateTime, V7))
with(household_power_subset, lines(DateTime, V8, col ="red"))
with(household_power_subset, lines(DateTime, V9, col ="blue"))
legend("topright", col = c("black", "blue", "red"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

plot (household_power_subset$DateTime, household_power_subset$V4, type="l", xlab = "DateTime", ylab = "Global Reactive Power")
dev.off()
