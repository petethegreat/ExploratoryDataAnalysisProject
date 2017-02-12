
library(ggplot2)

# load data
message('loading summarySCC_PM25.rds')
NEI <- readRDS("summarySCC_PM25.rds")
message('loading summarySCC_PM25.rds')
SCC <- readRDS("Source_Classification_Code.rds")
NEI$type<- as.factor(NEI$type)

# create a logical vector of the entries in SCC that are coal combustion related
# (including lignite)

coalLog<- with(SCC, 
    grepl('[Cc]ombustion',SCC.Level.One) & 
    (  grepl('[Cc]oal',SCC.Level.Three)  | grepl('[Cc]oal',SCC.Level.Four) |
       grepl('[Ll]ignite',SCC.Level.Three)  | grepl('[Ll]ignite',SCC.Level.Four) 
     ) )
# 103 TRUE

# get the codes for these
coalcodes<-SCC$SCC[coalLog]

# get the total emissions

#totals<-NEI[NEI$SCC %in% coalcodes,] 
### Point plot
coaled<-NEI[NEI$SCC %in% coalcodes,]

totals<-aggregate(Emissions ~ year,coaled,sum)
# g<-ggplot(aes(factor(year),Emissions),data=totals,na.rm=true)
g<-ggplot(aes(year,Emissions),data=totals,na.rm=true)

labels<-labs(x='year',y='Emissions (tons)',title='PM2.5 Emissions across the US by year')
g + geom_point(size=3,colour='red') + labels
## add a line to this


# boxplot
# hard to see a trend
# coaled<-NEI[NEI$SCC %in% coalcodes,]

# g<-ggplot(aes(factor(year),log10(Emissions)),data=coaled,na.rm=true)

# g + geom_boxplot()




