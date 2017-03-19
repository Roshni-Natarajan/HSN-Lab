temp<-read.table("/users/rn979/el6383/template.txt")
cnames <- c("trial","tcp","Bandwidth", "Delay")
names(temp)<-cnames
temp$trial<-1
temp$tcp<-"reno"
temp$Bandwidth<-10
temp$Delay<-c(1,2,3)
size<-153
dat<-read.table("/users/rn979/el6383/lab2/submit/1_reno_10Mbps_1ms-processed.txt")
cnames <- c("oml.ts","oml.id","oml.seq",
            "socket","state","ca.state","last.data.sent","last.data.recv",
            "snd.cwnd","snd.ssthresh","rcv.ssthresh","rtt","rttvar","snd.mss",
            "rcv.mss","rto","ato","unacked","sacked","lost","retrans","fackets",
            "total.retrans")
names(dat) <- cnames
l<-length(dat$oml.ts)
delay<-dat$oml.ts[l]-dat$oml.ts[1]
a<-size/delay

dat<-read.table("/users/rn979/el6383/lab2/submit/1_reno_10Mbps_2ms-processed.txt")
cnames <- c("oml.ts","oml.id","oml.seq",
            "socket","state","ca.state","last.data.sent","last.data.recv",
            "snd.cwnd","snd.ssthresh","rcv.ssthresh","rtt","rttvar","snd.mss",
            "rcv.mss","rto","ato","unacked","sacked","lost","retrans","fackets",
            "total.retrans")
names(dat) <- cnames
l<-length(dat$oml.ts)
delay<-dat$oml.ts[l]-dat$oml.ts[1]
b<-size/delay

dat<-read.table("/users/rn979/el6383/lab2/submit/1_reno_10Mbps_3ms-processed.txt")
cnames <- c("oml.ts","oml.id","oml.seq",
            "socket","state","ca.state","last.data.sent","last.data.recv",
            "snd.cwnd","snd.ssthresh","rcv.ssthresh","rtt","rttvar","snd.mss",
            "rcv.mss","rto","ato","unacked","sacked","lost","retrans","fackets",
            "total.retrans")
names(dat) <- cnames
l<-length(dat$oml.ts)
delay<-dat$oml.ts[l]-dat$oml.ts[1]
c<-size/delay
temp$tput<-c(a,b,c)

all<-temp

temp$tcp<-"scalable"

dat<-read.table("/users/rn979/el6383/lab2/submit/1_scalable_10Mbps_1ms-processed.txt")
cnames <- c("oml.ts","oml.id","oml.seq",
            "socket","state","ca.state","last.data.sent","last.data.recv",
            "snd.cwnd","snd.ssthresh","rcv.ssthresh","rtt","rttvar","snd.mss",
            "rcv.mss","rto","ato","unacked","sacked","lost","retrans","fackets",
            "total.retrans")
names(dat) <- cnames
l<-length(dat$oml.ts)
delay<-dat$oml.ts[l]-dat$oml.ts[1]
a<-size/delay
dat<-read.table("/users/rn979/el6383/lab2/submit/1_scalable_10Mbps_2ms-processed.txt")
cnames <- c("oml.ts","oml.id","oml.seq",
            "socket","state","ca.state","last.data.sent","last.data.recv",
            "snd.cwnd","snd.ssthresh","rcv.ssthresh","rtt","rttvar","snd.mss",
            "rcv.mss","rto","ato","unacked","sacked","lost","retrans","fackets",
            "total.retrans")
names(dat) <- cnames
l<-length(dat$oml.ts)
delay<-dat$oml.ts[l]-dat$oml.ts[1]
b<-size/delay
dat<-read.table("/users/rn979/el6383/lab2/submit/1_scalable_10Mbps_3ms-processed.txt")
cnames <- c("oml.ts","oml.id","oml.seq",
            "socket","state","ca.state","last.data.sent","last.data.recv",
            "snd.cwnd","snd.ssthresh","rcv.ssthresh","rtt","rttvar","snd.mss",
            "rcv.mss","rto","ato","unacked","sacked","lost","retrans","fackets",
            "total.retrans")
names(dat) <- cnames
l<-length(dat$oml.ts)
delay<-dat$oml.ts[l]-dat$oml.ts[1]
c<-size/delay
temp$tput<-c(a,b,c)

all<-rbind(all,temp)


temp$tcp<-"yeah"

dat<-read.table("/users/rn979/el6383/lab2/submit/1_yeah_10Mbps_1ms-processed.txt")
cnames <- c("oml.ts","oml.id","oml.seq",
            "socket","state","ca.state","last.data.sent","last.data.recv",
            "snd.cwnd","snd.ssthresh","rcv.ssthresh","rtt","rttvar","snd.mss",
            "rcv.mss","rto","ato","unacked","sacked","lost","retrans","fackets",
            "total.retrans")
