dat <- read.csv("data/host2_100_1.txt")
cnames <- c("time", "srcip", "srcport", "dstip",
            "dstport", "id", "interval", "data",
            "tput")
names(dat) <- cnames
dat$env <- "SDN"
dat$capacity <- 100
dat$rtt <- 100
dat$trial <- 1
dat$host <- 2
all <- dat

dat <- read.csv("data/host2_100_2.txt")
names(dat) <- cnames
dat$env <- "SDN"
dat$capacity <- 100
dat$rtt <- 100
dat$trial <- 2
dat$host <- 2
all <- rbind(all, dat)

dat <- read.csv("data/host2_100_3.txt")
names(dat) <- cnames
dat$env <- "SDN"
dat$capacity <- 100
dat$rtt <- 100
dat$trial <- 3
dat$host <- 2
all <- rbind(all, dat)

dat <- read.csv("data/normal-host2-100-10_1.txt")
names(dat) <- cnames
dat$env <- "Normal"
dat$capacity <- 100
dat$rtt <- 100
dat$trial <- 1
dat$host <- 2
all2 <- dat

dat <- read.csv("data/normal-host2-100-10_2.txt")
names(dat) <- cnames
dat$env <- "Normal"
dat$capacity <- 100
dat$rtt <- 100
dat$trial <- 2
dat$host <- 2
all2 <- rbind(all2, dat)

dat <- read.csv("data/normal-host2-100-10_3.txt")
names(dat) <- cnames
dat$env <- "Normal"
dat$capacity <- 100
dat$rtt <- 100
dat$trial <- 3
dat$host <- 2
all2 <- rbind(all2, dat)

all$env <- as.factor(all$env)
library(reshape2)
all <- transform(all, interval = colsplit(interval,"-", names = c('begin', 'end')))
all$interval.begin <- all$interval$begin
all$interval.end <- all$interval$end
all$interval <- NULL
all$interval.begin
all$interval.end

all2$env <- as.factor(all2$env)
library(reshape2)
all2 <- transform(all2, interval = colsplit(interval,"-", names = c('begin', 'end')))
all2$interval.begin <- all2$interval$begin
all2$interval.end <- all2$interval$end
all2$interval <- NULL
all2$interval.begin
all2$interval.end

dat <- read.csv("data/host3_100_1.txt")
names(dat) <- cnames
dat$env <- "SDN"
dat$capacity <- 100
dat$rtt <- 100
dat$trial <- 1
dat$host <- 3

all3 <- dat
dat <- read.csv("data/host3_100_2.txt")
names(dat) <- cnames
dat$env <- "SDN"
dat$capacity <- 100
dat$rtt <- 100
dat$trial <- 2
dat$host <- 3

all3 <- rbind(all3, dat)
dat <- read.csv("data/host3_100_3.txt")
names(dat) <- cnames
dat$env <- "SDN"
dat$capacity <- 100
dat$rtt <- 100
dat$trial <- 3
dat$host <- 3

all3 <- rbind(all3, dat)
dat <- read.csv("data/normal-host3-100-10_1.txt")
names(dat) <- cnames
dat$env <- "Normal"
dat$capacity <- 100
dat$rtt <- 100
dat$trial <- 1
dat$host <- 3

all4 <- dat
dat <- read.csv("data/normal-host3-100-10_2.txt")
names(dat) <- cnames
dat$env <- "Normal"
dat$capacity <- 100
dat$rtt <- 100
dat$trial <- 2
dat$host <- 3

all4 <- rbind(all4, dat)
dat <- read.csv("data/normal-host3-100-10_3.txt")
names(dat) <- cnames
dat$env <- "Normal"
dat$capacity <- 100
dat$rtt <- 100
dat$trial <- 3
dat$host <- 3
all4 <- rbind(all4, dat)

all3$env <- as.factor(all3$env)
library(reshape2)
all3 <- transform(all3, interval = colsplit(interval,"-", names = c('begin', 'end')))
all3$interval.begin <- all3$interval$begin
all3$interval.end <- all3$interval$end
all3$interval <- NULL
all3$interval.begin
all3$interval.end

all4$env <- as.factor(all4$env)
library(reshape2)
all4 <- transform(all4, interval = colsplit(interval,"-", names = c('begin', 'end')))
all4$interval.begin <- all4$interval$begin
all4$interval.end <- all4$interval$end
all4$interval <- NULL
all4$interval.begin
all4$interval.end

total  <- all[all$interval.begin<=1 & all$interval.end>=10,]
total2  <- all2[all2$interval.begin<=1 & all2$interval.end>=10,]
total3  <- all3[all3$interval.begin<=1 & all3$interval.end>=10,]
total4  <- all4[all4$interval.begin<=1 & all4$interval.end>=10,]


mean1 <- mean(total$tput)
mean2 <- mean(total2$tput)
mean3 <- mean(total3$tput)
mean4 <- mean(total4$tput)
tput <- c(mean1,mean2,mean3,mean4)
env <- c('SDN','Normal','SDN','Normal')
host <- c('host2','host2','host3','host3')
rtt100 <- data.frame(tput,env,host)
library(ggplot2)
q <- ggplot(rtt100)
q <- q + geom_point(aes(x=host, y=tput, colour=env))
q
ggsave("rtt100.png", plot=q)

