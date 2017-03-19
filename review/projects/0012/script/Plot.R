library(reshape2)
library(ggplot2)

cnames <- c("A", "B", "C", "D", "E", "icmp_req", "G", "latency", "I")

dat <- read.csv("project-el6383/data/off1m_1",head= FALSE ,sep=" ")
names(dat) <- cnames
dat$Scheduling <- "Default"
dat$capacity <-"1MB"
dat$trial <- 1
n <- nrow(dat)
dat <- dat[-n+3:-n,]
dat$icmp_req <- as.factor(dat$icmp_req)
dat$latency <- as.factor(dat$latency)
dat$A<-NULL
dat$B<-NULL
dat$C<-NULL
dat$D<-NULL
dat$E<-NULL
dat$G<-NULL
dat$I<-NULL
dat <- dat[-1,]
off1m_1 <- dat
names(off1m_1) <- c("time", "latency", "Scheduling", "capacity", "trail")
off1m_1$time <- gsub("[^0-9]", "", off1m_1$time)
off1m_1$latency <- gsub("[^0-9 .]", "", off1m_1$latency)

#######################################################################


dat <- read.csv("project-el6383/data/off1m_2",head= FALSE ,sep=" ")
names(dat) <- cnames
dat$Scheduling <- "Default"
dat$capacity <-"1MB"
dat$trial <- 2
n <- nrow(dat)
dat <- dat[-n+3:-n,]
dat$icmp_req <- as.factor(dat$icmp_req)
dat$latency <- as.factor(dat$latency)
dat$A<-NULL
dat$B<-NULL
dat$C<-NULL
dat$D<-NULL
dat$E<-NULL
dat$G<-NULL
dat$I<-NULL
dat <- dat[-1,]
off1m_2 <- dat
names(off1m_2) <- c("time", "latency", "Scheduling", "capacity", "trail")
off1m_2$time <- gsub("[^0-9]", "", off1m_2$time)
off1m_2$latency <- gsub("[^0-9 .]", "", off1m_2$latency)

#######################################################################
  
  
dat <- read.csv("project-el6383/data/off1m_3",head= FALSE ,sep=" ")
names(dat) <- cnames
dat$Scheduling <- "Default"
dat$capacity <-"1MB"
dat$trial <- 3
n <- nrow(dat)
dat <- dat[-n+3:-n,]
dat$icmp_req <- as.factor(dat$icmp_req)
dat$latency <- as.factor(dat$latency)
dat$A<-NULL
dat$B<-NULL
dat$C<-NULL
dat$D<-NULL
dat$E<-NULL
dat$G<-NULL
dat$I<-NULL
dat <- dat[-1,]
off1m_3 <- dat
names(off1m_3) <- c("time", "latency", "Scheduling", "capacity", "trail")
off1m_3$time <- gsub("[^0-9]", "", off1m_3$time)
off1m_3$latency <- gsub("[^0-9 .]", "", off1m_3$latency)



#######################################################################


dat <- read.csv("project-el6383/data/off1m_4",head= FALSE ,sep=" ")
names(dat) <- cnames
dat$Scheduling <- "Default"
dat$capacity <-"1MB"
dat$trial <- 4
n <- nrow(dat)
dat <- dat[-n+3:-n,]
dat$icmp_req <- as.factor(dat$icmp_req)
dat$latency <- as.factor(dat$latency)
dat$A<-NULL
dat$B<-NULL
dat$C<-NULL
dat$D<-NULL
dat$E<-NULL
dat$G<-NULL
dat$I<-NULL
dat <- dat[-1,]
off1m_4 <- dat
names(off1m_4) <- c("time", "latency", "Scheduling", "capacity", "trail")
off1m_4$time <- gsub("[^0-9]", "", off1m_4$time)
off1m_4$latency <- gsub("[^0-9 .]", "", off1m_4$latency)



#######################################################################

dat <- read.csv("project-el6383/data/off100m_1",head= FALSE ,sep=" ")
names(dat) <- cnames
dat$Scheduling <- "Default"
dat$capacity <-"100MB"
dat$trial <- 1
n <- nrow(dat)
dat <- dat[-n+3:-n,]
dat$icmp_req <- as.factor(dat$icmp_req)
dat$latency <- as.factor(dat$latency)
dat$A<-NULL
dat$B<-NULL
dat$C<-NULL
dat$D<-NULL
dat$E<-NULL
dat$G<-NULL
dat$I<-NULL
dat <- dat[-1,]
off100m_1 <- dat
names(off100m_1) <- c("time", "latency", "Scheduling", "capacity", "trail")
off100m_1$time <- gsub("[^0-9]", "", off100m_1$time)
off100m_1$latency <- gsub("[^0-9 .]", "", off100m_1$latency)



