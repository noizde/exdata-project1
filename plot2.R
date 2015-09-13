if (!file.exists("household_power_consumption.txt")){
  unzip("exdata-data-household_power_consumption.zip");
}

pcTable <- read.table("household_power_consumption.txt", skip = 66000, nrows = 4500, sep = ";", na.strings = "?");
columnNames <- names(read.table("household_power_consumption.txt", nrows = 1, sep=";", header = TRUE));
names(pcTable) <- columnNames;

pcTable <- (pcTable[(pcTable[,1] %in% c("1/2/2007","2/2/2007")),]);

createPlot2 <- function() {
  png("plot2.png", width = 480, height = 480);
  glob <- pcTable[,"Global_active_power"];
  dateTime <- strptime(paste(pcTable[,1], pcTable[,2]), "%d/%m/%Y %H:%M:%S");
  plot(dateTime, glob, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "");
  dev.off();  
}