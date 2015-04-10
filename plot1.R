# import data into R from file, convert first column to date format
household_power_consumption <- read.table("household_power_consumption.txt", sep=";", quote="\"", stringsAsFactors=FALSE)
household_power_consumption$V1 <- as.Date(household_power_consumption$V1, format = "%d/%m/%Y")

# set date limits
date1 <- as.Date("2007-02-01", format = "%Y-%m-%d")
date2 <- as.Date("2007-02-02", format = "%Y-%m-%d")

#subset data.frame to include data from date1 to date2
household_power_subset <- subset (household_power_consumption, V1 >= date1 & V1 <= date2)
        
png(file="plot1.png")
hist (as.numeric(household_power_subset$V3), col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")
dev.off()