names(dat) <- cnames
l<-length(dat$oml.ts)
delay<-dat$oml.ts[l]-dat$oml.ts[1]
a<-size/delay
dat<-read.table("/users/rn979/el6383/lab2/submit/1_yeah_10Mbps_2ms-processed.txt")
cnames <- c("oml.ts","oml.id","oml.seq",
            "socket","state","ca.state","last.data.sent","last.data.recv",
            "snd.cwnd","snd.ssthresh","rcv.ssthresh","rtt","rttvar","snd.mss",
            "rcv.mss","rto","ato","unacked","sacked","lost","retrans","fackets",
            "total.retrans")
names(dat) <- cnames
l<-length(dat$oml.ts)
delay<-dat$oml.ts[l]-dat$oml.ts[1]
b<-size/delay
dat<-read.table("/users/rn979/el6383/lab2/submit/1_yeah_10Mbps_3ms-processed.txt")
cnames <- c("oml.ts","oml.id","oml.seq",
            "socket","state","ca.state","last.data.sent","last.data.recv",
            "snd.cwnd","snd.ssthresh","rcv.ssthresh","rtt","rttvar","snd.mss",
            "rcv.mss","rto","ato","unacked","sacked","lost","retrans","fackets",
            "total.retrans")
names(dat) <- cnames
l<-length(dat$oml.ts)
delay<-dat$oml.ts[l]-dat$oml.ts[1]
c<-size/delay
temp$tput<-c(a,b,c)

all<-rbind(all,temp)





temp<-read.table("/users/rn979/el6383/template.txt")
cnames <- c("trial","tcp","Bandwidth", "Delay")
names(temp)<-cnames
temp$trial<-2
temp$tcp<-"reno"
temp$Bandwidth<-10
temp$Delay<-c(1,2,3)
size<-153
dat<-read.table("/users/rn979/el6383/lab2/submit/2_reno_10Mbps_1ms-processed.txt")
cnames <- c("oml.ts","oml.id","oml.seq",
            "socket","state","ca.state","last.data.sent","last.data.recv",
            "snd.cwnd","snd.ssthresh","rcv.ssthresh","rtt","rttvar","snd.mss",
            "rcv.mss","rto","ato","unacked","sacked","lost","retrans","fackets",
            "total.retrans")
names(dat) <- cnames
l<-length(dat$oml.ts)
delay<-dat$oml.ts[l]-dat$oml.ts[1]
a<-size/delay

dat<-read.table("/users/rn979/el6383/lab2/submit/2_reno_10Mbps_2ms-processed.txt")
cnames <- c("oml.ts","oml.id","oml.seq",
            "socket","state","ca.state","last.data.sent","last.data.recv",
            "snd.cwnd","snd.ssthresh","rcv.ssthresh","rtt","rttvar","snd.mss",
            "rcv.mss","rto","ato","unacked","sacked","lost","retrans","fackets",
            "total.retrans")
names(dat) <- cnames
l<-length(dat$oml.ts)
delay<-dat$oml.ts[l]-dat$oml.ts[1]
b<-size/delay

dat<-read.table("/users/rn979/el6383/lab2/submit/2_reno_10Mbps_3ms-processed.txt")
cnames <- c("oml.ts","oml.id","oml.seq",
            "socket","state","ca.state","last.data.sent","last.data.recv",
            "snd.cwnd","snd.ssthresh","rcv.ssthresh","rtt","rttvar","snd.mss",
            "rcv.mss","rto","ato","unacked","sacked","lost","retrans","fackets",
            "total.retrans")
names(dat) <- cnames
l<-length(dat$oml.ts)
delay<-dat$oml.ts[l]-dat$oml.ts[1]
c<-size/delay
temp$tput<-c(a,b,c)

all<-rbind(all,temp)

temp$tcp<-"scalable"

dat<-read.table("/users/rn979/el6383/lab2/submit/2_scalable_10Mbps_1ms-processed.txt")
cnames <- c("oml.ts","oml.id","oml.seq",
            "socket","state","ca.state","last.data.sent","last.data.recv",
            "snd.cwnd","snd.ssthresh","rcv.ssthresh","rtt","rttvar","snd.mss",
            "rcv.mss","rto","ato","unacked","sacked","lost","retrans","fackets",
            "total.retrans")
names(dat) <- cnames
l<-length(dat$oml.ts)
delay<-dat$oml.ts[l]-dat$oml.ts[1]
a<-size/delay
dat<-read.table("/users/rn979/el6383/lab2/submit/2_scalable_10Mbps_2ms-processed.txt")
cnames <- c("oml.ts","oml.id","oml.seq",
            "socket","state","ca.state","last.data.sent","last.data.recv",
            "snd.cwnd","snd.ssthresh","rcv.ssthresh","rtt","rttvar","snd.mss",
            "rcv.mss","rto","ato","unacked","sacked","lost","retrans","fackets",
            "total.retrans")
