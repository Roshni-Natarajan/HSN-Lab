dat <- read.csv("output_1")
 cnames <- c("time", "srcip", "srcport", "dstip", "dstport", "id", "interval", "data", 
                           "Throughput")
 names(dat) <- cnames
 dat$type <-"Reactive"
 dat$trial <- 1
 View(dat)
 all <- dat
 dat <- read.csv("output_2")
 cnames <- c("time", "srcip", "srcport", "dstip", 
                           "dstport", "id", "interval", "data", 
                           "Throughput")
 names(dat) <- cnames
 dat$type <-"Reactive"
 dat$trial <- 2
 all <- rbind(all, dat)
 View(all)
 dat <- read.csv("output_3")
 cnames <- c("time", "srcip", "srcport", "dstip", 
                           "dstport", "id", "interval", "data", 
                           "Throughput")
 names(dat) <- cnames
 dat$type <-"Reactive"
 dat$trial <- 3
 View(dat)
 all <- rbind(all, dat)
 View(all)
 dat <- read.csv("output_4")
 cnames <- c("time", "srcip", "srcport", "dstip", 
                           "dstport", "id", "interval", "data", 
                           "Throughput")
 names(dat) <- cnames
 dat$type <-"Reactive"
 dat$trial <- 4
 all <- rbind(all, dat)
dat <- read.csv("output_5")
 cnames <- c("time", "srcip", "srcport", "dstip", 
                           "dstport", "id", "interval", "data", 
                           "Throughput")
 names(dat) <- cnames
 dat$type <-"Proactive"
 dat$trial <- 1
 all <- rbind(all, dat)
 dat <- read.csv("output_6")
 cnames <- c("time", "srcip", "srcport", "dstip", 
                           "dstport", "id", "interval", "data", 
                           "Throughput")
 names(dat) <- cnames
 dat$type <-"Proactive"
 dat$trial <- 2
 all <- rbind(all, dat)
 dat <- read.csv("output_7")
 cnames <- c("time", "srcip", "srcport", "dstip", 
                           "dstport", "id", "interval", "data", 
                           "Throughput")
 names(dat) <- cnames
 dat$type <-"Proactive"
 dat$trial <- 3
 all <- rbind(all, dat)
 dat <- read.csv("output_8")
 cnames <- c("time", "srcip", "srcport", "dstip", 
                           "dstport", "id", "interval", "data", 
                           "Throughput")
 names(dat) <- cnames
 dat$type <-"Proactive"
 dat$trial <- 4
 all <- rbind(all, dat)
 library(ggplot2)
 q <- ggplot(all)
 q <- q + geom_boxplot(aes(x=type, y=Throughput))
 q <- q + scale_x_discrete("Switching Type")
 q <- q + ggtitle("Throughput measured while switching at Controller and OVS-Switch")

 ggsave("Throughput.png" , plot=q)
