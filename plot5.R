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

autoSubset <- NEI[grepl("auto", SCC$Short.Name, ignore.case=TRUE),]
baltimoreAuto <- subset(autoSubset,fips=="24510")
aggregatedTotalByYear <- aggregate(Emissions ~ year, autoSubset, sum)

png('plot5.png')

p1 <- ggplot(aggregatedTotalByYear, aes(factor(year), Emissions))
p1 <- p1 + geom_bar(stat="identity") +
  xlab("year") +
  ylab(expression('Total PM'[2.5]*" Emissions")) +
  ggtitle('Total Emissions from auto sources in Baltimore City 1999 to 2008')

print(p1)

dev.off()