names(dat) <- cnames
l<-length(dat$oml.ts)
delay<-dat$oml.ts[l]-dat$oml.ts[1]
b<-size/delay
dat<-read.table("/users/rn979/el6383/lab2/submit/2_scalable_10Mbps_3ms-processed.txt")
cnames <- c("oml.ts","oml.id","oml.seq",
            "socket","state","ca.state","last.data.sent","last.data.recv",
            "snd.cwnd","snd.ssthresh","rcv.ssthresh","rtt","rttvar","snd.mss",
            "rcv.mss","rto","ato","unacked","sacked","lost","retrans","fackets",
            "total.retrans")
names(dat) <- cnames
l<-length(dat$oml.ts)
delay<-dat$oml.ts[l]-dat$oml.ts[1]
c<-size/delay
temp$tput<-c(a,b,c)

all<-rbind(all,temp)


temp$tcp<-"yeah"

dat<-read.table("/users/rn979/el6383/lab2/submit/2_yeah_10Mbps_1ms-processed.txt")
cnames <- c("oml.ts","oml.id","oml.seq",
            "socket","state","ca.state","last.data.sent","last.data.recv",
            "snd.cwnd","snd.ssthresh","rcv.ssthresh","rtt","rttvar","snd.mss",
            "rcv.mss","rto","ato","unacked","sacked","lost","retrans","fackets",
            "total.retrans")
names(dat) <- cnames
l<-length(dat$oml.ts)
delay<-dat$oml.ts[l]-dat$oml.ts[1]
a<-size/delay
dat<-read.table("/users/rn979/el6383/lab2/submit/2_yeah_10Mbps_2ms-processed.txt")
cnames <- c("oml.ts","oml.id","oml.seq",
            "socket","state","ca.state","last.data.sent","last.data.recv",
            "snd.cwnd","snd.ssthresh","rcv.ssthresh","rtt","rttvar","snd.mss",
            "rcv.mss","rto","ato","unacked","sacked","lost","retrans","fackets",
            "total.retrans")
names(dat) <- cnames
l<-length(dat$oml.ts)
delay<-dat$oml.ts[l]-dat$oml.ts[1]
b<-size/delay
dat<-read.table("/users/rn979/el6383/lab2/submit/2_yeah_10Mbps_3ms-processed.txt")
cnames <- c("oml.ts","oml.id","oml.seq",
            "socket","state","ca.state","last.data.sent","last.data.recv",
            "snd.cwnd","snd.ssthresh","rcv.ssthresh","rtt","rttvar","snd.mss",
            "rcv.mss","rto","ato","unacked","sacked","lost","retrans","fackets",
            "total.retrans")
names(dat) <- cnames
l<-length(dat$oml.ts)
delay<-dat$oml.ts[l]-dat$oml.ts[1]
c<-size/delay
temp$tput<-c(a,b,c)

all<-rbind(all,temp)



temp<-read.table("/users/rn979/el6383/template.txt")
cnames <- c("trial","tcp","Bandwidth", "Delay")
names(temp)<-cnames
temp$trial<-3
temp$tcp<-"reno"
temp$Bandwidth<-10
temp$Delay<-c(1,2,3)
size<-153
dat<-read.table("/users/rn979/el6383/lab2/submit/3_reno_10Mbps_1ms-processed.txt")
cnames <- c("oml.ts","oml.id","oml.seq",
            "socket","state","ca.state","last.data.sent","last.data.recv",
            "snd.cwnd","snd.ssthresh","rcv.ssthresh","rtt","rttvar","snd.mss",
            "rcv.mss","rto","ato","unacked","sacked","lost","retrans","fackets",
            "total.retrans")
names(dat) <- cnames
l<-length(dat$oml.ts)
delay<-dat$oml.ts[l]-dat$oml.ts[1]
a<-size/delay

dat<-read.table("/users/rn979/el6383/lab2/submit/3_reno_10Mbps_2ms-processed.txt")
cnames <- c("oml.ts","oml.id","oml.seq",
            "socket","state","ca.state","last.data.sent","last.data.recv",
            "snd.cwnd","snd.ssthresh","rcv.ssthresh","rtt","rttvar","snd.mss",
            "rcv.mss","rto","ato","unacked","sacked","lost","retrans","fackets",
            "total.retrans")
names(dat) <- cnames
l<-length(dat$oml.ts)
delay<-dat$oml.ts[l]-dat$oml.ts[1]
b<-size/delay

dat<-read.table("/users/rn979/el6383/lab2/submit/3_reno_10Mbps_3ms-processed.txt")
cnames <- c("oml.ts","oml.id","oml.seq",
            "socket","state","ca.state","last.data.sent","last.data.recv",
            "snd.cwnd","snd.ssthresh","rcv.ssthresh","rtt","rttvar","snd.mss",
            "rcv.mss","rto","ato","unacked","sacked","lost","retrans","fackets",
            "total.retrans")
