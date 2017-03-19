dat2 <- read.csv("el6383-project/Throughput/Throughput_TCP_100M_50ms_20KB.txt")
str(dat2)
cnames <- c("time", "srcip", "srcport", "dstip", 
            "dstport", "id", "interval", "data", 
            "tput")
names(dat2) <- cnames
dat2$Packet <- 20000
dat2$bandwidth <- 100000000
dat2$flowtype <- "TCP"
mean(dat2$tput)
var(dat2$tput)
length(dat2$tput)
range(dat2$tput)
all2 <- dat2



dat2 <- read.csv("el6383-project/Throughput/Throughput_TCP_100M_50ms_40KB.txt")
names(dat2) <- cnames
dat2$Packet <- 40000
dat2$bandwidth <- 100000000
dat2$flowtype <- "TCP"
all2 <- rbind(all2, dat2)


dat2 <- read.csv("el6383-project/Throughput/Throughput_TCP_100M_50ms_60KB.txt")
names(dat2) <- cnames
dat2$Packet <- 60000
dat2$bandwidth <- 100000000
dat2$flowtype <- "TCP"
all2 <- rbind(all2, dat2)


dat2 <- read.csv("el6383-project/Throughput/Throughput_UDP_100M_50ms_20KB.txt")
names(dat2) <- cnames
dat2$Packet <- 20000
dat2$bandwidth <- 100000000
dat2$flowtype <- "UDP"
all2 <- rbind(all2, dat2)


dat2 <- read.csv("el6383-project/Throughput/Throughput_UDP_100M_50ms_40KB.txt")
names(dat2) <- cnames
dat2$Packet <- "40000"
dat2$bandwidth <- 100000000
dat2$flowtype <- "UDP"
all2 <- rbind(all2, dat2)

dat2 <- read.csv("el6383-project/Throughput/Throughput_UDP_100M_50ms_60KB.txt")
names(dat2) <- cnames
dat2$Packet <- 60000
dat2$bandwidth <- 100000000
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
library(ggplot2)
q2 <- ggplot(details)
q2 <- q2 + geom_point(aes(x=interval.begin, y=tput))
q2
q2 <- ggplot(details)
q2 <- q2 + geom_point(aes(x=interval.begin, y=tput, colour=Packet))
q2
q2 <- ggplot(details)
q2 <- q2 + geom_point(aes(x=interval.begin, y=tput, colour=Packet))
q2 <- q2 + geom_line(aes(x=interval.begin, y=tput, colour=Packet, linetype=flowtype))
q2
ggsave("Throughput_TCP_UDP_100M_50ms.png", plot=q2)

