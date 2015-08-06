
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

## plot the first chart

with(w, hist(w$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)", cex.lab = 0.8, cex.axis = 0.8, cex.main = 0.8))

## save as a .png file

dev.copy(png, file = "plot1.png", height = 480, width = 480, units ="px")
dev.off()

