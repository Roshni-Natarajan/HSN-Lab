# Project: Data transfer using TCP and UDP


## Experiment goal
The goal of our experiment is to understand the throughput behaviour of UDP and TCP by varying 
packet sizes and link parameters like bandwidth, latency and packet loss rates.


## Experiment Parameters and Metrics
* Parameters: Bandwidth, Latency, Packet size, Packet loss rate.
* Metrics: Throughput.

## Experiment overview
In this experiment you will vary the Bandwidth and delay of the links and measure its throughput for both UDP and TCP packet transfer.
Here, for this purpose you will transfer 3 different packet size, viz., 20k, 40k, 60k.
Four cases will be evaluated in this project as follows:

  1.	Bandwidth: 100Mbps, Latency: 0ms
  2.	Bandwidth: 100Mbps, Latency: 50ms
  3.	Bandwidth: 1Gbps, Latency: 0ms
  4.    Bandwidth: 1Gbps, Latency: 50ms

Also, you will evaluate the throughput of the following cases for different packet loss rates, viz., 0.0001, 0.001, 0.005

  1.    Bandwidth: 100Mbps, Latency: 0ms
  2.    Bandwidth: 1Gbps, Latency: 0ms

The throughputs from the above cases will be compared for UDP and TCP transfer.
The raw data obtained from the above experiment will be visualised using R studio. The generated linear graphs will show the study of UDP and TCP packet flow by evaluating the throughput in both the cases with respect to varying bandwidth, latency and packet size.


## Prerequisites

This project assumes that you have picked up basic skills related to the tools in the lab. These include:

 * Log in to the GENI portal
 * Create a slice on GENI
 * Reserve simple resources using Slice Jacks
 * Find out SSH login information for slice resources from the GENI portal
 * Access GENI resources over SSH
 * Run basic commands on the Linux shell, especially commands related to directory and file structure: `cd`, `mv`, `cp`, `ls`
 * Use git to clone a repository and add/commit/push changes to the repository
 * Basic operation of R studio application for visualisation
 * Release (delete) resources in a slice when you're done with them

## Setup

### Slice creation

