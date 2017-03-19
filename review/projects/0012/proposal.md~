Project Proposal for EL6383
===========================


## Project idea

Our project is related to Weighted Fair Queue(WFQ) in scheduling. WFQ is a data packet scheduling implemented on many routers. It allows proportional fair allocation of banwidth among flows.
Suppose that two hosts in a family are connected to an edge router. One of the host is using some application that generates large data flows like downloading. 
The other one is using some delay-sensitive application like Skype. The large data packets of downloading may cause a higher delay in Skype. 
WFQ can ensure a relatively fair bandwidth allocation between this two flows.

The goal of our experiment is to study the effect of WFQ under a situation where a small data flow is competing with a large data flow in a network with relatively large bandwidth and in a network with relatively small bandwidth.
In each network environment, we will compare the performance of the application generating small data flows when WFQ is on and off. 


## Experiment design

The service we are going to study is WFQ implemented on routers. The network topology of our experiment is as followed:

![](https://lh4.googleusercontent.com/-kkLgkHP8ZTA/VRitEQ1uBAI/AAAAAAAAACk/eYs2Kz1Y79E/w1020-h492-no/network.png)

We will measure the delay from the `ping` output from *server* to *client*. Two parameters are to be varied in our experiment.
One is whether WFQ is on or off in both routers. The other one is the bandwidth of the network.

We are going to set four experiment units as followed:

| Unit No.| Unit Name | WFQ status | Bandwidth of each link |
|:-------:|:---------:|:----------:|:----------------------:|
|1        |off10m     |off         | 10 Mbps                |
|2        |on10m      |on          | 10 Mbps                |
|3        |off100m    |off         | 100 Mbps               |
|4        |on100m     |on          | 100 Mbps               |

The network environment with 10Mbps bandwidth is designed to model the network service in a normal household. 
The network environment with 100Mbps is designed to model the network service in a company. 
Although the network bandwidth in households and companies vary in a large range, the moderate settings of our bandwidths still describe a typical network environment.

We will use `iperf` in our experiment as a tool to generate large data flows from *server* to *client*.
`ping` will be used to evaluate the delay of small data flows from *server* to *client*. The output of `ping` will be redirected to files as raw data.
We will use `R studio` to perform data processing, data analyzing and data visualizing. The average delay and the delay changing over time are the two main aspects we are going to study. 
We will compare the the results of the four experiment units to inspect interactions between the two parameters. 

For each network we are expected to create two visualizations. One is a dotplot of the delay related to time. One is a violinplot of the delay related to time. 
As a summary of all the experiment units, we will also have a barplot of the average delay in each experiment unit. The sketches of the visualizations are as followed:

![](https://lh4.googleusercontent.com/-_mibzdw5TE8/VRi4IzZ57HI/AAAAAAAAADA/opaihpvlNvo/w1187-h812-no/dotplot.png)
![](https://lh3.googleusercontent.com/-FSEPelytjmo/VRi4I1gya-I/AAAAAAAAADI/tDK49FgiX70/w1175-h812-no/vioplot.png)
![](https://lh5.googleusercontent.com/-6yFOsM33nCY/VRi4I-YZGCI/AAAAAAAAADE/A-VD1seUK5g/w1437-h776-no/barplot.png)


