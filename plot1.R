

# load data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# sum up all emissions by year
# (total emissions of all types from all measured locations)

totals<-aggregate(Emissions ~ year,NEI,sum)


# make a plot
# annotate with title and axis labels
message('writing plot1.png')
png('plot1.png')
with(totals,
    {
        plot(year,Emissions/1.0e6,ylab='PM 2.5 Emissions (millions of tons)',type='n')
        points(year,Emissions/1.0e6,col='red',pch=19)
        title(main="PM2.5 emissions vs year")
        abline(lm(Emissions/1.0e6~year),lty=2,col='blue')
		legend('topright',legend=c('Total Emissions','fit line'),col=c('red','blue'),pch=c(19,NA),lty=c(NA,2))
        #title(ylab='PM 2.5 Emissions (millions of tons)')
        #title(xlab='year')

    })

dev.off()
# add a gr devices or copy line to produce a png
