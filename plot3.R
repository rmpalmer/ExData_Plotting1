# read in all data, recognize '?' as NA
rawdata <- read.csv(file="household_power_consumption.txt",sep=";",na.strings = "?")

# convert to date/time
alldata <- mutate(rawdata,
                  datetime = strptime(paste(as.character(Date),as.character(Time),sep=" "), "%d/%m/%Y %H:%M:%S"))


# select only days of interest
end_time   <- strptime("02/02/2007 23:59:59",format="%d/%m/%Y %H:%M:%S")
begin_time <- strptime("01/02/2007 00:00:00",format="%d/%m/%Y %H:%M:%S")
twodays <- subset(alldata,datetime >= begin_time & datetime < end_time)

# open plot device
png(filename="plot3.png",width=480,height=480)

# plot empty plot - note that sub metering 1 has largest y range...
plot(twodays$datetime,twodays$Sub_metering_1,type="n",xlab="",ylab="Engergy/ sub metering")

# add the lines
points(twodays$datetime,twodays$Sub_metering_1,col="black",type="l")
points(twodays$datetime,twodays$Sub_metering_2,col="red",type="l")
points(twodays$datetime,twodays$Sub_metering_3,col="blue",type="l")

# add the legend
legend("topright",col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=c(1,1,1))

# close the plot device, creating the .png file
dev.off()