#######################################################################

dat <- read.csv("project-el6383/data/off100m_2",head= FALSE ,sep=" ")
names(dat) <- cnames
dat$Scheduling <- "Default"
dat$capacity <-"100MB"
dat$trial <- 2
n <- nrow(dat)
dat <- dat[-n+3:-n,]
dat$icmp_req <- as.factor(dat$icmp_req)
dat$latency <- as.factor(dat$latency)
dat$A<-NULL
dat$B<-NULL
dat$C<-NULL
dat$D<-NULL
dat$E<-NULL
dat$G<-NULL
dat$I<-NULL
dat <- dat[-1,]
off100m_2 <- dat
names(off100m_2) <- c("time", "latency", "Scheduling", "capacity", "trail")
off100m_2$time <- gsub("[^0-9]", "", off100m_2$time)
off100m_2$latency <- gsub("[^0-9 .]", "", off100m_2$latency)



#######################################################################

dat <- read.csv("project-el6383/data/off100m_3",head= FALSE ,sep=" ")
names(dat) <- cnames
dat$Scheduling <- "Default"
dat$capacity <-"100MB"
dat$trial <- 3
n <- nrow(dat)
dat <- dat[-n+3:-n,]
dat$icmp_req <- as.factor(dat$icmp_req)
dat$latency <- as.factor(dat$latency)
dat$A<-NULL
dat$B<-NULL
dat$C<-NULL
dat$D<-NULL
dat$E<-NULL
dat$G<-NULL
dat$I<-NULL
dat <- dat[-1,]
off100m_3 <- dat
names(off100m_3) <- c("time", "latency", "Scheduling", "capacity", "trail")
off100m_3$time <- gsub("[^0-9]", "", off100m_3$time)
off100m_3$latency <- gsub("[^0-9 .]", "", off100m_3$latency)



#######################################################################

dat <- read.csv("project-el6383/data/off100m_4",head= FALSE ,sep=" ")
names(dat) <- cnames
dat$Scheduling <- "Default"
dat$capacity <-"100MB"
dat$trial <- 4
n <- nrow(dat)
dat <- dat[-n+3:-n,]
dat$icmp_req <- as.factor(dat$icmp_req)
dat$latency <- as.factor(dat$latency)
dat$A<-NULL
dat$B<-NULL
dat$C<-NULL
dat$D<-NULL
dat$E<-NULL
dat$G<-NULL
dat$I<-NULL
dat <- dat[-1,]
off100m_4 <- dat
names(off100m_4) <- c("time", "latency", "Scheduling", "capacity", "trail")
off100m_4$time <- gsub("[^0-9]", "", off100m_4$time)
off100m_4$latency <- gsub("[^0-9 .]", "", off100m_4$latency)






#######################################################################




dat <- read.csv("project-el6383/data/on1m_1",head= FALSE ,sep=" ")
names(dat) <- cnames
dat$Scheduling <- "SFQ"
dat$capacity <-"1MB"
dat$trial <- 1
n <- nrow(dat)
dat <- dat[-n+3:-n,]
dat$icmp_req <- as.factor(dat$icmp_req)
dat$latency <- as.factor(dat$latency)
dat$A<-NULL
dat$B<-NULL
dat$C<-NULL
dat$D<-NULL
dat$E<-NULL
dat$G<-NULL
dat$I<-NULL
dat <- dat[-1,]
on1m_1 <- dat
names(on1m_1) <- c("time", "latency", "Scheduling", "capacity", "trail")
on1m_1$time <- gsub("[^0-9]", "", on1m_1$time)
on1m_1$latency <- gsub("[^0-9 .]", "", on1m_1$latency)

#######################################################################


dat <- read.csv("project-el6383/data/on1m_2",head= FALSE ,sep=" ")
names(dat) <- cnames
dat$Scheduling <- "SFQ"
dat$capacity <-"1MB"
dat$trial <- 2
n <- nrow(dat)
dat <- dat[-n+3:-n,]
dat$icmp_req <- as.factor(dat$icmp_req)
dat$latency <- as.factor(dat$latency)
dat$A<-NULL
dat$B<-NULL
dat$C<-NULL
dat$D<-NULL
dat$E<-NULL
dat$G<-NULL
dat$I<-NULL
dat <- dat[-1,]
on1m_2 <- dat
names(on1m_2) <- c("time", "latency", "Scheduling", "capacity", "trail")
on1m_2$time <- gsub("[^0-9]", "", on1m_2$time)
on1m_2$latency <- gsub("[^0-9 .]", "", on1m_2$latency)

#######################################################################


