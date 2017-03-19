dat <- read.csv("el6383-project/el6383-project/udp_0delay_100mBW-1.txt")
cnames <- c("time", "srcip", "srcport", "dstip", 
            "dstport", "id", "interval", "data", 
            "tput")
names(dat) <- cnames
dat$case <- "case1"
dat$bandwidth <- 100
dat$delay <- 0
dat$drop <- 0
all <- dat
dat <- read.csv("el6383-project/el6383-project/udp_0delay_500mBW-1.txt")
names(dat) <- cnames
dat$case <- "case1"
dat$bandwidth <- 500
dat$delay <- 0
dat$drop <- 0
all <- rbind(all, dat)
dat <- read.csv("el6383-project/el6383-project/udp_0delay_1000mBW-1.txt")
names(dat) <- cnames
dat$case <- "case1"
dat$bandwidth <- 1000
dat$delay <- 0
dat$drop <- 0
all <- rbind(all, dat)
dat <- read.csv("el6383-project/el6383-project/udp_50delay_100mBW_0loss.txt")
names(dat) <- cnames
dat$case <- "case2"
dat$bandwidth <- 100
dat$delay <- 50
dat$drop <- 0
all <- rbind(all, dat)
dat <- read.csv("el6383-project/el6383-project/udp_50delay_500mBW_0loss.txt")
names(dat) <- cnames
dat$case <- "case2"
dat$bandwidth <- 500
dat$delay <- 50
dat$drop <- 0
all <- rbind(all, dat)
dat <- read.csv("el6383-project/el6383-project/udp_50delay_1000mBW_0loss.txt")
names(dat) <- cnames
dat$case <- "case2"
dat$bandwidth <- 1000
dat$delay <- 50
dat$drop <- 0
all <- rbind(all, dat)
dat <- read.csv("el6383-project/el6383-project/udp_0delay_100mBW_0.01loss.txt")
names(dat) <- cnames
dat$case <- "case3"
dat$bandwidth <- 100
dat$delay <- 0
dat$drop <- 0.01
all <- rbind(all, dat)
dat <- read.csv("el6383-project/el6383-project/udp_0delay_500mBW_0.01loss.txt")
names(dat) <- cnames
dat$case <- "case3"
dat$bandwidth <- 500
dat$delay <- 0
dat$drop <- 0.01
all <- rbind(all, dat)
dat <- read.csv("el6383-project/el6383-project/udp_0delay_1000mBW_0.01loss.txt")
names(dat) <- cnames
dat$case <- "case3"
dat$bandwidth <- 1000
dat$delay <- 0
dat$drop <- 0.01
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
q <- q + geom_point(aes(x=bandwidth, y=tput, colour=case))
q <- q + geom_line(aes(x=bandwidth, y=tput, colour=case, linetype=case))

q <- q + scale_y_continuous("Throughput (bps)")
q <- q + ggtitle("Boxplot of UDP for different cases")
q