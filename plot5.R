
library(ggplot2)

# load data
message('loading summarySCC_PM25.rds')
NEI <- readRDS("summarySCC_PM25.rds")
message('loading Source_Classification_Code.rds')
SCC <- readRDS("Source_Classification_Code.rds")
NEI$type<- as.factor(NEI$type)


vehicles<-SCC[grepl('^Highway Vehicle',SCC$SCC.Level.Two),1]
# get the SCC code (column 1) from Highway Vehicle sources
# ignore off-highway vehicles, as these consist of gas/diesel powered equipment rather than traditional vehicles

veh_emiss<- NEI[(NEI$SCC %in% vehicles) & (NEI$fips == 24510),]
totals<-aggregate(Emissions ~ year,veh_emiss,sum)

g<-ggplot(aes(year,Emissions),data=totals,na.rm=true)
labels<-labs(x='year',y='Emissions (tons)',title='PM2.5 Emissions from Vehicles in Baltimore City')
g + geom_point(size=3,colour='red') + labels + stat_smooth(method='lm',lty=2,fullrange=TRUE) 



# looks good - matches the on-road data from plot3