names(dat) <- cnames
l<-length(dat$oml.ts)
delay<-dat$oml.ts[l]-dat$oml.ts[1]
c<-size/delay
temp$tput<-c(a,b,c)

all<-rbind(all,temp)

temp$tcp<-"scalable"

dat<-read.table("/users/rn979/el6383/lab2/submit/3_scalable_10Mbps_1ms-processed.txt")
cnames <- c("oml.ts","oml.id","oml.seq",
            "socket","state","ca.state","last.data.sent","last.data.recv",
            "snd.cwnd","snd.ssthresh","rcv.ssthresh","rtt","rttvar","snd.mss",
            "rcv.mss","rto","ato","unacked","sacked","lost","retrans","fackets",
            "total.retrans")
names(dat) <- cnames
l<-length(dat$oml.ts)
delay<-dat$oml.ts[l]-dat$oml.ts[1]
a<-size/delay
dat<-read.table("/users/rn979/el6383/lab2/submit/3_scalable_10Mbps_2ms-processed.txt")
cnames <- c("oml.ts","oml.id","oml.seq",
            "socket","state","ca.state","last.data.sent","last.data.recv",
            "snd.cwnd","snd.ssthresh","rcv.ssthresh","rtt","rttvar","snd.mss",
            "rcv.mss","rto","ato","unacked","sacked","lost","retrans","fackets",
            "total.retrans")
names(dat) <- cnames
l<-length(dat$oml.ts)
delay<-dat$oml.ts[l]-dat$oml.ts[1]
b<-size/delay
dat<-read.table("/users/rn979/el6383/lab2/submit/3_scalable_10Mbps_3ms-processed.txt")
cnames <- c("oml.ts","oml.id","oml.seq",
            "socket","state","ca.state","last.data.sent","last.data.recv",
            "snd.cwnd","snd.ssthresh","rcv.ssthresh","rtt","rttvar","snd.mss",
            "rcv.mss","rto","ato","unacked","sacked","lost","retrans","fackets",
            "total.retrans")
names(dat) <- cnames
l<-length(dat$oml.ts)
delay<-dat$oml.ts[l]-dat$oml.ts[1]
c<-size/delay
temp$tput<-c(a,b,c)

all<-rbind(all,temp)


temp$tcp<-"yeah"

dat<-read.table("/users/rn979/el6383/lab2/submit/3_yeah_10Mbps_1ms-processed.txt")
cnames <- c("oml.ts","oml.id","oml.seq",
            "socket","state","ca.state","last.data.sent","last.data.recv",
            "snd.cwnd","snd.ssthresh","rcv.ssthresh","rtt","rttvar","snd.mss",
            "rcv.mss","rto","ato","unacked","sacked","lost","retrans","fackets",
            "total.retrans")
names(dat) <- cnames
l<-length(dat$oml.ts)
delay<-dat$oml.ts[l]-dat$oml.ts[1]
a<-size/delay
dat<-read.table("/users/rn979/el6383/lab2/submit/3_yeah_10Mbps_2ms-processed.txt")
cnames <- c("oml.ts","oml.id","oml.seq",
            "socket","state","ca.state","last.data.sent","last.data.recv",
            "snd.cwnd","snd.ssthresh","rcv.ssthresh","rtt","rttvar","snd.mss",
            "rcv.mss","rto","ato","unacked","sacked","lost","retrans","fackets",
            "total.retrans")
names(dat) <- cnames
l<-length(dat$oml.ts)
delay<-dat$oml.ts[l]-dat$oml.ts[1]
b<-size/delay
dat<-read.table("/users/rn979/el6383/lab2/submit/3_yeah_10Mbps_3ms-processed.txt")
cnames <- c("oml.ts","oml.id","oml.seq",
            "socket","state","ca.state","last.data.sent","last.data.recv",
            "snd.cwnd","snd.ssthresh","rcv.ssthresh","rtt","rttvar","snd.mss",
            "rcv.mss","rto","ato","unacked","sacked","lost","retrans","fackets",
            "total.retrans")
names(dat) <- cnames
l<-length(dat$oml.ts)
delay<-dat$oml.ts[l]-dat$oml.ts[1]
c<-size/delay
temp$tput<-c(a,b,c)

all<-rbind(all,temp)
all$trial <- as.factor(all$trial)
all$tcp <- as.factor(all$tcp)

#Plot 
library(ggplot2)
q <- ggplot(all)
q <- q + geom_point(aes(x=Delay, y=tput, colour=tcp))
q <- q + geom_line(aes(x=Delay, y=tput, colour=tcp, linetype=trial))
q <- q + scale_x_discrete("Delay")
q <- q + scale_y_continuous("Throughput")
q <- q + ggtitle("Line Plot")
q
ggsave("10Mbps.png", plot=q)




