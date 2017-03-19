dat <- read.csv("el6383/Results/Cubic-flow4-1.txt")
str(dat)

cnames <- c("time", "srcip", "srcport", "dstip",
            "dstport", "id", "interval", "data",
            "tput")
names(dat) <- cnames
dat$tput

dat$tcp <- "cubic"
dat$capacity <- 100
dat$flows <- 4
all <- dat

dat <- read.csv("el6383/Results/Cubic-8-1.txt")
names(dat) <- cnames
dat$tcp <- "cubic"
dat$capacity <- 100
dat$flows <- 8
all <- rbind(all, dat)

dat <- read.csv("el6383/Results/Cubic-flow-12.txt")
names(dat) <- cnames
dat$tcp <- "cubic"
dat$capacity <- 100
dat$flows <- 12
all <- rbind(all, dat)

dat <- read.csv("el6383-project-dsb402/Results/Dctcp-flow-4.txt")
names(dat) <- cnames
dat$tcp <- "DCTCP"
dat$capacity <- 100
dat$flows <- 4
all <- rbind(all, dat)

dat <- read.csv("el6383/Results/Dctcp-flow-8.txt")
names(dat) <- cnames
dat$tcp <- "DCTCP"
dat$capacity <- 100
dat$flows <- 8
all <- rbind(all, dat)

dat <- read.csv("el6383/Results/Dctcp-flow-12.txt")
names(dat) <- cnames
dat$tcp <- "DCTCP"
dat$capacity <- 100
dat$flows <- 12
all <- rbind(all, dat)







all$tcp <- as.factor(all$tcp)
all$flows <- as.factor(all$flows)
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
q <- q + geom_line(aes(x=interval.begin, y=tput, colour=tcp, linetype=flows))
q