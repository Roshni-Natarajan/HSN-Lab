dat <- read.csv("project/client1outputs/1_hs_reno_output.txt")
cnames <- c("time", "srcip", "srcport", "dstip", 
            "dstport", "id", "interval", "data", 
            "tput")
names(dat) <- cnames
dat$tcp <- "highspeed-reno”
dat$capacity <- 100
dat$rtt <- 0
dat$trial <- 1
all <- dat
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
q <- q + geom_point(aes(x=interval.begin, y=tput))
q <- ggplot(details)
q <- q + geom_point(aes(x=interval.begin, y=tput))
q <- q + geom_line(aes(x=interval.begin, y=tput))
q
q <- q + scale_x_discrete("time")
q <- q + scale_y_continuous("Throughput (bps)")
q <- q + ggtitle("Highspeed under the influence of reno and UDP")
q
ggsave("hs-reno.png", plot=q)
