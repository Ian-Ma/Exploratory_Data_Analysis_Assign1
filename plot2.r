# import data into R from file
household_power_consumption <- read.table("household_power_consumption.txt", sep=";", quote="\"", stringsAsFactors=FALSE)
household_power_consumption$V1 <- as.Date(household_power_consumption$V1, format = "%d/%m/%Y")

# set date limits
date1 <- as.Date("2007-02-01", format = "%Y-%m-%d")
date2 <- as.Date("2007-02-02", format = "%Y-%m-%d")

#subset data.frame to include data from date1 to date2 & create a new DateTime column which combines Date and Time columns
household_power_subset <- subset (household_power_consumption, V1 >= date1 & V1 <= date2)
household_power_subset$DateTime <- strptime(paste(household_power_subset$V1, household_power_subset$V2), "%Y-%m-%d %H:%M:%S") 

#create and output plot2.png showing global power usage from date1 to date2
png(file = "plot2.png", width = 480, height = 480)
plot (household_power_subset$DateTime, household_power_subset$V3, type="l", xlab = "", ylab = "Global Active Power (kilowatts)")
dev.off()