dat <- read.csv("project-el6383/data/on1m_3",head= FALSE ,sep=" ")
names(dat) <- cnames
dat$Scheduling <- "SFQ"
dat$capacity <-"1MB"
dat$trial <- 3
n <- nrow(dat)
dat <- dat[-n+3:-n,]
dat$icmp_req <- as.factor(dat$icmp_req)
dat$latency <- as.factor(dat$latency)
dat$A<-NULL
dat$B<-NULL
dat$C<-NULL
dat$D<-NULL
dat$E<-NULL
dat$G<-NULL
dat$I<-NULL
dat <- dat[-1,]
on1m_3 <- dat
names(on1m_3) <- c("time", "latency", "Scheduling", "capacity", "trail")
on1m_3$time <- gsub("[^0-9]", "", on1m_3$time)
on1m_3$latency <- gsub("[^0-9 .]", "", on1m_3$latency)



#######################################################################


dat <- read.csv("project-el6383/data/on1m_4",head= FALSE ,sep=" ")
names(dat) <- cnames
dat$Scheduling <- "SFQ"
dat$capacity <-"1MB"
dat$trial <- 4
n <- nrow(dat)
dat <- dat[-n+3:-n,]
dat$icmp_req <- as.factor(dat$icmp_req)
dat$latency <- as.factor(dat$latency)
dat$A<-NULL
dat$B<-NULL
dat$C<-NULL
dat$D<-NULL
dat$E<-NULL
dat$G<-NULL
dat$I<-NULL
dat <- dat[-1,]
on1m_4 <- dat
names(on1m_4) <- c("time", "latency", "Scheduling", "capacity", "trail")
on1m_4$time <- gsub("[^0-9]", "", on1m_4$time)
on1m_4$latency <- gsub("[^0-9 .]", "", on1m_4$latency)



#######################################################################

dat <- read.csv("project-el6383/data/on100m_1",head= FALSE ,sep=" ")
names(dat) <- cnames
dat$Scheduling <- "SFQ"
dat$capacity <-"100MB"
dat$trial <- 1
n <- nrow(dat)
dat <- dat[-n+3:-n,]
dat$icmp_req <- as.factor(dat$icmp_req)
dat$latency <- as.factor(dat$latency)
dat$A<-NULL
dat$B<-NULL
dat$C<-NULL
dat$D<-NULL
dat$E<-NULL
dat$G<-NULL
dat$I<-NULL
dat <- dat[-1,]
on100m_1 <- dat
names(on100m_1) <- c("time", "latency", "Scheduling", "capacity", "trail")
on100m_1$time <- gsub("[^0-9]", "", on100m_1$time)
on100m_1$latency <- gsub("[^0-9 .]", "", on100m_1$latency)



#######################################################################

dat <- read.csv("project-el6383/data/on100m_2",head= FALSE ,sep=" ")
names(dat) <- cnames
dat$Scheduling <- "SFQ"
dat$capacity <-"100MB"
dat$trial <- 2
n <- nrow(dat)
dat <- dat[-n+3:-n,]
dat$icmp_req <- as.factor(dat$icmp_req)
dat$latency <- as.factor(dat$latency)
dat$A<-NULL
dat$B<-NULL
dat$C<-NULL
dat$D<-NULL
dat$E<-NULL
dat$G<-NULL
dat$I<-NULL
dat <- dat[-1,]
on100m_2 <- dat
names(on100m_2) <- c("time", "latency", "Scheduling", "capacity", "trail")
on100m_2$time <- gsub("[^0-9]", "", on100m_2$time)
on100m_2$latency <- gsub("[^0-9 .]", "", on100m_2$latency)



#######################################################################

dat <- read.csv("project-el6383/data/on100m_3",head= FALSE ,sep=" ")
names(dat) <- cnames
dat$Scheduling <- "SFQ"
dat$capacity <-"100MB"
dat$trial <- 3
n <- nrow(dat)
dat <- dat[-n+3:-n,]
dat$icmp_req <- as.factor(dat$icmp_req)
dat$latency <- as.factor(dat$latency)
dat$A<-NULL
dat$B<-NULL
dat$C<-NULL
dat$D<-NULL
dat$E<-NULL
dat$G<-NULL
dat$I<-NULL
dat <- dat[-1,]
on100m_3 <- dat
names(on100m_3) <- c("time", "latency", "Scheduling", "capacity", "trail")
on100m_3$time <- gsub("[^0-9]", "", on100m_3$time)
on100m_3$latency <- gsub("[^0-9 .]", "", on100m_3$latency)



#######################################################################

