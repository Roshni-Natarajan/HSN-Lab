# 1.load 3 trials vegas data
dat <- read.csv("dxl2015-el6383-project/output041.txt")
cnames <- c("time", "srcip", "srcport", "dstip", "dstport", "id", "interval", "data", "tput")
names(dat) <- cnames
dat$tcp <- "vegas"
dat$capacity <- 2
dat$rtt <- 2
dat$trial <- 1
LFN1 <- dat
dat <- read.csv("dxl2015-el6383-project/output042.txt")
names(dat) <- cnames
dat$tcp <- "vegas"
dat$capacity <- 2
dat$rtt <- 2
dat$trial <- 2
LFN1 <- rbind(LFN1, dat)
dat <- read.csv("dxl2015-el6383-project/output043.txt")
names(dat) <- cnames
dat$tcp <- "vegas"
dat$capacity <- 2
dat$rtt <- 2
dat$trial <- 3
LFN1 <- rbind(LFN1, dat)
# 2.load 3 trials reno data
dat <- read.csv("dxl2015-el6383-project/output151.txt")
names(dat) <- cnames
dat$tcp <- "reno"
dat$capacity <- 2
dat$rtt <- 2
dat$trial <- 1
LFN1 <- rbind(LFN1, dat)
dat <- read.csv("dxl2015-el6383-project/output152.txt")
names(dat) <- cnames
dat$tcp <- "reno"
dat$capacity <- 2
dat$rtt <- 2
dat$trial <- 2
LFN1 <- rbind(LFN1, dat)
dat <- read.csv("dxl2015-el6383-project/output153.txt")
names(dat) <- cnames
dat$tcp <- "reno"
dat$capacity <- 2
dat$rtt <- 2
dat$trial <- 3
LFN1 <- rbind(LFN1, dat)
LFN1$trial <- as.factor(LFN1$trial)
LFN1$tcp <- as.factor(LFN1$tcp)
library(reshape2)
LFN1 <- transform(LFN1, interval = colsplit(interval,"-", names = c('begin', 'end')))
LFN1$interval.begin <- LFN1$interval$begin
LFN1$interval.end <- LFN1$interval$end
LFN1$interval <- NULL
totals  <- LFN1[LFN1$interval.begin<=1 & LFN1$interval.end>=10,]
details <- LFN1[!(LFN1$interval.begin<=1 & LFN1$interval.end>=10),]
library(ggplot2)
q <- ggplot(details)
q <- q + scale_x_discrete("interval.begin")
q <- q + scale_y_continuous("Throughput (bps)")
q <- q + ggtitle("Lineplot of Throughput Vegas vs.Reno in Buffer 87BYTE")
q <- q + geom_point(aes(x=interval.begin, y=tput, colour=tcp))
q <- q + geom_line(aes(x=interval.begin, y=tput, colour=tcp, linetype=trial))
q
ggsave("Exper1_lineplot.png", plot=q)
q <- ggplot(details)
q <- q + scale_x_discrete("interbal.begin")
q <- q + scale_y_continuous("Throughput (bps)")
q <- q + ggtitle("Violinplot of Throughput Vegas vs.Reno in Buffer 87BYTE")
q <- q + geom_violin(aes(x=tcp, y=tput))
q
ggsave("Exper1_violinplot.png", plot=q)
