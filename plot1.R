if (!file.exists("household_power_consumption.txt")){
  unzip("exdata-data-household_power_consumption.zip");
}

pcTable <- read.table("household_power_consumption.txt", skip = 66000, nrows = 4500, sep = ";", na.strings = "?");
columnNames <- names(read.table("household_power_consumption.txt", nrows = 1, sep=";", header = TRUE));
names(pcTable) <- columnNames;

pcTable <- (pcTable[(pcTable[,1] %in% c("1/2/2007","2/2/2007")),]);

createPlot1 <- function() {
  png("plot1.png", width = 480, height = 480);
  glob <- pcTable[,"Global_active_power"];
  hist(glob, 
    breaks = length(floor(range(glob)[1]:range(glob)[2]))*2, 
    main = "Global Active Power", 
    xlab = "Global Active Power (kilowatts)",
    col = "red"
  );
  dev.off();
}