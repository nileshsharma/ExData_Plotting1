##Reading the data from the text file as characters
total_data<- read.table("household_power_consumption.txt",header=TRUE,sep=";",colClasses= "character")

##Subsetting the data
sub_data<-subset(total_data,total_data[,1] == "1/2/2007" | total_data[,1] == "2/2/2007")

##Conversion of variables from character to date, time, and numeric
sub_data[,2] <- paste(sub_data[,1],sub_data[,2],sep=" ",collapse=NULL)
dtime <- strptime(sub_data[,2],format='%d/%m/%Y %H:%M:%S')
sub_data[,1]<-as.Date(sub_data[,1],format='%d/%m/%Y')
for( i in 3:9){
  sub_data[,i]<- as.numeric(sub_data[,i])
}

##Generating the plot
png(filename = "plot3.png",width = 480, height = 480)

plot(dtime,sub_data[,7],type="l",xlab="",ylab="Energy sub metering")
lines(dtime,sub_data[,8],type="l",xlab="",col="red")
lines(dtime,sub_data[,9],type="l",xlab="",col="blue")
legend("topright",lty=c(1,1,1),col=c("black","red","blue"),legend=c("sub_metering_1","sub_metering_2","sub_metering_3"))
axis(side =2, lwd=2)
axis.POSIXct(dtime, side=1, lwd=2)

dev.off()
