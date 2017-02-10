library(ggplot2)

# load data
message('loading summarySCC_PM25.rds')
NEI <- readRDS("summarySCC_PM25.rds")
message('loading summarySCC_PM25.rds')
SCC <- readRDS("Source_Classification_Code.rds")
NEI$type<- as.factor(NEI$type)

# sum up all baltimore emissions by year and type
# (total emissions from Baltimore)

totals<-aggregate(Emissions ~ year+type,NEI[ NEI$fips == 24510,],sum)


# make a plot:
# specify x/y variables as aesthetics
g<-ggplot(aes(year,Emissions,colour=type),data=totals)
# add labels
labels<-labs(x='year',y='Emissions (tons)',title='PM2.5 Emissions in Baltimore by type')
# draw with points, add fit lines, and set y axis limits
g + geom_point(size=3) + stat_smooth(method='lm',lty=2)  +labels + ylim(0,2500)



