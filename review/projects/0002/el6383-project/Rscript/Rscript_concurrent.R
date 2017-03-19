dat <- read.csv("el6383-project/el6383-project/concurrent_tcp.txt")
cnames <- c("time", "srcip", "srcport", "dstip", 
            "dstport", "id", "interval", "data", 
            "tput")
names(dat) <- cnames
dat$case <- "TCP"
dat$bandwidth <- 100
dat$delay <- 0
dat$drop <- 0
all <- dat
dat <- read.csv("el6383-project/el6383-project/concurrent_udp.txt")
names(dat) <- cnames
dat$case <- "UDP"
dat$bandwidth <- 100
dat$delay <- 0
dat$drop <- 0
all <- rbind(all, dat)
all$case <- as.factor(all$case)
library(reshape2)
all <- transform(all, interval = colsplit(interval,"-", names = c('begin', 'end')))
all$interval.begin <- all$interval$begin
all$interval.end <- all$interval$end
all$interval <- NULL
totals  <- all[all$interval.begin<=1 & all$interval.end>=10,]
details <- all[!(all$interval.begin<=1 & all$interval.end>=10),]
library(ggplot2)
q <- ggplot(details)
q <- q + geom_point(aes(x=interval.begin, y=tput, colour=case))
q <- q + geom_line(aes(x=interval.begin, y=tput, colour=case, linetype=case))
q <- q + scale_x_discrete("Time")
q <- q + scale_y_continuous("Throughput (bps)")
q <- q + ggtitle("Boxplot for concurrent flows")
q