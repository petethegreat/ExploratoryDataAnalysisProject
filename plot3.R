library(ggplot2)

# load data
message('loading summarySCC_PM25.rds')
NEI <- readRDS("summarySCC_PM25.rds")
message('loading summarySCC_PM25.rds')
SCC <- readRDS("Source_Classification_Code.rds")
NEI$type<- as.factor(NEI$type)

# sum up all emissions by year
# (total emissions of all types from all measured locations)

totals<-aggregate(Emissions ~ year+type,NEI[ NEI$fips == 24510,],sum)


# make a plot
# annotate with title and axis labels
g<-ggplot(aes(year,Emissions,colour=type),data=totals)

g + geom_point()

# with(totals,
#     {
#         plot(year,Emissions/1.0e6,ylab='PM 2.5 Emissions (millions of tons)',type='n')
#         points(year,Emissions/1.0e6,col='red',pch=19)
#         title(main="Baltimore City PM2.5 emissions vs year")
#         abline(lm(Emissions/1.0e6~year),lty=2,col='blue')
# 		legend('topright',legend=c('Total Emissions','fit line'),col=c('red','blue'),pch=c(19,NA),lty=c(NA,2))
#
#         #title(ylab='PM 2.5 Emissions (millions of tons)')
#         #title(xlab='year')
#
#     })
