dat <- read.csv("/users/******/project/client2testoutputs/2_cubic_output.txt")
cnames <- c("time", "srcip", "srcport", "dstip", 
            "dstport", "id", "interval", "data", 
            "tput")
names(dat) <- cnames
dat$tcp <- "cubic"
dat$capacity <- 100
dat$rtt <- 0
dat$trial <- 1
all <- dat

dat <- read.csv("/users/******/project/client1testoutputs/1_hs_cubic_output.txt")
cnames <- c("time", "srcip", "srcport", "dstip", 
            "dstport", "id", "interval", "data", 
            "tput")
names(dat) <- cnames
dat$tcp <- "hs"
dat$capacity <- 100
dat$rtt <- 0
dat$trial <- 1
all <- rbind(all, dat)

all$trial <- as.factor(all$trial)
all$tcp <- as.factor(all$tcp)

library(reshape2)
all <- transform(all, interval = colsplit(interval,"-", names = c('begin', 'end')))
all$interval.begin <- all$interval$begin
all$interval.end <- all$interval$end
all$interval <- NULL
totals  <- all[all$interval.begin<=1 & all$interval.end>=10,]
details <- all[!(all$interval.begin<=1 & all$interval.end>=10),]
library(ggplot2)

q <- ggplot(details)
q <- q + geom_point(aes(x=interval.begin, y=tput, colour=tcp))
q <- q + geom_line(aes(x=interval.begin, y=tput, colour=tcp))
q

q <- q + scale_x_discrete("time")
q <- q + scale_y_continuous("Throughput (bps)")
q <- q + ggtitle("Cubic and HS under UDP")
q
ggsave("hs-cubic-final.png", plot=q)


dat <- read.csv("/users/******/project/client2testoutputs/2_scalable_output.txt")
cnames <- c("time", "srcip", "srcport", "dstip", 
            "dstport", "id", "interval", "data", 
            "tput")
names(dat) <- cnames
dat$tcp <- "scalable"
dat$capacity <- 100
dat$rtt <- 0
dat$trial <- 1
all <- dat

dat <- read.csv("/users/******/project/client1testoutputs/1_hs_scalable_output.txt")
cnames <- c("time", "srcip", "srcport", "dstip", 
            "dstport", "id", "interval", "data", 
            "tput")
names(dat) <- cnames
dat$tcp <- "hs"
dat$capacity <- 100
dat$rtt <- 0
dat$trial <- 1
all <- rbind(all, dat)

all$trial <- as.factor(all$trial)
all$tcp <- as.factor(all$tcp)

library(reshape2)
all <- transform(all, interval = colsplit(interval,"-", names = c('begin', 'end')))
all$interval.begin <- all$interval$begin
all$interval.end <- all$interval$end
all$interval <- NULL
totals  <- all[all$interval.begin<=1 & all$interval.end>=10,]

details <- all[!(all$interval.begin<=1 & all$interval.end>=10),]
library(ggplot2)

q <- ggplot(details)
q <- q + geom_point(aes(x=interval.begin, y=tput, colour=tcp))
q <- q + geom_line(aes(x=interval.begin, y=tput, colour=tcp))
q

q <- q + scale_x_discrete("time")
q <- q + scale_y_continuous("Throughput (bps)")
q <- q + ggtitle("Scalable and HS under UDP")
q
ggsave("hs-scalable-final.png", plot=q)

dat <- read.csv("/users/******/project/client2testoutputs/1_reno_output.txt")
cnames <- c("time", "srcip", "srcport", "dstip", 
            "dstport", "id", "interval", "data", 
            "tput")
names(dat) <- cnames
dat$tcp <- "reno"
dat$capacity <- 100
dat$rtt <- 0
dat$trial <- 1
all <- dat

dat <- read.csv("/users/******/project/client1testoutputs/1_hs_reno_output.txt")
cnames <- c("time", "srcip", "srcport", "dstip", 
            "dstport", "id", "interval", "data", 
            "tput")
names(dat) <- cnames
dat$tcp <- "hs"
dat$capacity <- 100
dat$rtt <- 0
dat$trial <- 1
all <- rbind(all, dat)

all$trial <- as.factor(all$trial)
all$tcp <- as.factor(all$tcp)

library(reshape2)
all <- transform(all, interval = colsplit(interval,"-", names = c('begin', 'end')))
all$interval.begin <- all$interval$begin
all$interval.end <- all$interval$end
all$interval <- NULL
totals  <- all[all$interval.begin<=1 & all$interval.end>=10,]
details <- all[!(all$interval.begin<=1 & all$interval.end>=10),]
library(ggplot2)

q <- ggplot(details)
q <- q + geom_point(aes(x=interval.begin, y=tput, colour=tcp))
q <- q + geom_line(aes(x=interval.begin, y=tput, colour=tcp))
q

q <- q + scale_x_discrete("time")
q <- q + scale_y_continuous("Throughput (bps)")
q <- q + ggtitle("reno and HS under UDP")
q
ggsave("hs-reno-final.png", plot=q)