Log in to the [GENI portal](https://portal.geni.net/) and create a
slice.

Use this slice for the entire project. Don't create a new slice
when you need different resources, just keep deleting and adding resources
to the *same* slice.

### Reserve Resources

You'll reserve resources using the following RSpec.
```

<rspec type="request" generated_by="Flack" generated="2012-05-02T18:47:33Z" xsi:schemaLocation="http://www.geni.net/resources/rspec/3 http://www.geni.net/resources/rspec/3/request.xsd  http://www.protogeni.net/resources/rspec/ext/delay/1 http://www.protogeni.net/resources/rspec/ext/delay/1/request-delay.xsd" xmlns:flack="http://www.protogeni.net/resources/rspec/ext/flack/1" xmlns:client="http://www.protogeni.net/resources/rspec/ext/client/1" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:delay="http://www.protogeni.net/resources/rspec/ext/delay/1" xmlns="http://www.geni.net/resources/rspec/3">
  <node client_id="PC1" component_manager_id="urn:publicid:IDN+emulab.net+authority+cm" exclusive="true">
    <sliver_type name="raw-pc">
      <disk_image name="urn:publicid:IDN+emulab.net+image+emulab-ops//UBUNTU11-64-STD"/>
    </sliver_type>
    <services>
      <execute command="/local/UDTStartup.sh" shell="sh"/>
      <install install_path="/local" url="http://sourceforge.net/projects/udt/files/udt/4.10/udt.sdk.4.10.tar.gz"/>
      <install install_path="/local" url="http://www.gpolab.bbn.com/experiment-support/UDTExampleExperiment/udt-startup.tar.gz"/>
    </services>
    <interface client_id="PC1:if0">
      <ip address="192.168.2.1" netmask="255.255.255.0" type="ipv4"/>
      <flack:interface_info addressUnset="false"/>
    </interface>
    <flack:node_info x="111" y="105" unbound="true"/>
  </node>
  <node client_id="PC2" component_manager_id="urn:publicid:IDN+emulab.net+authority+cm" exclusive="true">
    <sliver_type name="raw-pc">
      <disk_image name="urn:publicid:IDN+emulab.net+image+emulab-ops//UBUNTU11-64-STD"/>
    </sliver_type>
    <services>
      <execute command="/local/UDTStartup.sh" shell="sh"/>
      <install install_path="/local" url="http://sourceforge.net/projects/udt/files/udt/4.10/udt.sdk.4.10.tar.gz"/>
      <install install_path="/local" url="http://www.gpolab.bbn.com/experiment-support/UDTExampleExperiment/udt-startup.tar.gz"/>
    </services>
    <interface client_id="PC2:if0">
      <ip address="192.168.2.2" netmask="255.255.255.0" type="ipv4"/>
      <flack:interface_info addressUnset="false"/>
    </interface>
    <flack:node_info x="375" y="370" unbound="true"/>
  </node>
  <node client_id="delay" component_manager_id="urn:publicid:IDN+emulab.net+authority+cm" exclusive="true">
    <sliver_type name="delay">
      <delay:sliver_type_shaping>
        <delay:pipe source="delay:if0" dest="delay:if1" capacity="1000000" packet_loss="0" latency="1"/>
        <delay:pipe source="delay:if1" dest="delay:if0" capacity="1000000" packet_loss="0" latency="1"/>
      </delay:sliver_type_shaping>
    </sliver_type>
    <interface client_id="delay:if0">
      <flack:interface_info addressUnset="true"/>
    </interface>
    <interface client_id="delay:if1">
      <flack:interface_info addressUnset="true"/>
    </interface>
    <flack:node_info x="236" y="221" unbound="true"/>
  </node>
  <link client_id="lan0">
    <flack:link_info x="-1" y="-1" unboundVlantag="true" xmlns="http://www.protogeni.net/resources/rspec/ext/flack/1"/>
    <flack:link_info x="-1" y="-1" unboundVlantag="true" xmlns="http://www.protogeni.net/resources/rspec/ext/flack/1"/>
    <flack:link_info x="-1" y="-1" unboundVlantag="true" xmlns="http://www.protogeni.net/resources/rspec/ext/flack/1"/>
    <flack:link_info x="-1" y="-1" unboundVlantag="true" xmlns="http://www.protogeni.net/resources/rspec/ext/flack/1"/>
    <component_manager name="urn:publicid:IDN+emulab.net+authority+cm"/>
    <interface_ref client_id="delay:if0"/>
    <interface_ref client_id="PC1:if0"/>
    <property source_id="delay:if0" dest_id="PC1:if0"/>
    <property source_id="PC1:if0" dest_id="delay:if0"/>
    <link_type name="lan"/>
    <flack:link_info x="-1" y="-1" unboundVlantag="true"/>
  </link>
  <link client_id="lan1">
    <flack:link_info x="-1" y="-1" unboundVlantag="true" xmlns="http://www.protogeni.net/resources/rspec/ext/flack/1"/>
    <flack:link_info x="-1" y="-1" unboundVlantag="true" xmlns="http://www.protogeni.net/resources/rspec/ext/flack/1"/>
    <flack:link_info x="-1" y="-1" unboundVlantag="true" xmlns="http://www.protogeni.net/resources/rspec/ext/flack/1"/>
    <flack:link_info x="-1" y="-1" unboundVlantag="true" xmlns="http://www.protogeni.net/resources/rspec/ext/flack/1"/>
    <component_manager name="urn:publicid:IDN+emulab.net+authority+cm"/>
    <interface_ref client_id="delay:if1"/>
    <interface_ref client_id="PC2:if0"/>
    <property source_id="delay:if1" dest_id="PC2:if0"/>
    <property source_id="PC2:if0" dest_id="delay:if1"/>
    <link_type name="lan"/>
    <flack:link_info x="-1" y="-1" unboundVlantag="true"/>
  </link>
</rspec>
```

You can also reserve resource using the existing Rspec (2 Raw PCs connected with delay node(Utah ProtoGENI only)) given in the Portal.
 The experiment topology will look as follows:

  ![topology](http://i.imgur.com/VTiT350.png)

## Experiment Procedure

###Viewing and Adjusting link characteristics

In this experiment, you'll be changing the characteristics of the link and measuring how they affect UDT and TCP performance.

  Log into your delay node as you do with any other node. Then, on your delay node, use this command:
    
    `%sudo ipfw pipe show`

 You'll get something like this:
```
60111: 100.000 Mbit/s    1 ms   50 sl. 1 queues (1 buckets) droptail
    mask: 0x00 0x00000000/0x0000 -> 0x00000000/0x0000
BKT Prot ___Source IP/port____ ____Dest. IP/port____ Tot_pkt/bytes Pkt/Byte Drp
  0 ip    207.167.175.72/0       195.123.216.8/6        7     1060  0    0   0
60121: 100.000 Mbit/s    1 ms   50 sl. 1 queues (1 buckets) droptail
    mask: 0x00 0x00000000/0x0000 -> 0x00000000/0x0000
BKT Prot ___Source IP/port____ ____Dest. IP/port____ Tot_pkt/bytes Pkt/Byte Drp
  0 ip   207.167.176.224/0         195.124.8.8/6        8     1138  0    0   0
```
 
 This information shows the internal configuration of the "pipes" used to emulate network characteristics. (Your output may look different, depending on the version of ipfw installed on your delay node. In any case, the information you need is on the first line of output for each pipe.)

 You'll want to make note of the two pipe numbers, one for each direction of traffic along your link. In the example above, they are 60111 and 60121.

 There are three link characteristics we'll manipulate in this experiment: bandwidth, delay, and packet loss rate. You'll find their values listed in the ipfw output above. The link bandwidth appears on the first line immediately after the pipe number. It's 100Mbps in the example shown above. The next value shown is the delay, 1 ms in the example above. The packet loss rate (PLR) is omitted if it's zero, as shown above. If non-zero, you'll see something like plr 0.000100 immediately after the "50 sl." on the first output line.

 It is possible to adjust the parameters of the two directions of your link separately, to emulate asymmetric links. In this experiment, however, we are looking at symmetric links, so we'll always change the settings on both pipes together.

 Here are the command sequences you'll need to change your link parameters. In each case, you'll need to provide the correct pipe numbers, if they're different from the example. 

To change bandwidth to 100Mbits/s:
```

sudo ipfw pipe 60111 config bw 100M
sudo ipfw pipe 60121 config bw 100M
```

To change link delay (delays are measured in ms):
```

sudo ipfw pipe 60111 config delay 50
sudo ipfw pipe 60121 config delay 50
```

To change packet loss rate (rate is a probability, so 0.001 means 0.1% packet loss):
```

sudo ipfw pipe 60111 config plr .0001
sudo ipfw pipe 60121 config plr .0001
```

You can combine settings for bandwidth, delay, and loss by specifying more than one in a single ipfw command according to the given specification.
You will use the combinations given below:

  1.    Bandwidth: 100Mbps, Latency: 0ms
  2.    Bandwidth: 100Mbps, Latency: 50ms
  3.    Bandwidth: 1Gbps, Latency: 0ms
  4.    Bandwidth: 1Gbps, Latency: 50ms
  5.    Bandwidth: 100Mbps, Latency: 0ms, Packet loss rate: 0.01%, 0.1%, 0.5%
  6.    Bandwidth: 1Gbps, Latency: 0ms, Packet loss rate: 0.01%, 0.1%, 0.5%

You'll use this form in the procedure below.


### Packet transfer using UDP
Follow these steps to transfer packets using UDP
Log into nodes pc1 and pc2 using ssh in separate windows.
  
Make pc2 as the server to listen to the link using the following command
```
  
  iperf -s
```
  
Run pc1 in the client mode using the following command format in order to obtain raw data for the throughput
```

iperf -c <pc2ipaddress> -u -l <packetsize> --reportstyle C -i 1| tee OUTPUT.txt
```

where `OUTPUT.txt` is the name of an output file you'd like to
create, it will report throughput at one second intervals,
in a comma-separated values format, and with output
saved to the `OUTPUT.txt` file. (Run `cat OUTPUT.txt` to see
the contents of the file.) Please use meaningful names for your
output files.

Each line in the output will look something like the following:

    20150215191215,10.1.1.1,38878,10.1.1.2,5001,3,0.0-1.0,27131904,217055232

This values in each line are (in order):

 1. Timestamp
 2. Source IP
 3. Source port
 4. Destination IP
 5. Destination port
 6. Begin interval - End interval (in seconds)
 7. Data transferred in this interval (Bytes)
 8. Measured throughput in this interval (bits/second)
 
For example you can get the raw data for throughput using the three cases given below.
(Following commands are for BW=100Mbps, Delay 0ms for 3 different packet sizes, viz., 20K,40K, 60K):
```
  
  iperf -c 192.168.2.2 -u -l 20000 --reportstyle C -i 1| tee Throughput_UDP_100M_0ms_20KB.txt
  iperf -c 192.168.2.2 -u -l 40000 --reportstyle C -i 1| tee Throughput_UDP_100M_0ms_40KB.txt
  iperf -c 192.168.2.2 -u -l 60000 --reportstyle C -i 1| tee Throughput_UDP_100M_0ms_60KB.txt
```

Adjust the pipe configuration by using the commands given in the above section on the delay node. Similarly generate raw data files for various combination of Bandwidths and Delays mentioned above.
 Hence, total 12 raw data files of throughput should be generated for UDP flows. 

### Packet transfer using TCP
Follow these steps to transfer packets using TCP
Log into nodes pc1 and pc2 using ssh in separate windows.
  
Make pc2 as the server to listen to the link using the following command
```
  
  iperf -s
```
  
Run pc1 in the client mode using the following command format in order to obtain raw data for the throughput
```

iperf -c <pc2ipaddress> -l <packetsize> --reportstyle C -i 1| tee OUTPUT.txt
```

For example you can get the raw data for throughput sing the three cases given below.
(Following commands are for BW=100Mbps, Delay 0ms, for 3 different packet sizes, viz., 20K,40K, 60K):
```
  
  iperf -c 192.168.2.2 -l 20000 --reportstyle C -i 1| tee Throughput_UDP_100M_0ms_20KB.txt
  iperf -c 192.168.2.2 -l 40000 --reportstyle C -i 1| tee Throughput_UDP_100M_0ms_40KB.txt
  iperf -c 192.168.2.2 -l 60000 --reportstyle C -i 1| tee Throughput_UDP_100M_0ms_60KB.txt
```
  
Adjust the pipe configuration (bandwidth and delay) by using the commands given in the above section on the delay node. Similarly generate raw data files for various combination of Bandwidths and Delays mentioned above.
 Hence, total 12 raw data files of throughput should be generated for TCP flows. 
 

### Varying the packet loss rate
This is the second part of the project where you will measure throughput varying packet loss rate of the link and keeping other link parameters constant as follows:

  1.    Bandwidth: 100Mbps, Latency: 0ms for Packet loss rate: .0001
  2.    Bandwidth: 100Mbps, Latency: 0ms for Packet loss rate: .001
  3.    Bandwidth: 100Mbps, Latency: 0ms for Packet loss rate: .005

Use similar combinations for UDP as well.
  
Hence, total 6 raw data files of throughput should be generated for TCP and UDP flows using the above combination.

With the above configurations, measure throughput using iperf as follows:(For TCP)
```

  iperf -c <pc2ipaddress> -l 25000 --reportstyle C -i 1| tee Output.txt

```
(For UDP)
```

  iperf -c <pc2ipaddress> -u -l 25000 --reportstyle C -i 1| tee Output.txt

```

For example, (BW= 100Mbps, latency=0, packet loss rate= .0001)
```

  iperf -c 192.168.2.2 -l 25000 --reportstyle C -i 1| tee Throughput_UDP_100M_0ms_20KB_.0001plr.txt
```

Adjust the pipe configuration by using the commands given in the above section on the delay node. Similarly generate raw data files for various combination of Bandwidths and Packet loss rate mentioned above.
  


## Plotting the Results using R
Get and set up a resource for logging into Rstudio.

### Log in to R Studio

If you look at your slice details in the GENI portal, you should see a hostname for your resource:

![hostname](http://i.imgur.com/A0DBO4V.png)

Copy this hostname into the address bar of your browser and hit enter. 
You should see a screen like the following:

![rstudio login](http://i.imgur.com/icT5J35.png)

Log in with the same username you use to log in to the node, 
and the password you just set up for this username on the node.

Once you're in, you should see an interface like the following:
![rstudio ui](http://i.imgur.com/nmjszdZ.png)

It includes a console, as well as some other sections for viewing data,
writing scripts, exploring the file system, viewing graphs, 
and viewing variables in your environment.

### Generating a linear graph for Throughput

* Part 1:

In order to generate a linear graph for part 1 i.e. varying bandwidth, latency and packet loss for UDP and TCP flows use the following Rscript:

```

dat2 <- read.csv("Path_to_your_raw_data_file.txt")      # reading the raw data file 
str(dat2)
cnames <- c("time", "srcip", "srcport", "dstip", 
            "dstport", "id", "interval", "data", 
            "tput")
names(dat2) <- cnames                               
dat2$Packet <- 20000                                    # packet size= 20KB
dat2$bandwidth <- 100000000                             # Bandwidth = 100M
dat2$flowtype <- "TCP"                                  # TCP flow
mean(dat2$tput)
var(dat2$tput)
length(dat2$tput)
range(dat2$tput)
all2 <- dat2



dat2 <- read.csv("Path_to_your_raw_data_file.txt")
names(dat2) <- cnames
dat2$Packet <- 40000                                    # packet size= 40KB
dat2$bandwidth <- 100000000                             # Bandwidth = 100M
dat2$flowtype <- "TCP"                                  # TCP flow
all2 <- rbind(all2, dat2)


dat2 <- read.csv("Path_to_your_raw_data_file.txt")
names(dat2) <- cnames
dat2$Packet <- 60000                                    # packet size= 60KB
dat2$bandwidth <- 100000000                             # Bandwidth = 100M                      
dat2$flowtype <- "TCP"                                  # TCP flow
all2 <- rbind(all2, dat2)


dat2 <- read.csv("Path_to_your_raw_data_file.txt")
names(dat2) <- cnames
dat2$Packet <- 20000                                    # packet size= 20KB
dat2$bandwidth <- 100000000                             # Bandwidth = 100M
dat2$flowtype <- "UDP"                                  # UDP flow
all2 <- rbind(all2, dat2)


dat2 <- read.csv("Path_to_your_raw_data_file.txt")
names(dat2) <- cnames
dat2$Packet <- "40000"                                    # packet size= 40KB
dat2$bandwidth <- 100000000                               # Bandwidth = 100M
dat2$flowtype <- "UDP"                                    # UDP flow
all2 <- rbind(all2, dat2)

dat2 <- read.csv("Path_to_your_raw_data_file.txt")
names(dat2) <- cnames
dat2$Packet <- 60000                                      # packet size= 60KB
dat2$bandwidth <- 100000000                               # Bandwidth = 100M
dat2$flowtype <- "UDP"                                    # UDP flow
all2 <- rbind(all2, dat2)


all2$Packet <- as.factor(all2$Packet)
str(all2)

library(reshape2)
all2 <- transform(all2, interval = colsplit(interval,"-", names = c('begin', 'end')))
all2$interval.begin <- all2$interval$begin
all2$interval.end <- all2$interval$end
all2$interval <- NULL
all2$interval.begin
all2$interval.end 
totals  <- all2[all2$interval.begin<=1 & all2$interval.end>=10,]
details <- all2[!(all2$interval.begin<=1 & all2$interval.end>=10),]
library(ggplot2)
q2 <- ggplot(details)
q2 <- q2 + geom_point(aes(x=interval.begin, y=tput))
q2
q2 <- ggplot(details)
q2 <- q2 + geom_point(aes(x=interval.begin, y=tput, colour=Packet))
q2
q2 <- ggplot(details)
q2 <- q2 + geom_point(aes(x=interval.begin, y=tput, colour=Packet))
q2 <- q2 + geom_line(aes(x=interval.begin, y=tput, colour=Packet, linetype=flowtype))
q2
ggsave("tcp_udp_plot1.png", plot=q2)      # generating png file of the graph
```

* Part 2:

In order to generate a linear graph for Part 2 i.e. varying packet loss rate for UDP and TCP flows use the following Rscript:

```

dat2 <- read.csv("Path_to_your_files.txt")                        #Reading the Raw data file
str(dat2)
cnames <- c("time", "srcip", "srcport", "dstip", 
            "dstport", "id", "interval", "data", 
            "tput")
names(dat2) <- cnames
dat2$lossrate <- .0001                                           #loss rate= 0.01%
dat2$bandwidth <- 1000000                                        #bandwidth= 100M
dat2$flowtype <- "TCP"                                           # flow type= TCP
mean(dat2$tput)
var(dat2$tput)
length(dat2$tput)
range(dat2$tput)
all2 <- dat2



dat2 <- read.csv("el6383-project/Packet_Loss_Throughput/TCP_100M_25K_0ms_.001_plr.txt")
names(dat2) <- cnames
dat2$lossrate <- .001                                           #loss rate= 0.1%
dat2$bandwidth <- 1000000                                       #bandwidth= 100M
dat2$flowtype <- "TCP"                                          # flow type= TCP
all2 <- rbind(all2, dat2)


dat2 <- read.csv("el6383-project/Packet_Loss_Throughput/TCP_100M_25K_0ms_.005_plr.txt")
names(dat2) <- cnames
dat2$lossrate <- .005                                           #loss rate= 0.5%
dat2$bandwidth <- 1000000                                       #bandwidth= 100M
dat2$flowtype <- "TCP"                                          # flow type= TCP
all2 <- rbind(all2, dat2)


dat2 <- read.csv("el6383-project/Packet_Loss_Throughput/UDP_100M_25K_0ms_.0001_plr.txt")
names(dat2) <- cnames
dat2$lossrate <- .0001                                         #loss rate= 0.01%
dat2$bandwidth <- 1000000                                      #bandwidth= 100M
dat2$flowtype <- "UDP"                                         # flow type= UDP
all2 <- rbind(all2, dat2)


dat2 <- read.csv("el6383-project/Packet_Loss_Throughput/UDP_100M_25K_0ms_.001_plr.txt")
names(dat2) <- cnames
dat2$lossrate <- .001                                          #loss rate= 0.1%
dat2$bandwidth <- 1000000                                      #bandwidth= 100M
dat2$flowtype <- "UDP"                                         # flow type= UDP
all2 <- rbind(all2, dat2)

dat2 <- read.csv("el6383-project/Packet_Loss_Throughput/UDP_100M_25K_0ms_.005_plr.txt")
names(dat2) <- cnames
dat2$lossrate <- .005                                          #loss rate= 0.5%
dat2$bandwidth <- 1000000                                      #bandwidth= 100M
dat2$flowtype <- "UDP"                                         # flow type= UDP
all2 <- rbind(all2, dat2)


all2$lossrate <- as.factor(all2$lossrate)
str(all2)

library(reshape2)
all2 <- transform(all2, interval = colsplit(interval,"-", names = c('begin', 'end')))
all2$interval.begin <- all2$interval$begin
all2$interval.end <- all2$interval$end
all2$interval <- NULL
all2$interval.begin
all2$interval.end 
totals  <- all2[all2$interval.begin<=1 & all2$interval.end>=10,]
details <- all2[!(all2$interval.begin<=1 & all2$interval.end>=10),]
library(ggplot2)
q2 <- ggplot(details)
q2 <- q2 + geom_point(aes(x=interval.begin, y=tput))
q2
q2 <- ggplot(details)
q2 <- q2 + geom_point(aes(x=interval.begin, y=tput, colour=lossrate))
q2
q2 <- ggplot(details)
q2 <- q2 + geom_point(aes(x=interval.begin, y=tput, colour=lossrate))
q2 <- q2 + geom_line(aes(x=interval.begin, y=tput, colour=lossrate, linetype=flowtype))
q2
ggsave("tcp_udp_PLthroughput_100M_25k_0ms.png", plot=q2)        #Generating a PNG image of the graph
```

In order to generate a bar graph of confidence interval for Part 2 i.e. varying packet loss rate for UDP and TCP flows use the following Rscript:

```

dat2 <- read.csv("el6383-project/Throughput/Throughput_TCP_100M_0ms_20KB.txt")
str(dat2)
cnames <- c("time", "srcip", "srcport", "dstip", 
            "dstport", "id", "interval", "data", 
            "tput")
names(dat2) <- cnames
dat2$Packet <- 20000
dat2$bandwidth <- 100000000
dat2$flowtype <- "TCP"
mean(dat2$tput)
var(dat2$tput)
length(dat2$tput)
range(dat2$tput)
all2 <- dat2



dat2 <- read.csv("el6383-project/Throughput/Throughput_TCP_100M_0ms_40KB.txt")
names(dat2) <- cnames
dat2$Packet <- 40000
dat2$bandwidth <- 100000000
dat2$flowtype <- "TCP"
all2 <- rbind(all2, dat2)


dat2 <- read.csv("el6383-project/Throughput/Throughput_TCP_100M_0ms_60KB.txt")
names(dat2) <- cnames
dat2$Packet <- 60000
dat2$bandwidth <- 100000000
dat2$flowtype <- "TCP"
all2 <- rbind(all2, dat2)

dat2 <- read.csv("el6383-project/Throughput/Throughput_UDP_100M_0ms_20KB.txt")
names(dat2) <- cnames
dat2$Packet <- "20000"
dat2$bandwidth <- 100000000
dat2$flowtype <- "UDP"
all2 <- rbind(all2, dat2)

dat2 <- read.csv("el6383-project/Throughput/Throughput_UDP_100M_0ms_40KB.txt")
names(dat2) <- cnames
dat2$Packet <- "40000"
dat2$bandwidth <- 100000000
dat2$flowtype <- "UDP"
all2 <- rbind(all2, dat2)

dat2 <- read.csv("el6383-project/Throughput/Throughput_UDP_100M_0ms_60KB.txt")
names(dat2) <- cnames
dat2$Packet <- 60000
dat2$bandwidth <- 100000000
dat2$flowtype <- "UDP"
all2 <- rbind(all2, dat2)

all2$Packet <- as.factor(all2$Packet)
str(all2)

library(reshape2)
all2 <- transform(all2, interval = colsplit(interval,"-", names = c('begin', 'end')))
all2$interval.begin <- all2$interval$begin
all2$interval.end <- all2$interval$end
all2$interval <- NULL
all2$interval.begin
all2$interval.end 
totals  <- all2[all2$interval.begin<=1 & all2$interval.end>=10,]
details <- all2[!(all2$interval.begin<=1 & all2$interval.end>=10),]

## Summarizes data.
## Gives count, mean, standard deviation, standard error of the mean, and confidence interval (default 95%).
##   data: a data frame.
##   measurevar: the name of a column that contains the variable to be summariezed
##   groupvars: a vector containing names of columns that contain grouping variables
##   na.rm: a boolean that indicates whether to ignore NA's
##   conf.interval: the percent range of the confidence interval (default is 95%)
summarySE <- function(data=NULL, measurevar, groupvars=NULL, na.rm=FALSE,
                      conf.interval=.95, .drop=TRUE) {
  library(plyr)
  
  # New version of length which can handle NA's: if na.rm==T, don't count them
  length2 <- function (x, na.rm=FALSE) {
    if (na.rm) sum(!is.na(x))
    else       length(x)
  }
  
  # This does the summary. For each group's data frame, return a vector with
  # N, mean, and sd
  datac <- ddply(data, groupvars, .drop=.drop,
                 .fun = function(xx, col) {
                   c(N    = length2(xx[[col]], na.rm=na.rm),
                     mean = mean   (xx[[col]], na.rm=na.rm),
                     sd   = sd     (xx[[col]], na.rm=na.rm)
                   )
                 },
                 measurevar
  )
  
  # Rename the "mean" column    
  datac <- rename(datac, c("mean" = measurevar))
  
  datac$se <- datac$sd / sqrt(datac$N)  # Calculate standard error of the mean
  
  # Confidence interval multiplier for standard error
  # Calculate t-statistic for confidence interval: 
  # e.g., if conf.interval is .95, use .975 (above/below), and use df=N-1
  ciMult <- qt(conf.interval/2 + .5, datac$N-1)
  datac$ci <- datac$se * ciMult
  
  return(datac)
}

sum <- summarySE(details, measurevar="tput", groupvars=c("flowtype", "interval.begin"), na.rm=TRUE)
sum

sum2 <- sum
sum2$interval.begin <- factor(sum2$interval.begin)

library(ggplot2)
pd <- position_dodge(0.1)

q2 <- ggplot(sum2, aes(x=interval.begin, y=tput, fill=flowtype)) + 
  geom_bar(position=position_dodge(), stat="identity",
           colour="black", # Use black outlines,
           size=.3) +      # Thinner lines
  geom_errorbar(aes(ymin=tput-ci, ymax=tput+ci),
                size=.3,    # Thinner lines
                width=.2,
                position=position_dodge(.9)) +
  xlab("interval.begin") +
  ylab("Throughput") +
  scale_fill_hue(name="Flowtype", # Legend label, use darker colors
                 breaks=c("TCP", "UDP")) +
  ggtitle("Confidence intervals for throughputs of TCP and UDP") +
  theme_bw()
q2
ggsave("TCP_UDP_Confidence_Interval_100M.png", plot=q2)
```

## Release resources
Please release all your GENI resources once you have finished the experiment.

 
## Results

Here we discuss the experimental results obtained for the created setup.

We first observe the average throughput achieved by UDP and TCP for a variety of conditions. Figure 1 consists of 4 plots showing the average throughput
for UDP and TCP with different packet for four different Bandwidth and Delay combination.
  1.  Plot 1: Bandwidth=100Mbps Latency:0ms
  2.  Plot 2: Bandwidth=100Mbps Latency:50ms
  3.  Plot 3: Bandwidth=1Gbps Latency:0ms
  4.  Plot 4: Bandwidth=1Gbps Latency:50ms

 Figure 1:
 ![Throughput](http://i.imgur.com/PzVmKvA.png)
 
In the second part, we measure throughputs achieved by UDP and TCP for packet loss rates of 0.0001, 0.001 and 0.005:
 Figure 2:
 ![Packetloss](http://i.imgur.com/di8YpuZ.png)
 
Also, we showcase the bar graphs of confidence interval for part 2.
  Figure 3:
  ![ConfidenceInterval](http://i.imgur.com/qI3kLzq.png)
 
## Conclusion

  * Part 1:
  
  a) Effect of Packet size on throughput:
  
TCP: For constant Bandwidth and Delay, when we change packet size of the data, throughput remains constant.
UDP: For constant Bandwidth and Delay, when we change packet size of the data, throughput remains constant.

  b) Effect of Bandwidth on throughput: (Comparing plot 1 and 3 or plot 2 and 4)

TCP: For constant latency and packet size, when we increase the bandwidth, throughput also increases
UDP: No observable changes.

  c) Effect of latency on throughput: (Comparing plot 1 and 2 or plot 3 and 4)

TCP: For constant bandwidth and packet size, when we increase the latency, throughput decreases.
UDP: No observable change.

The showcased result has demonstrated that TCP throughputs significantly sffers in high Bandwidth networks especially with long delays, and the impact of loss was 
relatively less critical than delay on the TCP throughput. 

  * Part 2:
  
TCP: For constant bandwith, latency and packet size ,when we change the packet loss rate throughput decreases as the packet loss rate increases.
UDP: No observable change.


## References
  
http://groups.geni.net/geni/wiki/UDTExampleExperiment

