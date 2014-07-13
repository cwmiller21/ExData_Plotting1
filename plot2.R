# This R script is designed to load the household power consumption data
#  and then create plot 2 as a png file

# options
options(stringsAsFactors=FALSE, show.signif.stars = FALSE)

# load data
hpc <- read.table("household_power_consumption.txt", header=TRUE, sep=";",
           na.string="?")

# subset data to include only dates 2007-02-01 and 2007-02-02

# change Date to date format
hpc$Date <- as.Date(hpc$Date, "%d/%m/%Y")
str(hpc)

doc <- unique(hpc$Date)[48:49]
doc
hpc1 <- subset(hpc, Date %in% doc)

# remove large data
rm(hpc)

# add time component to date
hpc1$datetime <- with(hpc1, as.POSIXct(paste(Date, Time, sep=" ")))
str(hpc1)

# create plot 2
with(hpc1, plot(Global_active_power ~ datetime, type="l",
                ylab="Global Active Power (kilowatts)",
                xlab=""))

# copy plot from screen display to png file format
dev.copy(png, file="plot2.png", width=480, height=480)
dev.off(4) # close png but leave screen display active