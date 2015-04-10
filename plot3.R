# import data into R from file, convert first column to date format
household_power_consumption <- read.table("household_power_consumption.txt", sep=";", quote="\"", stringsAsFactors=FALSE)
household_power_consumption$V1 <- as.Date(household_power_consumption$V1, format = "%d/%m/%Y")

# set date limits
date1 <- as.Date("2007-02-01", format = "%Y-%m-%d")
date2 <- as.Date("2007-02-02", format = "%Y-%m-%d")

#subset data.frame to include data from date1 to date2 & create a new DateTime column which combines Date and Time columns
household_power_subset <- subset (household_power_consumption, V1 >= date1 & V1 <= date2)
household_power_subset$DateTime <- strptime(paste(household_power_subset$V1, household_power_subset$V2), "%Y-%m-%d %H:%M:%S") 

# create and output plot3 showing watt-hours from three sub-meters
png(file = "plot3.png", width = 480, height = 480)
par(mfrow = c(1, 1), mar = c(3, 5, 2, 2)) 
with(household_power_subset, plot(DateTime, V7, ylab = "Energy sub metering", type="n"))
with(household_power_subset, lines(DateTime, V7))
with(household_power_subset, lines(DateTime, V8, col ="red"))
with(household_power_subset, lines(DateTime, V9, col ="blue"))
legend("topright", pch = 1, col = c("black", "blue", "red"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")) 
dev.off()

