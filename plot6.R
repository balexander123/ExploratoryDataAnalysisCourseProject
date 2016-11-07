library (ggplot2)

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
aggregatedTotalsByYearAndCity <- aggregate(Emissions ~ year + city, allVehicles, sum)

ggp <- ggplot(aggregatedTotalsByYearAndCity, aes(x=factor(year), y=Emissions, fill=year)) +
  geom_bar(aes(fill = year), stat="identity") +
  geom_text(aes(label=round(Emissions,0)), hjust = 0.5, vjust = -0.3) +
  facet_grid(city~.) +
  ylab(expression("total PM"[2.5]*" emissions in tons")) + 
  xlab("year") +
  ggtitle(expression("Motor vehicle emission Baltimore vs Los Angeles in tons"))

png('plot6.png')

print(ggp)

dev.off()