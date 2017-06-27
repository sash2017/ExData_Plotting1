## To download file "household power consumption" and plot the following:
## 1. histogram of the global active power
## 2. Day vs Global active power
## 3. Day vs submetering data
## 4. Day vs. global reactive power

# Downloading file from internet
temp=tempfile()
downloadurl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
filedwnld<-download.file(downloadurl,temp,mode="wb")
Ass1<-unz(temp,"household_power_consumption.txt")
data1<-read.table(Ass1,skip=66300,nrows=5000)
unlink(temp)

#data1<-read.table("Ass1.txt",skip=66300,nrows=5000)

#Appropriately formatting the columns of the data set

data2<-apply(data1,1,strsplit,split=";")
my_matrix <- matrix((unlist(data2)), nrow = nrow(data1), ncol =length(data2[[1]][[1]]), byrow = TRUE)
my_data<-data.frame(my_matrix)
colnames(my_data)=c("Date","time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")

my_data$Date<-as.Date(my_data$Date, format = "%d/%m/%Y")
my_data<-my_data[my_data$Date %in% c(as.Date("2007-02-01"),as.Date("2007-02-02")),]
SetTime <-strptime(paste(my_data$Date, my_data$time, sep=" "),"%Y-%m-%d %H:%M:%S")

# Plotting the required data and saving to a png file
png(file="plot4.png",width=480,height=480)

par(mfrow=c(2,2))
plot(SetTime,as.numeric(paste(my_data$Global_active_power)),type="l",ylab="Global active power",xlab="")
plot(SetTime,as.numeric(paste(my_data$Voltage)),xlab="datetime",ylab="Voltage",type="l")
plot(SetTime,as.numeric(paste(my_data$Sub_metering_1)),col="black",type="l",ylab="Energy sub metering",xlab="")
lines(SetTime,as.numeric(paste(my_data$Sub_metering_2)),col="red")
lines(SetTime,as.numeric(paste(my_data$Sub_metering_3)),col="blue")
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_1"),col=c("black","red","blue"))
plot(SetTime,as.numeric(paste(my_data$Global_reactive_power)),type="l",xlab="datetime",ylab="Global Reactive Power")

dev.off()