#500Mbps

temp<-read.table("/users/rn979/el6383/template.txt")
cnames <- c("trial","tcp","Bandwidth", "Delay")
names(temp)<-cnames
temp$trial<-1
temp$tcp<-"reno"
temp$Bandwidth<-500
temp$Delay<-c(100,200,300)
size<-153

dat<-read.table("/users/rn979/el6383/lab2/submit/1_reno_500Mbps_100ms-processed.txt")
cnames <- c("oml.ts","oml.id","oml.seq",
            "socket","state","ca.state","last.data.sent","last.data.recv",
            "snd.cwnd","snd.ssthresh","rcv.ssthresh","rtt","rttvar","snd.mss",
            "rcv.mss","rto","ato","unacked","sacked","lost","retrans","fackets",
            "total.retrans")
names(dat) <- cnames
l<-length(dat$oml.ts)
delay<-dat$oml.ts[l]-dat$oml.ts[1]
a<-size/delay


dat<-read.table("/users/rn979/el6383/lab2/submit/1_reno_500Mbps_200ms-processed.txt")
cnames <- c("oml.ts","oml.id","oml.seq",
            "socket","state","ca.state","last.data.sent","last.data.recv",
            "snd.cwnd","snd.ssthresh","rcv.ssthresh","rtt","rttvar","snd.mss",
            "rcv.mss","rto","ato","unacked","sacked","lost","retrans","fackets",
            "total.retrans")
names(dat) <- cnames
l<-length(dat$oml.ts)
delay<-dat$oml.ts[l]-dat$oml.ts[1]
b<-size/delay


dat<-read.table("/users/rn979/el6383/lab2/submit/1_reno_500Mbps_300ms-processed.txt")
cnames <- c("oml.ts","oml.id","oml.seq",
            "socket","state","ca.state","last.data.sent","last.data.recv",
            "snd.cwnd","snd.ssthresh","rcv.ssthresh","rtt","rttvar","snd.mss",
            "rcv.mss","rto","ato","unacked","sacked","lost","retrans","fackets",
            "total.retrans")
names(dat) <- cnames
l<-length(dat$oml.ts)
delay<-dat$oml.ts[l]-dat$oml.ts[1]
c<-size/delay
temp$tput<-c(a,b,c)

all_1<-temp

temp$tcp<-"scalable"


dat<-read.table("/users/rn979/el6383/lab2/submit/1_scalable_500Mbps_100ms-processed.txt")
cnames <- c("oml.ts","oml.id","oml.seq",
            "socket","state","ca.state","last.data.sent","last.data.recv",
            "snd.cwnd","snd.ssthresh","rcv.ssthresh","rtt","rttvar","snd.mss",
            "rcv.mss","rto","ato","unacked","sacked","lost","retrans","fackets",
            "total.retrans")
names(dat) <- cnames
l<-length(dat$oml.ts)
delay<-dat$oml.ts[l]-dat$oml.ts[1]
a<-size/delay

dat<-read.table("/users/rn979/el6383/lab2/submit/1_scalable_500Mbps_200ms-processed.txt")
cnames <- c("oml.ts","oml.id","oml.seq",
            "socket","state","ca.state","last.data.sent","last.data.recv",
            "snd.cwnd","snd.ssthresh","rcv.ssthresh","rtt","rttvar","snd.mss",
            "rcv.mss","rto","ato","unacked","sacked","lost","retrans","fackets",
            "total.retrans")
names(dat) <- cnames
l<-length(dat$oml.ts)
delay<-dat$oml.ts[l]-dat$oml.ts[1]
b<-size/delay

dat<-read.table("/users/rn979/el6383/lab2/submit/1_scalable_500Mbps_300ms-processed.txt")
cnames <- c("oml.ts","oml.id","oml.seq",
            "socket","state","ca.state","last.data.sent","last.data.recv",
            "snd.cwnd","snd.ssthresh","rcv.ssthresh","rtt","rttvar","snd.mss",
            "rcv.mss","rto","ato","unacked","sacked","lost","retrans","fackets",
            "total.retrans")
names(dat) <- cnames
l<-length(dat$oml.ts)
delay<-dat$oml.ts[l]-dat$oml.ts[1]
c<-size/delay
temp$tput<-c(a,b,c)

all_1<-rbind(all_1,temp)


temp$tcp<-"yeah"


dat<-read.table("/users/rn979/el6383/lab2/submit/1_yeah_500Mbps_100ms-processed.txt")
cnames <- c("oml.ts","oml.id","oml.seq",
            "socket","state","ca.state","last.data.sent","last.data.recv",
            "snd.cwnd","snd.ssthresh","rcv.ssthresh","rtt","rttvar","snd.mss",
            "rcv.mss","rto","ato","unacked","sacked","lost","retrans","fackets",
            "total.retrans")
