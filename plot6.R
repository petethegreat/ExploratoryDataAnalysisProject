
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

# select emissions from vehicles (based on SCC code) and for the Baltimore and LA fips regions
veh_emiss<- NEI[(NEI$SCC %in% vehicles) & ((NEI$fips == "24510")|(NEI$fips == "06037")),]
# Sum emissions by year and fips code
totals<-aggregate(Emissions ~ year+fips,veh_emiss,sum)
# get relative change compared to 1999 values
totals$rel1999<-totals$Emissions

for (thefip in c("06037",'24510'))
{
    # get the 1999 value
    val1999<-totals$Emissions[totals$year==1999&totals$fips==thefip]
    # scale all years by 1999 value
    totals$rel1999[totals$fips==thefip] <-  totals$rel1999[totals$fips==thefip]/val1999*100.0

}

## plot total emissions
# g<-ggplot(aes(year,Emissions,colour=fips),data=totals,na.rm=true)
# labels<-labs(x='year',y='Emissions (tons)',title='PM2.5 Emissions from Vehicles in Baltimore and Los Angeles')

# plot emissions relative to 1999
g<-ggplot(aes(year,rel1999,colour=fips,shape=fips),data=totals,na.rm=true)
labels<-labs(x='year',y='change in Emissions from 1999 levels (%)',title='Change in PM2.5 Emissions from Vehicles in Baltimore and Los Angeles')

thelegend<-scale_colour_discrete(name='City',breaks=c("24510","06037"),labels=c('Baltimore','Los Angeles')) #+
thelegend2<- scale_shape_discrete(name='City',breaks=c("24510","06037"),labels=c('Baltimore','Los Angeles'),solid=F)

fits<-stat_smooth(method='lm',lty=2,fill=NA)
theplot<-g + geom_point(size=3) + labels + thelegend + thelegend2 + fits #+ ylim(0,120)
# save plot
message('writing plot6.png')
png('plot6.png')
print(theplot)
dev.off()


 # stat_smooth(method='lm',lty=2,fullrange=TRUE) 
# draw with points, add fit lines, and set y axis limits



# looks good - matches the on-road data from plot3



