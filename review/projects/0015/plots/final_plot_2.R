dat <- read.csv("el6383/datafiles/output/ryu_s16_1000h.txt")
dat$controller <- "ryu" 
cnames <-c("red","controller")
names(dat) <- cnames
dat <- dat [-c(10),]
final <- transform(dat, interval = colsplit(red,"=", names = c('switch', 'f/s')))
final <- transform(final, interval = colsplit(interval.f.s,"per", names = c('fpersec', 'f/s')))
final$interval.switch <- NULL
final$interval.f.s.1 <- NULL
final$interval.f.s <- NULL
final$red <- "16"
final$Flows_per_Second <- mean(final$interval.fpersec)
final$MACs <- 1000
cnames <- c("No_of_Switches","Controller","Flows_trials","Flows_per_Second","MAC's")
names(final) <- cnames
a=mean(final$Flows_per_Second)*1000
final$Flows_per_Second <- a

all <- final



dat <- read.csv("el6383/datafiles/output/ryu_s16_10000h.txt")
dat$controller <- "ryu" 
cnames <-c("red","controller")
names(dat) <- cnames
dat <- dat [-c(10),]
final <- transform(dat, interval = colsplit(red,"=", names = c('switch', 'f/s')))
final <- transform(final, interval = colsplit(interval.f.s,"per", names = c('fpersec', 'f/s')))
final$interval.switch <- NULL
final$interval.f.s.1 <- NULL
final$interval.f.s <- NULL
final$red <- "16"
final$Flows_per_Second <- mean(final$interval.fpersec)
final$MACs <- 10000
cnames <- c("No_of_Switches","Controller","Flows_trials","Flows_per_Second","MAC's")
names(final) <- cnames
a=mean(final$Flows_per_Second)*1000
final$Flows_per_Second <- a


all <- rbind(all,final)



dat <- read.csv("el6383/datafiles/output/ryu_s16_100000h.txt")
dat$controller <- "ryu" 
cnames <-c("red","controller")
names(dat) <- cnames
dat <- dat [-c(10),]
final <- transform(dat, interval = colsplit(red,"=", names = c('switch', 'f/s')))
final <- transform(final, interval = colsplit(interval.f.s,"per", names = c('fpersec', 'f/s')))
final$interval.switch <- NULL
final$interval.f.s.1 <- NULL
final$interval.f.s <- NULL
final$red <- "16"
final$Flows_per_Second <- mean(final$interval.fpersec)
final$MACs <- 100000
cnames <- c("No_of_Switches","Controller","Flows_trials","Flows_per_Second","MAC's")
names(final) <- cnames
a=mean(final$Flows_per_Second)*1000
final$Flows_per_Second <- a


all <- rbind(all,final)




dat <- read.csv("el6383/datafiles/output/ryu_s16_1000000h.txt")
dat$controller <- "ryu" 
cnames <-c("red","controller")
names(dat) <- cnames
dat <- dat [-c(10),]
final <- transform(dat, interval = colsplit(red,"=", names = c('switch', 'f/s')))
final <- transform(final, interval = colsplit(interval.f.s,"per", names = c('fpersec', 'f/s')))
final$interval.switch <- NULL
final$interval.f.s.1 <- NULL
final$interval.f.s <- NULL
final$red <- "16"
final$Flows_per_Second <- mean(final$interval.fpersec)
final$MACs <- 1000000
cnames <- c("No_of_Switches","Controller","Flows_trials","Flows_per_Second","MAC's")
names(final) <- cnames
a=mean(final$Flows_per_Second)*1000
final$Flows_per_Second <- a


all <- rbind(all,final)



dat <- read.csv("el6383/datafiles/output/pox_s16_1000h_t.txt")
dat$controller <- "pox" 
cnames <-c("red","controller")
names(dat) <- cnames
dat <- dat [-c(10),]
final <- transform(dat, interval = colsplit(red,"=", names = c('switch', 'f/s')))
final <- transform(final, interval = colsplit(interval.f.s,"per", names = c('fpersec', 'f/s')))
final$interval.switch <- NULL
final$interval.f.s.1 <- NULL
final$interval.f.s <- NULL
final$red <- "16"
final$Flows_per_Second <- mean(final$interval.fpersec)
final$MACs <- 1000
cnames <- c("No_of_Switches","Controller","Flows_trials","Flows_per_Second","MAC's")
names(final) <- cnames
a=mean(final$Flows_per_Second)*1000
final$Flows_per_Second <- a


