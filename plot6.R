library (ggplot2)

# setwd("/Users/ba25714/coursera/ExploratoryDataAnalysis/CourseProject")

# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip

if (!file.exists("summarySCC_PM25.rds") & !file.exists("Source_Classification_Code.rds")) {
  fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
  download.file(fileUrl,destfile="exdata-data-NEI_data.zip",method="curl")
  unzip("exdata-data-NEI_data.zip")
}

# Read data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

vehicles <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
vehiclesSCC <- SCC[vehicles,]$SCC
vehiclesNEI <- NEI[NEI$SCC %in% vehiclesSCC,]

# Subset Baltimore
vehiclesBaltimore <- vehiclesNEI[vehiclesNEI$fips=="24510",]
vehiclesBaltimore$city <- "Baltimore City"

# Subset LA
vehiclesLA <- vehiclesNEI[vehiclesNEI$fips=="06037",]
vehiclesLA$city <- "Los Angeles County"

#combine
allVehicles <- rbind(vehiclesBaltimore,vehiclesLA)

ggp <- ggplot(allVehicles, aes(x=factor(year), y=Emissions, fill=city,label = round(Emissions,2))) +
  geom_bar(stat="identity") + 
  facet_grid(city~., scales="free") +
  ylab(expression("total PM"[2.5]*" emissions in tons")) + 
  xlab("year") +
  ggtitle(expression("Motor vehicle emission Baltimore vs Los Angeles in tons"))

print(ggp)

#png('plot6.png')

# p1 <- ggplot(aggregatedTotalByYear, aes(factor(year), Emissions))
# p1 <- p1 + geom_bar(stat="identity") +
#   xlab("year") +
#   ylab(expression('Total PM'[2.5]*" Emissions")) +
#   ggtitle('Total Emissions from auto sources in Baltimore City 1999 to 2008')
# 
# print(p1)

#dev.off()