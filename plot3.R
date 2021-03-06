## if necessary, install and load lubridate package

install.packages("lubridate")
library(lubridate)


## store URL of file to be downloaded

fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
destination <- "file.zip"

## download file, unzip and read into R as variable "u"

download.file(fileURL, destination, method = "curl")
u <- read.table(unz(destination, "household_power_consumption.txt"), sep = ";", header = TRUE, na.strings = "?", stringsAsFactors = FALSE)

## Merge date and time using lubridate

u$date_time <- dmy_hms(paste(u$Date, u$Time))

## convert Date and Time character variables to date and time

u$Date <- dmy(u$Date)
u$Time <- hms(u$Time)

## subset dataframe to include certain date range

v <- u[u$Date >= "2007-01-31" & u$Date <= "2007-02-02",]

## add a column to indicate the weekday of the row date

v$Weekday <- wday(v$Date, label = TRUE, abbrev = TRUE)

## chech the first six rows of data

head(v)

## remove any NAs

w <- v[complete.cases(v), ]

## plot chart 3

with(w, plot(w$date_time, w$Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = NA, cex.lab = 0.8, cex.axis = 0.8))
lines(w$date_time, w$Sub_metering_2, type = "l", col = "red")
lines(w$date_time, w$Sub_metering_3, type = "l", col = "blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3" ), col = c("black", "red", "blue"), cex = 0.8, lty = c(1,1,1), lwd = c(2.5, 2.5, 2.5))
dev.copy(png, file = "plot3.png", height = 480, width = 480, units ="px")
dev.off()




