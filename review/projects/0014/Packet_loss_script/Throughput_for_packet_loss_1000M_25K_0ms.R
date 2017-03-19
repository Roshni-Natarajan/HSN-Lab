dat2 <- read.csv("el6383-project/Packet_Loss_Throughput/TCP_1000M_25K_0ms_.0001_plr.txt")
str(dat2)
cnames <- c("time", "srcip", "srcport", "dstip", 
            "dstport", "id", "interval", "data", 
            "tput")
names(dat2) <- cnames
dat2$lossrate <- .0001
dat2$bandwidth <- 1000000000
dat2$flowtype <- "TCP"
mean(dat2$tput)
var(dat2$tput)
length(dat2$tput)
range(dat2$tput)
all2 <- dat2



dat2 <- read.csv("el6383-project/Packet_Loss_Throughput/TCP_1000M_25K_0ms_.001_plr.txt")
names(dat2) <- cnames
dat2$lossrate <- .001
dat2$bandwidth <- 1000000000
dat2$flowtype <- "TCP"
all2 <- rbind(all2, dat2)


dat2 <- read.csv("el6383-project/Packet_Loss_Throughput/TCP_1000M_25K_0ms_.005_plr.txt")
names(dat2) <- cnames
dat2$lossrate <- .005
dat2$bandwidth <- 1000000000
dat2$flowtype <- "TCP"
all2 <- rbind(all2, dat2)


dat2 <- read.csv("el6383-project/Packet_Loss_Throughput/UDP_1000M_25K_0ms_.0001_plr.txt")
names(dat2) <- cnames
dat2$lossrate <- .0001
dat2$bandwidth <- 1000000000
dat2$flowtype <- "UDP"
all2 <- rbind(all2, dat2)


dat2 <- read.csv("el6383-project/Packet_Loss_Throughput/UDP_1000M_25K_0ms_.001_plr.txt")
names(dat2) <- cnames
dat2$lossrate <- .001
dat2$bandwidth <- 1000000000
dat2$flowtype <- "UDP"
all2 <- rbind(all2, dat2)

dat2 <- read.csv("el6383-project/Packet_Loss_Throughput/UDP_1000M_25K_0ms_.005_plr.txt")
names(dat2) <- cnames
dat2$lossrate <- .005
dat2$bandwidth <- 1000000000
dat2$flowtype <- "UDP"
all2 <- rbind(all2, dat2)


all2$lossrate <- as.factor(all2$lossrate)
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
q2 <- q2 + geom_point(aes(x=interval.begin, y=tput, colour=lossrate))
q2
q2 <- ggplot(details)
q2 <- q2 + geom_point(aes(x=interval.begin, y=tput, colour=lossrate))
q2 <- q2 + geom_line(aes(x=interval.begin, y=tput, colour=lossrate, linetype=flowtype))
q2
ggsave("Throughput_for_packetloss_1000M_25k_0ms.png", plot=q2)

