dat<-read.csv("Delay_1")
dat$type="Reactive"
all<-dat
dat<-read.csv("Delay_2")
dat$type="Proactive"
all <- rbind(all, dat)
library(ggplot2)
q<-ggplot(all)
q <- q + geom_boxplot(aes(x=type, y=Delay))
q <- q + scale_x_discrete("Switching Type")
q <- q + ggtitle("Delay while switching at Controller and OVS-Switch")

ggsave("Delay.png" , plot=q)
