dat<-read.csv("el6383-project-mpls/submit/client/tcp_100.txt")
cnames <- c("time", "srcip", "srcport", "dstip",
"dstport", "id", "interval", "data",
"tput")
names(dat)<-cnames
dat$protocol <- "tcp"
dat$delay <- 100
dat$transfer_rate <- 1380000
NoneDown <- dat
dat<-read.csv("el6383-project-mpls/submit/client/udp_100.txt")
names(dat)<-cnames
dat$protocol <- "udp"
dat$delay <- 100
dat$transfer_rate <- 1250000
NoneDown <- rbind(NoneDown,dat)
dat<-read.csv("el6383-project-mpls/submit/client/udp_200.txt")
names(dat)<-cnames
dat$protocol <- "udp"
dat$delay <- 200
dat$transfer_rate <- 1210000
NoneDown <- rbind(NoneDown,dat)
dat<-read.csv("el6383-project-mpls/submit/client/udp_300.txt")
names(dat)<-cnames
dat$protocol <- "udp"
dat$delay <- 300
dat$transfer_rate <- 1180000
NoneDown <- rbind(NoneDown,dat)
dat<-read.csv("el6383-project-mpls/submit/client/tcp_300.txt")
names(dat)<-cnames
dat$protocol <- "tcp"
dat$delay <- 300
dat$transfer_rate <- 768000
NoneDown <- rbind(NoneDown,dat)
dat<-read.csv("el6383-project-mpls/submit/client/tcp_200.txt")
names(dat)<-cnames
dat$protocol <- "tcp"
dat$delay <- 200
dat$transfer_rate <- 896000
NoneDown <- rbind(NoneDown,dat)
p <- library(ggplot2)
p <- ggplot(NoneDown, aes(delay, tput, fill = protocol)) +
geom_bar(stat="identity", position = "dodge") +
scale_fill_brewer(palette = "Set1")
p + ggtitle("Throughput VS Delay for UDP and TCP over OSPF when all links are up")
ggsave("Plot1.png",plot=p)
q <- library(ggplot2)
q <- ggplot(NoneDown, aes(delay, transfer_rate, fill = protocol)) +
geom_bar(stat="identity", position = "dodge") +
scale_fill_brewer(palette = "Set1")
q + ggtitle("Data Transfer rate when all the links are up")
ggsave("Plot2.png",plot=q)
dat<-read.csv("el6383-project-mpls/submit/client/tcp_100_1down.txt")
names(dat)<-cnames
dat$protocol <- "tcp"
dat$delay <- 100
dat$transfer_rate <- 1380000
OneDown <- dat
dat<-read.csv("el6383-project-mpls/submit/client/udp_100_1down.txt")
names(dat)<-cnames
dat$protocol <- "udp"
dat$delay <- 100
dat$transfer_rate <- 1250000
OneDown <- rbind(OneDown,dat)
dat<-read.csv("el6383-project-mpls/submit/client/udp_200_1down.txt")
names(dat)<-cnames
dat$protocol <- "udp"
dat$delay <- 200
dat$transfer_rate <- 1210000
OneDown <- rbind(OneDown,dat)
dat<-read.csv("el6383-project-mpls/submit/client/udp_300_1down.txt")
names(dat)<-cnames
dat$protocol <- "udp"
dat$delay <- 300
dat$transfer_rate <- 1250000
OneDown <- rbind(OneDown,dat)
dat<-read.csv("el6383-project-mpls/submit/client/tcp_300_1down.txt")
names(dat)<-cnames
dat$protocol <- "tcp"
dat$delay <- 300
dat$transfer_rate <- 768000
OneDown <- rbind(OneDown,dat)
dat<-read.csv("el6383-project-mpls/submit/client/tcp_200_1down.txt")
names(dat)<-cnames
dat$protocol <- "tcp"
dat$delay <- 200
dat$transfer_rate <- 896000
OneDown <- rbind(OneDown,dat)
r <- library(ggplot2)
r <- ggplot(OneDown, aes(delay, tput, fill = protocol)) +
geom_bar(stat="identity", position = "dodge") +
scale_fill_brewer(palette = "Set1")
r + ggtitle("Throughput VS Delay for UDP and TCP over OSPF when 1 link is down")
ggsave("Plot3.png",plot=r)
s <- library(ggplot2)
s <- ggplot(NoneDown, aes(delay, transfer_rate, fill = protocol)) +
geom_bar(stat="identity", position = "dodge") +
scale_fill_brewer(palette = "Set1")
s + ggtitle("Data Transfer rate when one link is down")
ggsave("Plot4.png",plot=s)
dat<-read.csv("el6383-project-mpls/submit/client/tcp_100_2down.txt")
names(dat)<-cnames
dat$protocol <- "tcp"
dat$delay <- 100
dat$transfer_rate <- 2120000
TwoDown <- dat
dat<-read.csv("el6383-project-mpls/submit/client/udp_100_2down.txt")
names(dat)<-cnames
dat$protocol <- "udp"
dat$delay <- 100
dat$transfer_rate <- 1250000
TwoDown <- rbind(TwoDown,dat)
dat<-read.csv("el6383-project-mpls/submit/client/udp_200_2down.txt")
names(dat)<-cnames
dat$protocol <- "udp"
dat$delay <- 200
dat$transfer_rate <- 1210000
TwoDown <- rbind(TwoDown,dat)
dat<-read.csv("el6383-project-mpls/submit/client/udp_300_2down.txt")
names(dat)<-cnames
dat$protocol <- "udp"
dat$delay <- 300
dat$transfer_rate <- 1180000
TwoDown <- rbind(TwoDown,dat)
dat<-read.csv("el6383-project-mpls/submit/client/tcp_300_2down_again.txt")
names(dat)<-cnames
dat$protocol <- "tcp"
dat$delay <- 300
dat$transfer_rate <- 896000
TwoDown <- rbind(TwoDown,dat)
dat<-read.csv("el6383-project-mpls/submit/client/tcp_200_2down.txt")
names(dat)<-cnames
dat$protocol <- "tcp"
dat$delay <- 200
dat$transfer_rate <- 896000
TwoDown <- rbind(TwoDown,dat)
TwoDown$protocol <- as.factor(TwoDown$protocol)
TwoDown$delay <- as.factor(TwoDown$delay)
t <- library(ggplot2)
t <- ggplot(TwoDown, aes(delay, tput, fill = protocol)) +
geom_bar(stat="identity", position = "dodge") +
scale_fill_brewer(palette = "Set1")
t + ggtitle("Bar chart of Throughput VS Delay for UDP and TCP over OSPF when 2 links are down")
ggsave("Plot5.png",plot=t)
u <- library(ggplot2)
u <- ggplot(TwoDown, aes(delay, transfer_rate, fill = protocol)) +
geom_bar(stat="identity", position = "dodge") +
scale_fill_brewer(palette = "Set1")
u + ggtitle("Data Transfer rate when two links are down")
ggsave("Plot6.png",plot=u)
savehistory("~/el6383-project-mpls/submit/graphs/Script.R")