names(dat) <- cnames
l<-length(dat$oml.ts)
delay<-dat$oml.ts[l]-dat$oml.ts[1]
a<-size/delay

dat<-read.table("/users/rn979/el6383/lab2/submit/1_yeah_500Mbps_200ms-processed.txt")
cnames <- c("oml.ts","oml.id","oml.seq",
            "socket","state","ca.state","last.data.sent","last.data.recv",
            "snd.cwnd","snd.ssthresh","rcv.ssthresh","rtt","rttvar","snd.mss",
            "rcv.mss","rto","ato","unacked","sacked","lost","retrans","fackets",
            "total.retrans")
names(dat) <- cnames
l<-length(dat$oml.ts)
delay<-dat$oml.ts[l]-dat$oml.ts[1]
b<-size/delay

dat<-read.table("/users/rn979/el6383/lab2/submit/1_yeah_500Mbps_300ms-processed.txt")
cnames <- c("oml.ts","oml.id","oml.seq",
            "socket","state","ca.state","last.data.sent","last.data.recv",
            "snd.cwnd","snd.ssthresh","rcv.ssthresh","rtt","rttvar","snd.mss",
            "rcv.mss","rto","ato","unacked","sacked","lost","retrans","fackets",
            "total.retrans")
names(dat) <- cnames
l<-length(dat$oml.ts)
delay<-dat$oml.ts[l]-dat$oml.ts[1]
c<-size/delay
temp$tput<-c(a,b,c)

all_1<-rbind(all_1,temp)





temp<-read.table("/users/rn979/el6383/template.txt")
cnames <- c("trial","tcp","Bandwidth", "Delay")
names(temp)<-cnames
temp$trial<-2
temp$tcp<-"reno"
temp$Bandwidth<-500
temp$Delay<-c(100,200,300)
size<-153

dat<-read.table("/users/rn979/el6383/lab2/submit/2_reno_500Mbps_100ms-processed.txt")
cnames <- c("oml.ts","oml.id","oml.seq",
            "socket","state","ca.state","last.data.sent","last.data.recv",
            "snd.cwnd","snd.ssthresh","rcv.ssthresh","rtt","rttvar","snd.mss",
            "rcv.mss","rto","ato","unacked","sacked","lost","retrans","fackets",
            "total.retrans")
names(dat) <- cnames
l<-length(dat$oml.ts)
delay<-dat$oml.ts[l]-dat$oml.ts[1]
a<-size/delay


dat<-read.table("/users/rn979/el6383/lab2/submit/2_reno_500Mbps_200ms-processed.txt")
cnames <- c("oml.ts","oml.id","oml.seq",
            "socket","state","ca.state","last.data.sent","last.data.recv",
            "snd.cwnd","snd.ssthresh","rcv.ssthresh","rtt","rttvar","snd.mss",
            "rcv.mss","rto","ato","unacked","sacked","lost","retrans","fackets",
            "total.retrans")
names(dat) <- cnames
l<-length(dat$oml.ts)
delay<-dat$oml.ts[l]-dat$oml.ts[1]
b<-size/delay

dat<-read.table("/users/rn979/el6383/lab2/submit/2_reno_500Mbps_300ms-processed.txt")
cnames <- c("oml.ts","oml.id","oml.seq",
            "socket","state","ca.state","last.data.sent","last.data.recv",
            "snd.cwnd","snd.ssthresh","rcv.ssthresh","rtt","rttvar","snd.mss",
            "rcv.mss","rto","ato","unacked","sacked","lost","retrans","fackets",
            "total.retrans")
names(dat) <- cnames
l<-length(dat$oml.ts)
delay<-dat$oml.ts[l]-dat$oml.ts[1]
c<-size/delay
temp$tput<-c(a,b,c)

all_1<-rbind(all_1,temp)

temp$tcp<-"scalable"


dat<-read.table("/users/rn979/el6383/lab2/submit/2_scalable_500Mbps_100ms-processed.txt")
cnames <- c("oml.ts","oml.id","oml.seq",
            "socket","state","ca.state","last.data.sent","last.data.recv",
            "snd.cwnd","snd.ssthresh","rcv.ssthresh","rtt","rttvar","snd.mss",
            "rcv.mss","rto","ato","unacked","sacked","lost","retrans","fackets",
            "total.retrans")
names(dat) <- cnames
l<-length(dat$oml.ts)
delay<-dat$oml.ts[l]-dat$oml.ts[1]
a<-size/delay

dat<-read.table("/users/rn979/el6383/lab2/submit/2_scalable_500Mbps_200ms-processed.txt")
cnames <- c("oml.ts","oml.id","oml.seq",
            "socket","state","ca.state","last.data.sent","last.data.recv",
            "snd.cwnd","snd.ssthresh","rcv.ssthresh","rtt","rttvar","snd.mss",
            "rcv.mss","rto","ato","unacked","sacked","lost","retrans","fackets",
            "total.retrans")
