if (!file.exists("household_power_consumption.txt")){
  unzip("exdata-data-household_power_consumption.zip");
}

pcTable <- read.table("household_power_consumption.txt", skip = 66000, nrows = 4500, sep = ";", na.strings = "?");
columnNames <- names(read.table("household_power_consumption.txt", nrows = 1, sep=";", header = TRUE));
names(pcTable) <- columnNames;

pcTable <- (pcTable[(pcTable[,1] %in% c("1/2/2007","2/2/2007")),]);

createPlot4 <- function() {
  png("plot4.png", width = 480, height = 480);
  sm1 <- pcTable[,"Sub_metering_1"];
  sm2 <- pcTable[,"Sub_metering_2"];
  sm3 <- pcTable[,"Sub_metering_3"];
  volt <- pcTable[, "Voltage"];
  active <- pcTable[, "Global_active_power"];
  reactive <- pcTable[,"Global_reactive_power"];
  dateTime <- strptime(paste(pcTable[,1], pcTable[,2]), "%d/%m/%Y %H:%M:%S");
  
  par(mfrow = c(2,2));
  
  plot(dateTime, active, ylab = "Global Active Power", xlab = "", type = "l");
  
  plot(dateTime, volt, ylab = "Voltage", xlab = "datetime", type = "l");
  
  plot(dateTime, sm1, type = "l", ylab = "Energy sub metering", xlab = "");
  lines(dateTime, sm2, col = "red");
  lines(dateTime, sm3, col = "blue");
  legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), box.lty = 0, col = c("black", "red", "blue"), lty = 1)
  
  plot(dateTime, reactive, ylab = "Global_reactive_power", xlab = "datetime", type = "l");
  
  dev.off();  
}