# read in all data, recognize '?' as NA
rawdata <- read.csv(file="household_power_consumption.txt",sep=";",na.strings = "?")

# convert to date/time
alldata <- mutate(rawdata,
                  datetime = strptime(paste(as.character(Date),as.character(Time),sep=" "), "%d/%m/%Y %H:%M:%S"))hist(twodays$Global_active_power,col="red",main="Global Active Power",xlab="Global Active Power (kilowatts)",ylab="Frequency")


# select only days of interest
end_time   <- strptime("02/02/2007 23:59:59",format="%d/%m/%Y %H:%M:%S")
begin_time <- strptime("01/02/2007 00:00:00",format="%d/%m/%Y %H:%M:%S")
twodays <- subset(alldata,datetime >= begin_time & datetime < end_time)

# open plot device
png(filename="plot1.png",width=480,height=480)

# make the histogram
hist(twodays$Global_active_power,col="red",main="Global Active Power",xlab="Global Active Power (kilowatts)",ylab="Frequency")

# close the plot device, creating the .png file
dev.off()
