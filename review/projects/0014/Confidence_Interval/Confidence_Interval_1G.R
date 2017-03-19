dat2 <- read.csv("el6383-project/Throughput/Throughput_TCP_1G_0ms_20KB.txt")
str(dat2)
cnames <- c("time", "srcip", "srcport", "dstip", 
            "dstport", "id", "interval", "data", 
            "tput")
names(dat2) <- cnames
dat2$Packet <- 20000
dat2$bandwidth <- 1000000000
dat2$flowtype <- "TCP"
mean(dat2$tput)
var(dat2$tput)
length(dat2$tput)
range(dat2$tput)
all2 <- dat2



dat2 <- read.csv("el6383-project/Throughput/Throughput_TCP_1G_0ms_40KB.txt")
names(dat2) <- cnames
dat2$Packet <- 40000
dat2$bandwidth <- 1000000000
dat2$flowtype <- "TCP"
all2 <- rbind(all2, dat2)


dat2 <- read.csv("el6383-project/Throughput/Throughput_TCP_1G_0ms_60KB.txt")
names(dat2) <- cnames
dat2$Packet <- 60000
dat2$bandwidth <- 1000000000
dat2$flowtype <- "TCP"
all2 <- rbind(all2, dat2)

dat2 <- read.csv("el6383-project/Throughput/Throughput_UDP_1G_0ms_20KB.txt")
names(dat2) <- cnames
dat2$Packet <- "20000"
dat2$bandwidth <- 1000000000
dat2$flowtype <- "UDP"
all2 <- rbind(all2, dat2)

dat2 <- read.csv("el6383-project/Throughput/Throughput_UDP_1G_0ms_40KB.txt")
names(dat2) <- cnames
dat2$Packet <- "40000"
dat2$bandwidth <- 1000000000
dat2$flowtype <- "UDP"
all2 <- rbind(all2, dat2)

dat2 <- read.csv("el6383-project/Throughput/Throughput_UDP_1G_0ms_60KB.txt")
names(dat2) <- cnames
dat2$Packet <- 60000
dat2$bandwidth <- 1000000000
dat2$flowtype <- "UDP"
all2 <- rbind(all2, dat2)

all2$Packet <- as.factor(all2$Packet)
str(all2)

library(reshape2)
all2 <- transform(all2, interval = colsplit(interval,"-", names = c('begin', 'end')))
all2$interval.begin <- all2$interval$begin
all2$interval.end <- all2$interval$end
all2$interval <- NULL
all2$interval.begin
all2$interval.end 
totals  <- all2[all2$interval.begin<=1 & all2$interval.end>=10,]
details <- all2[!(all2$interval.begin<=1 & all2$interval.end>=10),]

## Summarizes data.
## Gives count, mean, standard deviation, standard error of the mean, and confidence interval (default 95%).
##   data: a data frame.
##   measurevar: the name of a column that contains the variable to be summariezed
##   groupvars: a vector containing names of columns that contain grouping variables
##   na.rm: a boolean that indicates whether to ignore NA's
##   conf.interval: the percent range of the confidence interval (default is 95%)
summarySE <- function(data=NULL, measurevar, groupvars=NULL, na.rm=FALSE,
                      conf.interval=.95, .drop=TRUE) {
  library(plyr)
  
  # New version of length which can handle NA's: if na.rm==T, don't count them
  length2 <- function (x, na.rm=FALSE) {
    if (na.rm) sum(!is.na(x))
    else       length(x)
  }
  
  # This does the summary. For each group's data frame, return a vector with
  # N, mean, and sd
  datac <- ddply(data, groupvars, .drop=.drop,
                 .fun = function(xx, col) {
                   c(N    = length2(xx[[col]], na.rm=na.rm),
                     mean = mean   (xx[[col]], na.rm=na.rm),
                     sd   = sd     (xx[[col]], na.rm=na.rm)
                   )
                 },
                 measurevar
  )
  
  # Rename the "mean" column    
  datac <- rename(datac, c("mean" = measurevar))
  
  datac$se <- datac$sd / sqrt(datac$N)  # Calculate standard error of the mean
  
  # Confidence interval multiplier for standard error
  # Calculate t-statistic for confidence interval: 
  # e.g., if conf.interval is .95, use .975 (above/below), and use df=N-1
  ciMult <- qt(conf.interval/2 + .5, datac$N-1)
  datac$ci <- datac$se * ciMult
  
  return(datac)
}

sum <- summarySE(details, measurevar="tput", groupvars=c("flowtype", "interval.begin"), na.rm=TRUE)
sum

sum2 <- sum
sum2$interval.begin <- factor(sum2$interval.begin)

library(ggplot2)
pd <- position_dodge(0.1)

q2 <- ggplot(sum2, aes(x=interval.begin, y=tput, fill=flowtype)) + 
  geom_bar(position=position_dodge(), stat="identity",
           colour="black", # Use black outlines,
           size=.3) +      # Thinner lines
  geom_errorbar(aes(ymin=tput-ci, ymax=tput+ci),
                size=.3,    # Thinner lines
                width=.2,
                position=position_dodge(.9)) +
  xlab("interval.begin") +
  ylab("Throughput") +
  scale_fill_hue(name="Flowtype", # Legend label, use darker colors
                 breaks=c("TCP", "UDP")) +
  ggtitle("Confidence intervals for throughputs of TCP and UDP") +
  theme_bw()
q2
ggsave("TCP_UDP_Confidence_Interval_1G.png", plot=q2)