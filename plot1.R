## To download file "household power consumption" and plot the following:
## histogram of the global active power

# downloaing and extracting file
temp=tempfile()
downloadurl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
filedwnld<-download.file(downloadurl,temp,mode="wb")
Ass1<-unz(temp,"household_power_consumption.txt")
data1<-read.table(Ass1,skip=66300,nrows=5000)
unlink(temp)

##data1<-read.table("Ass1.txt",skip=66300,nrows=5000)

#Appropriately reformatting the data set into a data frame
data2<-apply(data1,1,strsplit,split=";")
my_matrix <- matrix((unlist(data2)), nrow = nrow(data1), ncol =length(data2[[1]][[1]]), byrow = TRUE)
my_data<-data.frame(my_matrix)
colnames(my_data)=c("Date","time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")

my_data$Date<-as.Date(my_data$Date, format = "%d/%m/%Y")
my_data<-my_data[my_data$Date %in% c(as.Date("2007-02-01"),as.Date("2007-02-02")),]
print(my_data)

# plotting the values of Gobal active power from 01/02/2007 to 02/02/2007
png(file="plot1.png",width=480,height=480)

hist(as.numeric(paste(my_data$Global_active_power)),col="red",main="Global Active Power",xlab="Global Active Pwer(kilowatts",ylab="Frequency")



dev.off()