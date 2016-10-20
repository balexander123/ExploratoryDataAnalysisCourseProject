# setwd("/Users/ba25714/coursera/ExploratoryDataAnalysis/CourseProject")

# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip

if (!file.exists("summarySCC_PM25.rds") & !file.exists("Source_Classification_Code.rds")) {
  fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
  download.file(fileUrl,destfile="exdata-data-NEI_data.zip",method="curl")
  unzip("exdata-data-NEI_data.zip")
}

# Read data
NEI <- readRDS("summarySCC_PM25.rds")

# Question 1: Have total emissions from PM2.5 decreased in the United States from 1999 to 2008?
# Using the base plotting system, make a plot showing the total PM2.5 emission from all sources
# for each of the years 1999, 2002, 2005, and 2008.

baltimoreCity <- subset(NEI,fips=="24510")
aggregatedEmissionsByYear <- aggregate(Emissions ~ year, baltimoreCity, sum)

png('plot2.png')
barplot(height=aggregatedEmissionsByYear$Emissions, names.arg=aggregatedEmissionsByYear$year,
        xlab="years", ylab=expression('total PM'[2.5]*' emission'),
        main=expression('Total PM'[2.5]*' Baltimore City emissions per year'))
dev.off()
