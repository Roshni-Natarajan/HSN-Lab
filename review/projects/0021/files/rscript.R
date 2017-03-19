dat <- read.csv("el6383-project2142/files/ping.txt")
names(dat) <- c('output')
dat$size <- 0
dat$from <- c('unknown')
dat$icmp_req <- 0
dat$ttl <- 0
dat$time <- 0
dat$case <- c('unknown')
dat <- dat[1:(dim(dat)[1]-6),]
library(reshape2)
dat <- transform(dat, output = colsplit(output,"time=", names = c('other', 'time')))
dat$time <- dat$output$time
dat$output <- dat$output$other
dat <- transform(dat, time = colsplit(time," ", names = c('time', 'unit')))
dat$time <- dat$time$time
dat <- transform(dat, output = colsplit(output,"ttl=", names = c('other', 'ttl')))
dat$ttl <- dat$output$ttl
dat$output <- dat$output$other
dat <- transform(dat, output = colsplit(output,": icmp_req=", names = c('other', 'icmp_req')))
dat$icmp_req <- dat$output$icmp_req
dat$output <- dat$output$other
dat <- transform(dat, output = colsplit(output,"bytes from ", names = c('size', 'from')))
dat$size <- dat$output$size
dat$from <- dat$output$from
dat$output <- NULL
dat[which(dat$icmp_req %% 31 == 1),]$case <- "with flowsetup"
dat[-which(dat$icmp_req %% 31 == 1),]$case <- "without flowsetup"
library(plyr)
dat_ds <- ddply(dat, .(case), summarise, mean = mean(time), median = median(time), sd = sd(time))
library(ggplot2)
q <- ggplot(dat_ds) + geom_bar(stat="identity", aes(x=case, y=mean, fill=factor(case), width=0.7))
q <- q + scale_y_continuous("RTT(ms)") + scale_x_discrete("") + ggtitle("SDN with controller in Wisconsin InstaGENI, switch and hosts in NYU InstaGENI") + theme(plot.title = element_text(size = rel(0.9)))
ggsave("barplot.png", plot=q)