if (!file.exists("household_power_consumption.txt")){
  unzip("exdata-data-household_power_consumption.zip");
}

pcTable <- read.table("household_power_consumption.txt", skip = 66000, nrows = 4500, sep = ";", na.strings = "?");
columnNames <- names(read.table("household_power_consumption.txt", nrows = 1, sep=";", header = TRUE));
names(pcTable) <- columnNames;

pcTable <- (pcTable[(pcTable[,1] %in% c("1/2/2007","2/2/2007")),]);

createPlot3 <- function() {
  png("plot3.png", width = 480, height = 480);
  sm1 <- pcTable[,"Sub_metering_1"];
  sm2 <- pcTable[,"Sub_metering_2"];
  sm3 <- pcTable[,"Sub_metering_3"];
  dateTime <- strptime(paste(pcTable[,1], pcTable[,2]), "%d/%m/%Y %H:%M:%S");
  plot(dateTime, sm1, type = "l", ylab = "Energy sub metering", xlab = "");
  lines(dateTime, sm2, col = "red");
  lines(dateTime, sm3, col = "blue");
  legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = 1)
  dev.off();  
}