names(dat) <- cnames
l<-length(dat$oml.ts)
delay<-dat$oml.ts[l]-dat$oml.ts[1]
b<-size/delay

dat<-read.table("/users/rn979/el6383/lab2/submit/2_scalable_500Mbps_300ms-processed.txt")
cnames <- c("oml.ts","oml.id","oml.seq",
            "socket","state","ca.state","last.data.sent","last.data.recv",
            "snd.cwnd","snd.ssthresh","rcv.ssthresh","rtt","rttvar","snd.mss",
            "rcv.mss","rto","ato","unacked","sacked","lost","retrans","fackets",
            "total.retrans")
names(dat) <- cnames
l<-length(dat$oml.ts)
delay<-dat$oml.ts[l]-dat$oml.ts[1]
c<-size/delay
temp$tput<-c(a,b,c)

all_1<-rbind(all_1,temp)


temp$tcp<-"yeah"

dat<-read.table("/users/rn979/el6383/lab2/submit/2_yeah_500Mbps_100ms-processed.txt")
cnames <- c("oml.ts","oml.id","oml.seq",
            "socket","state","ca.state","last.data.sent","last.data.recv",
            "snd.cwnd","snd.ssthresh","rcv.ssthresh","rtt","rttvar","snd.mss",
            "rcv.mss","rto","ato","unacked","sacked","lost","retrans","fackets",
            "total.retrans")
names(dat) <- cnames
l<-length(dat$oml.ts)
delay<-dat$oml.ts[l]-dat$oml.ts[1]
a<-size/delay

dat<-read.table("/users/rn979/el6383/lab2/submit/2_yeah_500Mbps_200ms-processed.txt")
cnames <- c("oml.ts","oml.id","oml.seq",
            "socket","state","ca.state","last.data.sent","last.data.recv",
            "snd.cwnd","snd.ssthresh","rcv.ssthresh","rtt","rttvar","snd.mss",
            "rcv.mss","rto","ato","unacked","sacked","lost","retrans","fackets",
            "total.retrans")
names(dat) <- cnames
l<-length(dat$oml.ts)
delay<-dat$oml.ts[l]-dat$oml.ts[1]
b<-size/delay

dat<-read.table("/users/rn979/el6383/lab2/submit/2_yeah_500Mbps_300ms-processed.txt")
cnames <- c("oml.ts","oml.id","oml.seq",
            "socket","state","ca.state","last.data.sent","last.data.recv",
            "snd.cwnd","snd.ssthresh","rcv.ssthresh","rtt","rttvar","snd.mss",
            "rcv.mss","rto","ato","unacked","sacked","lost","retrans","fackets",
            "total.retrans")
names(dat) <- cnames
l<-length(dat$oml.ts)
delay<-dat$oml.ts[l]-dat$oml.ts[1]
c<-size/delay
temp$tput<-c(a,b,c)

all_1<-rbind(all_1,temp)



temp<-read.table("/users/rn979/el6383/template.txt")
cnames <- c("trial","tcp","Bandwidth", "Delay")
names(temp)<-cnames
temp$trial<-3
temp$tcp<-"reno"
temp$Bandwidth<-500
temp$Delay<-c(100,200,300)
size<-153

dat<-read.table("/users/rn979/el6383/lab2/submit/3_reno_500Mbps_100ms-processed.txt")
cnames <- c("oml.ts","oml.id","oml.seq",
            "socket","state","ca.state","last.data.sent","last.data.recv",
            "snd.cwnd","snd.ssthresh","rcv.ssthresh","rtt","rttvar","snd.mss",
            "rcv.mss","rto","ato","unacked","sacked","lost","retrans","fackets",
            "total.retrans")
names(dat) <- cnames
l<-length(dat$oml.ts)
delay<-dat$oml.ts[l]-dat$oml.ts[1]
a<-size/delay

dat<-read.table("/users/rn979/el6383/lab2/submit/3_reno_500Mbps_200ms-processed.txt")
cnames <- c("oml.ts","oml.id","oml.seq",
            "socket","state","ca.state","last.data.sent","last.data.recv",
            "snd.cwnd","snd.ssthresh","rcv.ssthresh","rtt","rttvar","snd.mss",
            "rcv.mss","rto","ato","unacked","sacked","lost","retrans","fackets",
            "total.retrans")
names(dat) <- cnames
l<-length(dat$oml.ts)
delay<-dat$oml.ts[l]-dat$oml.ts[1]
b<-size/delay

dat<-read.table("/users/rn979/el6383/lab2/submit/3_reno_500Mbps_300ms-processed.txt")
cnames <- c("oml.ts","oml.id","oml.seq",
            "socket","state","ca.state","last.data.sent","last.data.recv",
            "snd.cwnd","snd.ssthresh","rcv.ssthresh","rtt","rttvar","snd.mss",
            "rcv.mss","rto","ato","unacked","sacked","lost","retrans","fackets",
            "total.retrans")