dat <- read.csv("data/host2_200_1.txt")
cnames <- c("time", "srcip", "srcport", "dstip", 
            "dstport", "id", "interval", "data", 
            "tput")
names(dat) <- cnames
dat$env <- "SDN"
dat$capacity <- 100
dat$rtt <- 200
dat$trial <- 1
dat$host <- 2

all5 <- dat

dat <- read.csv("data/host2_200_2.txt")
names(dat) <- cnames
dat$env <- "SDN"
dat$capacity <- 100
dat$rtt <- 200
dat$trial <- 2
dat$host <- 2
all5 <- rbind(all5, dat)

dat <- read.csv("data/host2_200_3.txt")
names(dat) <- cnames
dat$env <- "SDN"
dat$capacity <- 100
dat$rtt <- 200
dat$trial <- 3
dat$host <- 2
all5 <- rbind(all5, dat)

dat <- read.csv("data/normal-host2-200-10_1.txt")
names(dat) <- cnames
dat$env <- "Normal"
dat$capacity <- 100
dat$rtt <- 200
dat$trial <- 1
dat$host <- 2
all6 <- dat

dat <- read.csv("data/normal-host2-200-10_2.txt")
names(dat) <- cnames
dat$env <- "Normal"
dat$capacity <- 100
dat$rtt <- 200
dat$trial <- 2
dat$host <- 2
all6 <- rbind(all6, dat)

dat <- read.csv("data/normal-host2-200-10_3.txt")
names(dat) <- cnames
dat$env <- "Normal"
dat$capacity <- 100
dat$rtt <- 200
dat$trial <- 3
dat$host <- 2
all6 <- rbind(all6, dat)

all5$env <- as.factor(all5$env)
library(reshape2)
all5 <- transform(all5, interval = colsplit(interval,"-", names = c('begin', 'end')))
all5$interval.begin <- all5$interval$begin
all5$interval.end <- all5$interval$end
all5$interval <- NULL
all5$interval.begin
all5$interval.end

all6$env <- as.factor(all6$env)
library(reshape2)
all6 <- transform(all6, interval = colsplit(interval,"-", names = c('begin', 'end')))
all6$interval.begin <- all6$interval$begin
all6$interval.end <- all6$interval$end
all6$interval <- NULL
all6$interval.begin
all6$interval.end


dat <- read.csv("data/host3_200_1.txt")
names(dat) <- cnames
dat$env <- "SDN"
dat$capacity <- 100
dat$rtt <- 200
dat$trial <- 1
dat$host <- 3
all7 <- dat

dat <- read.csv("data/host3_200_2.txt")
names(dat) <- cnames
dat$env <- "SDN"
dat$capacity <- 100
dat$rtt <- 200
dat$trial <- 2
dat$host <- 3
all7 <- rbind(all7, dat)

dat <- read.csv("data/host3_200_3.txt")
names(dat) <- cnames
dat$env <- "SDN"
dat$capacity <- 100
dat$rtt <- 200
dat$trial <- 3
dat$host <- 3
all7 <- rbind(all7, dat)

dat <- read.csv("data/normal-host3-200-10_1.txt")
names(dat) <- cnames
dat$env <- "Normal"
dat$capacity <- 100
dat$rtt <- 200
dat$trial <- 1
dat$host <- 3
all8 <- dat

dat <- read.csv("data/normal-host3-200-10_2.txt")
names(dat) <- cnames
dat$env <- "Normal"
dat$capacity <- 100
dat$rtt <- 200
dat$trial <- 2
dat$host <- 3
all8 <- rbind(all8, dat)

dat <- read.csv("data/normal-host3-200-10_3.txt")
names(dat) <- cnames
dat$env <- "Normal"
dat$capacity <- 100
dat$rtt <- 200
dat$trial <- 3
dat$host <- 3
all8 <- rbind(all8, dat)


all7$env <- as.factor(all7$env)
library(reshape2)
all7 <- transform(all7, interval = colsplit(interval,"-", names = c('begin', 'end')))
all7$interval.begin <- all7$interval$begin
all7$interval.end <- all7$interval$end
all7$interval <- NULL
all7$interval.begin
all7$interval.end

all8$env <- as.factor(all8$env)
library(reshape2)
all8 <- transform(all8, interval = colsplit(interval,"-", names = c('begin', 'end')))
all8$interval.begin <- all8$interval$begin
all8$interval.end <- all8$interval$end
all8$interval <- NULL
all8$interval.begin
all8$interval.end

total5  <- all5[all5$interval.begin<=1 & all5$interval.end>=10,]
total6  <- all6[all6$interval.begin<=1 & all6$interval.end>=10,]
total7  <- all7[all7$interval.begin<=1 & all7$interval.end>=10,]
total8  <- all8[all8$interval.begin<=1 & all8$interval.end>=10,]

mean5 <- mean(total5$tput)
mean6 <- mean(total6$tput)
mean7 <- mean(total7$tput)
mean8 <- mean(total8$tput)

tput <- c(mean5,mean6,mean7,mean8)
env <- c('SDN','Normal','SDN','Normal')
host <- c('host2','host2','host3','host3')
rtt200 <- data.frame(tput,env,host)

library(ggplot2)
q <- ggplot(rtt200)
q <- q + geom_point(aes(x=host, y=tput, colour=env))
q
ggsave("rtt200.png", plot=q)




