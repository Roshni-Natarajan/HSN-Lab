#EL6383 High Speed Network
##[Final Project Report]


###Introduction
With the rapid growth of Internet traffic,  it becomes more and more important about how to effectively utilize network resources. 
Transmission Control Protocol (TCP) is a transport layer protocol .TCP is a connection-oriented transmission protocol widely used
on the Internet. It can ensure data transmission order and reliability. The greatest feature of TCP is its adaptive capability of 
congestion control mechanism. TCP can automatically adjust window size according to the network congestion in order to make the 
transmission rate to adapt TCP congestion of the network.  To make the most efficient use of network bandwidth,  TCP uses a slow 
start, congestion avoidance, fast retransmit, fast recovery and some other strategies. So there are many versions of TCP.
Traditional TCP congestion avoidance mechanism only works when it detects packet loss. When there is a packet lost, it will start 
the congestion avoidance algorithm.This is actually a remedy after there is already network congestion.
However, TCP Vegas works by comparing the actual throughput and expected throughput. It can analyze the difference between the 
throughput to control and avoid congestion. Vegas uses the ratio of the congestion window and the data packet round-trip time (RTT) 
to estimate the amount of data and always maintain amount of data  between the lower bound and upper bound.  By adjusting the 
congestion window reasonably, Vegas can avoid network congestion and maintain a relatively high throughput at the same time.

###Goal
We want to design a project to analyze the incompatibility of TCP Vegas and TCP Reno.
In detail, our experiment is intended to verify the unfairness bandwidth sharing when a TCP Vegas competes with TCP Reno. 
We want to do this experiment by observing and comparing the throughput performance of TCP variants with different buffer sizes.

###Tool
Geni Iperf Rstudio

### Experiment Setup

