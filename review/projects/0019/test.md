#EL6383 High Speed Network#
##[Final Project Report]##
Group Member   | NetID
-------------- | --------------------
Runze Dong     | rd1711
Yin Xu         | yx758 
Ying Li        | yl3004 


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
TCP Reno usually occupies more bandwidth than TCP Reno. Compare four tests, we can also conclude that when buffersize gets larger, 
TCP Reno tends to occupy more and more bandwidth.

###Conclusion
In this project, we have proved the incompatibility between TCP Vegas and TCP Reno via simulation in GENI. Our experiment 
shows that TCP Reno tends to occupy more bandwidth than TCP Vegas when it comes to congestion. We analyse that TCP Vegas 
and TCP Reno how to compete the bandwidth in heterogeneous network environments. We find that TCP Reno performs more aggressive 
when buffersize gets bigger. 