all <- rbind(all,final)



dat <- read.csv("el6383/datafiles/output/pox_s16_10000h_t.txt")
dat$controller <- "pox" 
cnames <-c("red","controller")
names(dat) <- cnames
dat <- dat [-c(10),]
final <- transform(dat, interval = colsplit(red,"=", names = c('switch', 'f/s')))
final <- transform(final, interval = colsplit(interval.f.s,"per", names = c('fpersec', 'f/s')))
final$interval.switch <- NULL
final$interval.f.s.1 <- NULL
final$interval.f.s <- NULL
final$red <- "16"
final$Flows_per_Second <- mean(final$interval.fpersec)
final$MACs <- 10000
cnames <- c("No_of_Switches","Controller","Flows_trials","Flows_per_Second","MAC's")
names(final) <- cnames
a=mean(final$Flows_per_Second)*1000
final$Flows_per_Second <- a


all <- rbind(all,final)



dat <- read.csv("el6383/datafiles/output/pox_s16_100000h_t.txt")
dat$controller <- "pox" 
cnames <-c("red","controller")
names(dat) <- cnames
dat <- dat [-c(10),]
final <- transform(dat, interval = colsplit(red,"=", names = c('switch', 'f/s')))
final <- transform(final, interval = colsplit(interval.f.s,"per", names = c('fpersec', 'f/s')))
final$interval.switch <- NULL
final$interval.f.s.1 <- NULL
final$interval.f.s <- NULL
final$red <- "16"
final$Flows_per_Second <- mean(final$interval.fpersec)
final$MACs <- 100000
cnames <- c("No_of_Switches","Controller","Flows_trials","Flows_per_Second","MAC's")
names(final) <- cnames
a=mean(final$Flows_per_Second)*1000
final$Flows_per_Second <- a


all <- rbind(all,final)

dat <- read.csv("el6383/datafiles/output/pox_s16_1000000h_t.txt")
dat$controller <- "pox" 
cnames <-c("red","controller")
names(dat) <- cnames
dat <- dat [-c(10),]
final <- transform(dat, interval = colsplit(red,"=", names = c('switch', 'f/s')))
final <- transform(final, interval = colsplit(interval.f.s,"per", names = c('fpersec', 'f/s')))
final$interval.switch <- NULL
final$interval.f.s.1 <- NULL
final$interval.f.s <- NULL
final$red <- "16"
final$Flows_per_Second <- mean(final$interval.fpersec)
final$MACs <- 1000000
cnames <- c("No_of_Switches","Controller","Flows_trials","Flows_per_Second","MAC's")
names(final) <- cnames
a=mean(final$Flows_per_Second)*1000
final$Flows_per_Second <- a


all <- rbind(all,final)




c <- qplot(all$MAC,all$Flows_per_Second, geom = c("point","line"),linetype=all$Controller,color=all$Controller,label=all$Flows_per_Second,xlab = "Number Of MAC's per switch", ylab = "Flows/Second",main = "Flows Per Second for different \nnumber of MAC's per switch")+theme(axis.text.x=element_text(colour="black",face="bold"),axis.title.x=element_text(face="bold"),axis.text.y=element_text(color="black",face="bold"),axis.title.y=element_text(face="bold"),legend.title = element_text(face="bold"),plot.title=element_text(face="bold",size=20))+scale_color_discrete(name="SDN Controller")+scale_linetype_discrete(name="SDN Controller")+scale_x_continuous(limits=c(1000,100000))
c
d <- qplot(all$MAC,all$Flows_per_Second, geom = c("point","line"),linetype=all$Controller,color=all$Controller,label=all$Flows_per_Second,xlab = "Number Of MAC's per switch", ylab = "Flows/Second",main = "Flows Per Second for different \nnumber of MAC's per switch")+theme(axis.text.x=element_text(colour="black",face="bold"),axis.title.x=element_text(face="bold"),axis.text.y=element_text(color="black",face="bold"),axis.title.y=element_text(face="bold"),legend.title = element_text(face="bold"),plot.title=element_text(face="bold",size=20))+scale_color_discrete(name="SDN Controller")+scale_linetype_discrete(name="SDN Controller")+scale_x_continuous(limits=c(10000,100000))
d









