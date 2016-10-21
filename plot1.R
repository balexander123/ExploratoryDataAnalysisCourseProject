# setwd("/Users/ba25714/coursera/ExploratoryDataAnalysis/CourseProject")

# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip

if (!file.exists("summarySCC_PM25.rds") & !file.exists("Source_Classification_Code.rds")) {
  fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
  download.file(fileUrl,destfile="exdata-data-NEI_data.zip",method="curl")
  unzip("exdata-data-NEI_data.zip")
}

# Read data
NEI <- readRDS("summarySCC_PM25.rds")

aggregatedEmissionsByYear <- aggregate(Emissions ~ year, NEI, sum)

png('plot1.png')
barplot(height=aggregatedEmissionsByYear$Emissions, names.arg=aggregatedEmissionsByYear$year,
        xlab="years", ylab=expression('total PM'[2.5]*' emission'),
        main=expression('Total PM'[2.5]*' emissions per year'))
dev.off()
