plot1 <- function() {
  
  require(dplyr)
  
  #############################################################################
  ## Read and Subset Data
  
  ## Check if zip file exists in project folder. If not, download it.
  if(!file.exists("data.zip")) {
    courseDataURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    destFile <- "data.zip"
    download.file(courseDataURL, destFile)
  }
  
  ## Unzip data file in project folder, if not there already.
  if(!file.exists("houshold_power_consumption.txt")) {
    unzip(destFile)
  }
  
  ## Read data into R, set column names and classes accordingly.
  data_names <- c("date", "datetime", "global_active_power", "global_reactive_power", "voltage", "global_intensity", "sub_metering_1", "sub_metering_2", "sub_metering_3")
  data_classes <- c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric")
  data<-read.table(file="household_power_consumption.txt", header = TRUE, sep = ";", col.names = data_names, colClasses = dataClasses, na.strings = "?")
  data <- data %>% mutate(datetime = paste(date,datetime))
  data$date <- as.POSIXct(strptime(data$date,"%d/%m/%Y"))
  data$datetime <- as.POSIXlt(strptime(data$datetime,"%d/%m/%Y %H:%M:%S"))
  
  ## Subset for the dates specified in project (2007-02-01 and 2007-02-02)
  data <- data[data$date == "2007-02-01" | data$date == "2007-02-02",]
  
  
  #############################################################################
  ## Exploratory Graphs
  
  ## plot1: Global Active Power
  png(filename="plot1.png")
  with(data,hist(global_active_power, col="red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)", ylab = "Frequency"))
  dev.off()

  ## Don't return anything
  invisible()
  
  }