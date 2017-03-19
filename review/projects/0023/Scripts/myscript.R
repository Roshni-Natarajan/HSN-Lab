dat <- read.csv("el6383/Results/Cubic-50-1.txt")
str(dat)

cnames <- c("time", "srcip", "srcport", "dstip",
            "dstport", "id", "interval", "data",
            "tput")
names(dat) <- cnames
dat$tput

dat$tcp <- "cubic"
dat$capacity <- 100
dat$rtt <- 100
all <- dat

dat <- read.csv("el6383/Results/Cubic-100-1.txt")
names(dat) <- cnames
dat$tcp <- "cubic"
dat$capacity <- 100
dat$rtt <- 200
all <- rbind(all, dat)

dat <- read.csv("el6383/Results/Cubic-200-1.txt")
names(dat) <- cnames
dat$tcp <- "cubic"
dat$capacity <- 100
dat$rtt <- 400
all <- rbind(all, dat)

dat <- read.csv("el6383-project-dsb402/Results/Dctcp-rtt-50.txt")
names(dat) <- cnames
dat$tcp <- "DCTCP"
dat$capacity <- 100
dat$rtt <- 100
all <- rbind(all, dat)

dat <- read.csv("el6383/Results/Dctcp-rtt-100.txt")
names(dat) <- cnames
dat$tcp <- "DCTCP"
dat$capacity <- 100
dat$rtt <- 200
all <- rbind(all, dat)

dat <- read.csv("el6383/Results/Dctcp-rtt-200.txt")
names(dat) <- cnames
dat$tcp <- "DCTCP"
dat$capacity <- 100
dat$rtt <- 400
all <- rbind(all, dat)







all$tcp <- as.factor(all$tcp)
all$rtt <- as.factor(all$rtt)
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
q <- q + geom_line(aes(x=interval.begin, y=tput, colour=tcp, linetype=rtt))
q