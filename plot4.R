# This R script is designed to load the household power consumption data
#  and then create plot 4 as a png file

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

# create plot 4

# open png file
png(file="plot4.png", width=480, height=480)

# change par setting to make 4 plots in 1
old.par <- par(mfrow=c(2,2))

# 1st plot
with(hpc1, plot(Global_active_power ~ datetime, type="l",
                ylab="Global Active Power",
                xlab=""))

# 2nd plot
with(hpc1, plot(Voltage ~ datetime, type="l"), xlab="")

# 3rd plot
with(hpc1, plot(Sub_metering_1 ~ datetime, type="l",
                ylab="Energy sub metering",
                xlab=""))
with(hpc1, lines(Sub_metering_2 ~ datetime, col="red"))
with(hpc1, lines(Sub_metering_3 ~ datetime, col="blue"))
legend("topright", lty=1, col = c("black", "red", "blue"), bty="n",
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# 4th plot
with(hpc1, plot(Global_reactive_power ~ datetime, type="l"), xlab="")

# write and close png file
dev.off()

# restore to original par setting
par(old.par)