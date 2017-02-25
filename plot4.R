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
png(filename="plot4.png",width=480,height=480)

# set up for multiplot
par(mfcol=c(2,2))

# make the line plot
with (twodays,plot(datetime,Global_active_power,type="l",xlab="",ylab="Global Active Power (kilowatts)"))

# make the plot of sub_metering
plot(twodays$datetime,twodays$Sub_metering_1,type="n",xlab="",ylab="Energy/ sub metering")
points(twodays$datetime,twodays$Sub_metering_1,col="black",type="l")
points(twodays$datetime,twodays$Sub_metering_2,col="red",type="l")
points(twodays$datetime,twodays$Sub_metering_3,col="blue",type="l")
legend("topright",col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=c(1,1,1))

# make the plot of voltage
with(twodays,plot(datetime,Voltage,type="l"))

# make the plot of reactive power
with(twodays,plot(datetime,Global_reactive_power,type="l"))

# close the plot device, creating the .png file
dev.off()