####a).Design Topology 
![](https://bytebucket.org/rrrrdong/dxl2015-el6383-project/raw/c91c127ef7994f6106c8bb22ee8d8a89cd262f11/design%20topolpgy.png)

####b). Set up Parameters 
![](https://bytebucket.org/rrrrdong/dxl2015-el6383-project/raw/c91c127ef7994f6106c8bb22ee8d8a89cd262f11/set%20up%20parameter.png)

###Metrics:
####Throughput of two connections with TCP Vegas and TCP Reno
![](https://bytebucket.org/rrrrdong/dxl2015-el6383-project/raw/c91c127ef7994f6106c8bb22ee8d8a89cd262f11/throughput.png)
![](https://bytebucket.org/rrrrdong/dxl2015-el6383-project/raw/c91c127ef7994f6106c8bb22ee8d8a89cd262f11/vegas%20bandwidth.png)
![](https://bytebucket.org/rrrrdong/dxl2015-el6383-project/raw/c91c127ef7994f6106c8bb22ee8d8a89cd262f11/reno%20bandwidth.png)

###Experiment Result Record:
We set up the experiment into four parts with different buffersizes(min default max).

Executing the tests using four different buffersizes above, we can get the results in the following table. 
These tables are comparisons of TCP Vegas and TCP Reno in 2Mbps bandwidth in four buffersizes.
![](https://bytebucket.org/rrrrdong/dxl2015-el6383-project/raw/c91c127ef7994f6106c8bb22ee8d8a89cd262f11/test1.png)
![](https://bytebucket.org/rrrrdong/dxl2015-el6383-project/raw/c91c127ef7994f6106c8bb22ee8d8a89cd262f11/Plot/Exper1_violinplot.png)

![](https://bytebucket.org/rrrrdong/dxl2015-el6383-project/raw/c91c127ef7994f6106c8bb22ee8d8a89cd262f11/test2.png)
![](https://bytebucket.org/rrrrdong/dxl2015-el6383-project/raw/c91c127ef7994f6106c8bb22ee8d8a89cd262f11/Plot/Exper2_violinplot.png)

![](https://bytebucket.org/rrrrdong/dxl2015-el6383-project/raw/c91c127ef7994f6106c8bb22ee8d8a89cd262f11/test3.png)
![](https://bytebucket.org/rrrrdong/dxl2015-el6383-project/raw/c91c127ef7994f6106c8bb22ee8d8a89cd262f11/Plot/Exper3_violinplot.png)

![](https://bytebucket.org/rrrrdong/dxl2015-el6383-project/raw/c91c127ef7994f6106c8bb22ee8d8a89cd262f11/test%204.png)
![](https://bytebucket.org/rrrrdong/dxl2015-el6383-project/raw/c91c127ef7994f6106c8bb22ee8d8a89cd262f11/Plot/Exper4_violinplot.png)

###Analysis :
From the results above, we can clearly see that TCP Vegas and TCP Reno compete with each other when in the bandwidth. 
TCP Reno usually occupies more bandwidth than TCP Vegas. Compare four tests, we can also conclude that when buffersize gets larger, 
TCP Reno tends to occupy more and more bandwidth.

###Conclusion :
In this project, we have proved the incompatibility between TCP Vegas and TCP Reno via simulation in GENI. Our experiment 
shows that TCP Reno tends to occupy more bandwidth than TCP Vegas when it comes to congestion. We analyse that TCP Vegas 
and TCP Reno how to compete the bandwidth in heterogeneous network environments. We find that TCP Reno performs more aggressive 
when buffersize gets bigger. 


#Instruction

##Part A. Set up experiment

1.Use Rspec file (dxl_project.xml)to add resource on Geni. 
            Two pairs of nodes are connected by a bottleneck with 2MB bandwidth 
            Assign a aggregate you like and reserve resource, wait resource to ready
![](https://bytebucket.org/rrrrdong/dxl2015-el6383-project/raw/85b293d66625689c2799b9f0f3fc3d8e5f03fde6/design%20topolpgy.png)

![](https://bytebucket.org/rrrrdong/dxl2015-el6383-project/raw/85b293d66625689c2799b9f0f3fc3d8e5f03fde6/Screen%20Shot%202015-04-17%20at%206.37.02%20PM.png)

2.Ping and latency check
Log in N0, ping N4, to see if the connection works well, and check the latency is around 2ms.
Run Ping 10.1.4.1 -c 5
Log in N1, ping N5, to see if the connection works well, and check the latency is around 2ms.
Run Ping 10.1.5.1 -c 5

3.Install iperf in N0, N1, N4, N5
Log in each Node above, run sudo apt-get install iperf

4.Bandwidth Check
Firstly, at N4, run iperf -s, when the server start, then run iperf -c 10.1.4.1 at N0 
You can see the bandwidth is about 2MB.

5.Tcp variant set
Log in N0, set tcp variant to vegas.
Log in N1, N2	, N3, N4, N5 respectively, set tcp variant to reno.
            
           To activate a particular TCP variant, run
      modprobe tcp_VARIANT
            then
      sysctl -w net.ipv4.tcp_congestion_control=VARIANT
            where VARIANT is the TCP you are trying to enable (e.g., cubic, bic).
            Note that reno does not require the modprobe command. You can enable reno with just the      sysctl command.
           To verify which TCP variant is currently enabled, run
      sysctl net.ipv4.tcp_congestion_control
      
6. Tcp buffer size set
           We are going to use different  receive buffer size value on N2 on each experiment. The following is 4 groups receive
		   buffer size parameter. Before running each experiment, you should set N2  receive buffer size as one of following value.
                                                           (Min:4 Def: 87 Max:1029)
(Min:40  Def: 873   Max:10298)
(Min:409  Def: 8738  Max:102982)
(Min:4096  Def: 87380  Max:1029824) 
     where MIN, DEF, and MAX are the minimum, default, and maximum values, respectively.
           You can tune the minimum, default, and maximum receive buffer size with the following command:
       sysctl -w net.ipv4.tcp_rmem="MIN DEF MAX"
              where MIN, DEF, and MAX are the minimum, default, and maximum values, respectively.
              To check the current values, run
       sysctl net.ipv4.tcp_rmem


##Part B. Experiment execution ---Throughput measurement using Iperf
1. Iperf server start
log in N4, run iperf -s, log in N5, run iperf -s.

2. Iperf run on client
In order to observe the incompatibility of vegas and reno, you should run the iperf command on N0, N1 simultaneously. 
So you can type the command on both node terminal, and run them one by one within a short time gap. 
Log in N0, run 
iperf -c 10.1.4.1 --reportstyle C  -i 1 | tee OUTPUT.txt
where OUTPUT.txt is the name of an output file you'd like to create, it will report throughput at one second intervals, 
in a comma-separated values format, and with output saved to the OUTPUT.txt file. (Run cat OUTPUT.txt to see the contents of the file.)
Please use meaningful names for your output files.
Log in N1, run 
iperf -c 10.1.5.1 --reportstyle C  -i 1 | tee OUTPUT.txt
where OUTPUT.txt is the name of an output file you'd like to create, it will report throughput at one second intervals, 
in a comma-separated values format, and with output saved to the OUTPUT.txt file. (Run cat OUTPUT.txt to see the contents of the file.)
Please use meaningful names for your output files.
You can run three or more trials on each experiment and calculate average of throughput of vegas and reno respectively.
When you finish four experiments, save your text data file to bitbucket with git push command, and we can use R to process these data. 




##Part C.  Raw Data Process
For the installation of R and Rstudio, you can refer to geni lab2b due to we have use it in LFN experiment.
The following is the R script to generate lineplot and violinplot of throughput about these two Tcp variant. 
Before running the script, you should modify the directory of data file to make sure load your own data.

#### 1.load 3 trials vegas data

dat <- read.csv("dxl2015-el6383-project/output041.txt")
cnames <- c("time", "srcip", "srcport", "dstip", "dstport", "id", "interval", "data", "tput")
names(dat) <- cnames
dat$tcp <- "vegas"
dat$capacity <- 2
dat$rtt <- 2
dat$trial <- 1
LFN1 <- dat
dat <- read.csv("dxl2015-el6383-project/output042.txt")
names(dat) <- cnames
dat$tcp <- "vegas"
dat$capacity <- 2
dat$rtt <- 2
dat$trial <- 2
LFN1 <- rbind(LFN1, dat)
dat <- read.csv("dxl2015-el6383-project/output043.txt")
names(dat) <- cnames
dat$tcp <- "vegas"
dat$capacity <- 2
dat$rtt <- 2
dat$trial <- 3
LFN1 <- rbind(LFN1, dat)
#### 2.load 3 trials reno data
dat <- read.csv("dxl2015-el6383-project/output151.txt")
names(dat) <- cnames
dat$tcp <- "reno"
dat$capacity <- 2
dat$rtt <- 2
dat$trial <- 1
LFN1 <- rbind(LFN1, dat)
dat <- read.csv("dxl2015-el6383-project/output152.txt")
names(dat) <- cnames
dat$tcp <- "reno"
dat$capacity <- 2
dat$rtt <- 2
dat$trial <- 2
LFN1 <- rbind(LFN1, dat)
dat <- read.csv("dxl2015-el6383-project/output153.txt")
names(dat) <- cnames
dat$tcp <- "reno"
dat$capacity <- 2
dat$rtt <- 2
dat$trial <- 3
LFN1 <- rbind(LFN1, dat)
LFN1$trial <- as.factor(LFN1$trial)
LFN1$tcp <- as.factor(LFN1$tcp)
library(reshape2)
LFN1 <- transform(LFN1, interval = colsplit(interval,"-", names = c('begin', 'end')))
LFN1$interval.begin <- LFN1$interval$begin
LFN1$interval.end <- LFN1$interval$end
LFN1$interval <- NULL
totals  <- LFN1[LFN1$interval.begin<=1 & LFN1$interval.end>=10,]
details <- LFN1[!(LFN1$interval.begin<=1 & LFN1$interval.end>=10),]
library(ggplot2)
q <- ggplot(details)
q <- q + scale_x_discrete("interval.begin")
q <- q + scale_y_continuous("Throughput (bps)")
q <- q + ggtitle("Lineplot of Throughput Vegas vs.Reno in Buffer 87BYTE")
q <- q + geom_point(aes(x=interval.begin, y=tput, colour=tcp))
q <- q + geom_line(aes(x=interval.begin, y=tput, colour=tcp, linetype=trial))
q
ggsave("Exper1_lineplot.png", plot=q)
q <- ggplot(details)
q <- q + scale_x_discrete("interbal.begin")
q <- q + scale_y_continuous("Throughput (bps)")
q <- q + ggtitle("Violinplot of Throughput Vegas vs.Reno in Buffer 87BYTE")
q <- q + geom_violin(aes(x=tcp, y=tput))
q
ggsave("Exper1_violinplot.png", plot=q)