dat <- read.csv("project-el6383/data/on100m_4",head= FALSE ,sep=" ")
names(dat) <- cnames
dat$Scheduling <- "SFQ"
dat$capacity <-"100MB"
dat$trial <- 4
n <- nrow(dat)
dat <- dat[-n+3:-n,]
dat$icmp_req <- as.factor(dat$icmp_req)
dat$latency <- as.factor(dat$latency)
dat$A<-NULL
dat$B<-NULL
dat$C<-NULL
dat$D<-NULL
dat$E<-NULL
dat$G<-NULL
dat$I<-NULL
dat <- dat[-1,]
on100m_4 <- dat
names(on100m_4) <- c("time", "latency", "Scheduling", "capacity", "trail")
on100m_4$time <- gsub("[^0-9]", "", on100m_4$time)
on100m_4$latency <- gsub("[^0-9 .]", "", on100m_4$latency)




#######################################################################




#plot pictures

all1m <- rbind(off1m_1, off1m_2, off1m_3, off1m_4, on1m_1, on1m_2, on1m_3, on1m_4)
all1m$trail <- as.factor(all1m$trail)
all1m$Scheduling <- as.factor(all1m$Scheduling)
all1m$latency <- as.numeric(all1m$latency)
all1m$time <- as.numeric(all1m$time)

all100m <- rbind(off100m_1, off100m_2, off100m_3, off100m_4, on100m_1, on100m_2, on100m_3, on100m_4)
all100m$trail <- as.factor(all100m$trail)
all100m$Scheduling <- as.factor(all100m$Scheduling)
all100m$latency <- as.numeric(all100m$latency)
all100m$time <- as.numeric(all100m$time)


##1m plots

average <- aggregate( latency~time+Scheduling, all1m, mean )
standard <- aggregate( latency~time+Scheduling, all1m, sd )


total1m <- average
avnames <- c("time", "Scheduling", "mean")
names(total1m) <- avnames
total1m$sd <- standard$latency
limits <- aes(x = time, ymax = mean + sd, ymin=mean - sd,colour=Scheduling)

p1m <- ggplot(total1m)
p1m <- p1m + geom_point(aes(x=time, y=mean, colour=Scheduling))
p1m <- p1m + geom_errorbar(limits, width=0.2 )
p1m <- p1m + scale_x_continuous("Time(s)")
p1m <- p1m + scale_y_continuous("Latency (ms)")
p1m <- p1m + ggtitle("Latency over Time in 1Mbps Network")
ggsave("all1m_mean&sd.png", plot=p1m)
print(p1m)


v1m <- ggplot(all1m)
v1m <- v1m + geom_violin(aes(x=Scheduling, y=latency))
v1m <- v1m + scale_y_continuous("Latency")
v1m <- v1m + ggtitle("Violin Plot of Latency in 1Mbps Network")
ggsave("all1m_violin.png", plot=v1m)
print(v1m)


##100m plots

average <- aggregate( latency~time+Scheduling, all100m, mean )
standard <- aggregate( latency~time+Scheduling, all100m, sd )


total100m <- average
avnames <- c("time", "Scheduling", "mean")
names(total100m) <- avnames
total100m$sd <- standard$latency
limits <- aes(x = time, ymax = mean + sd, ymin=mean - sd,colour=Scheduling)

p100m <- ggplot(total100m)
p100m <- p100m + geom_point(aes(x=time, y=mean, colour=Scheduling))
p100m <- p100m + geom_errorbar(limits, width=0.2 )
p100m <- p100m + scale_x_continuous("Time(s)")
p100m <- p100m + scale_y_continuous("Latency (ms)")
p100m <- p100m + ggtitle("Latency over Time in 100Mbps Network")
ggsave("all100m_mean&sd.png", plot=p100m)
print(p100m)


v100m <- ggplot(all100m)
v100m <- v100m + geom_violin(aes(x=Scheduling, y=latency))
v100m <- v100m + scale_y_continuous("Latency")
v100m <- v100m + ggtitle("Violin Plot of Latency in 100Mbps Network")
ggsave("all100m_violin.png", plot=v100m)
print(v100m)


##all plots
alldetail <- rbind(all1m, all100m)
average_bar <- aggregate( latency~capacity+Scheduling, alldetail, mean )
standard_bar <- aggregate( latency~capacity+Scheduling, alldetail, sd )


bar_all <- average_bar
names(bar_all) <- c("Link_capacity", "Scheduling", "Average_latency")
bar_all$sd <- standard_bar$latency
bar_limits <- aes(x = Link_capacity, ymax = Average_latency + sd, ymin=Average_latency - sd, colour=Scheduling)



b_all <- ggplot(bar_all, aes(x=Link_capacity, y=Average_latency, fill=Scheduling))
b_all <- b_all + geom_errorbar(bar_limits, width=0.2, position = position_dodge(width = 0.90) )
b_all <- b_all + geom_bar(stat = "identity", position="dodge", alpha = 1/2)
b_all <- b_all + ggtitle("Bar Plot of Average Latency")
ggsave("b_all_bar.png", plot=b_all)
print(b_all)