names(dat) <- cnames
l<-length(dat$oml.ts)
delay<-dat$oml.ts[l]-dat$oml.ts[1]
c<-size/delay
temp$tput<-c(a,b,c)

all_1<-rbind(all_1,temp)

temp$tcp<-"scalable"

dat<-read.table("/users/rn979/el6383/lab2/submit/3_scalable_500Mbps_100ms-processed.txt")
cnames <- c("oml.ts","oml.id","oml.seq",
            "socket","state","ca.state","last.data.sent","last.data.recv",
            "snd.cwnd","snd.ssthresh","rcv.ssthresh","rtt","rttvar","snd.mss",
            "rcv.mss","rto","ato","unacked","sacked","lost","retrans","fackets",
            "total.retrans")
names(dat) <- cnames
l<-length(dat$oml.ts)
delay<-dat$oml.ts[l]-dat$oml.ts[1]
a<-size/delay

dat<-read.table("/users/rn979/el6383/lab2/submit/3_scalable_500Mbps_200ms-processed.txt")
cnames <- c("oml.ts","oml.id","oml.seq",
            "socket","state","ca.state","last.data.sent","last.data.recv",
            "snd.cwnd","snd.ssthresh","rcv.ssthresh","rtt","rttvar","snd.mss",
            "rcv.mss","rto","ato","unacked","sacked","lost","retrans","fackets",
            "total.retrans")
names(dat) <- cnames
l<-length(dat$oml.ts)
delay<-dat$oml.ts[l]-dat$oml.ts[1]
b<-size/delay

dat<-read.table("/users/rn979/el6383/lab2/submit/3_scalable_500Mbps_300ms-processed.txt")
cnames <- c("oml.ts","oml.id","oml.seq",
            "socket","state","ca.state","last.data.sent","last.data.recv",
            "snd.cwnd","snd.ssthresh","rcv.ssthresh","rtt","rttvar","snd.mss",
            "rcv.mss","rto","ato","unacked","sacked","lost","retrans","fackets",
            "total.retrans")
names(dat) <- cnames
l<-length(dat$oml.ts)
delay<-dat$oml.ts[l]-dat$oml.ts[1]
c<-size/delay
temp$tput<-c(a,b,c)

all_1<-rbind(all_1,temp)


temp$tcp<-"yeah"

dat<-read.table("/users/rn979/el6383/lab2/submit/3_yeah_500Mbps_100ms-processed.txt")
cnames <- c("oml.ts","oml.id","oml.seq",
            "socket","state","ca.state","last.data.sent","last.data.recv",
            "snd.cwnd","snd.ssthresh","rcv.ssthresh","rtt","rttvar","snd.mss",
            "rcv.mss","rto","ato","unacked","sacked","lost","retrans","fackets",
            "total.retrans")
names(dat) <- cnames
l<-length(dat$oml.ts)
delay<-dat$oml.ts[l]-dat$oml.ts[1]
a<-size/delay

dat<-read.table("/users/rn979/el6383/lab2/submit/3_yeah_500Mbps_200ms-processed.txt")
cnames <- c("oml.ts","oml.id","oml.seq",
            "socket","state","ca.state","last.data.sent","last.data.recv",
            "snd.cwnd","snd.ssthresh","rcv.ssthresh","rtt","rttvar","snd.mss",
            "rcv.mss","rto","ato","unacked","sacked","lost","retrans","fackets",
            "total.retrans")
names(dat) <- cnames
l<-length(dat$oml.ts)
delay<-dat$oml.ts[l]-dat$oml.ts[1]
b<-size/delay

dat<-read.table("/users/rn979/el6383/lab2/submit/3_yeah_500Mbps_300ms-processed.txt")
cnames <- c("oml.ts","oml.id","oml.seq",
            "socket","state","ca.state","last.data.sent","last.data.recv",
            "snd.cwnd","snd.ssthresh","rcv.ssthresh","rtt","rttvar","snd.mss",
            "rcv.mss","rto","ato","unacked","sacked","lost","retrans","fackets",
            "total.retrans")
names(dat) <- cnames
l<-length(dat$oml.ts)
delay<-dat$oml.ts[l]-dat$oml.ts[1]
c<-size/delay
temp$tput<-c(a,b,c)

all_1<-rbind(all_1,temp)

all_1$trial <- as.factor(all_1$trial)
all_1$tcp <- as.factor(all_1$tcp)
library(ggplot2)
p <- ggplot(all_1)
p <- p + geom_point(aes(x=Delay, y=tput, colour=tcp))
p <- p + geom_line(aes(x=Delay, y=tput, colour=tcp, linetype=trial))
p <- p + scale_y_discrete("Throughput")
p <- p + ggtitle("Line Plot")
p
ggsave("500Mbps.png", plot=p)