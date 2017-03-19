#I.	EXPERIMENT DESIGN

###Goal:
To analyze the performance of two transport protocols TCP and UDP on a network implementing OSPF routing protocol. The Data Transfer Rate and Throughput are measured while varying Link Latency (100ms, 200ms, 300ms) and taking down links (0 to 2) along the shortest path.

###Parameters varied:
 * Transport Protocols (TCP and UDP)
 * Latency (100ms, 200ms, 300ms)
 * Number of links taken down (0, 1, 2) 
 
###Metrics:
 * Data transfer rate
 * Throughput

###Data collection tool:

 * iperf

###Data analysis tool:

 * R

###Topology:
![Topology](http://s21.postimg.org/6gxu9y3nb/Topology.jpg)

#II.	PREREQUISITES

This project assumes that you have completed the lab exercises taught in class and are comfortable with the techniques practiced in those lab exercises. These will be used in this project, but may not be explained in detail; you're expected to remember how to do them.

These include:

 * Understand basic GENI terminology
 * Log in to the GENI portal
 * Create a slice on GENI
 * Reserve simple resources using Slice Jacks
 * Find out SSH login information for slice resources from the GENI portal
 * Access GENI resources over SSH
 * Use ifconfig, ping, and iperf
 * Use basic Linux tools
 * Follow instructions to reproduce an experiment
 * Cloning

#III.	LOGGING INTO EXISTING SETUP ON GENI

This step only explains how to login to our existing setup on GENI. Details on performing the experiment are mentioned later-on in the report.
Using the credentials provided below, you can access each of our VMs.

Login credentials:

 * **Router 1**: 	ssh guest@pc2.instageni.idre.ucla.edu -p 33083
 * **Router 2**: 	ssh guest@pc2.instageni.idre.ucla.edu -p 33084
 * **Router 3**: 	ssh guest@pc2.instageni.idre.ucla.edu -p 33085
 * **Router 4**: 	ssh guest@pc2.instageni.idre.ucla.edu -p 33086
 * **Router 5**: 	ssh guest@pc2.instageni.idre.ucla.edu -p 33087
 * **Router 6**: 	ssh guest@pc2.instageni.idre.ucla.edu -p 33088
 * **Client**: 	    ssh guest@pc2.instageni.idre.ucla.edu -p 33082
 * **Server**:		ssh guest@pc2.instageni.idre.ucla.edu -p 33089

Password: 		el6383s2015

For your convenience we have kept copies of our output files in the “SERVER”. The path is:
    
    cd /users/output_files

#IV.	EXPERIMENTAL SETUP

1) Upload the Rspec provided to you. You should see the below topology with 6 routers between a client and server. We have used the aggregate of UCLA InstaGENI.

![UCLA Topology](http://s14.postimg.org/u1tbaj34x/UCLA_Topology.png)

2) Reserve resources for the provided Rspec.

3) Once all the resources are ready, use the ssh login provided to open each router, client and server in individual terminals.

![ssh_login](http://s7.postimg.org/kdebh3aij/ssh_link.png)

4) Now we will install XORP 1.8.5 on Ubuntu 12.04.

Install Dependencies:
```
$sudo apt-get update
$sudo apt-get install libssl-dev
$sudo apt-get install ncurses-dev
$sudo apt-get install libpcap-dev
$sudo apt-get install g++ traceroute
$sudo apt-get install scons
```
Download XORP source files
```
$cd ~/
$wget http://www.xorp.org/releases/current/xorp-1.8.5-src.tar.bz2
$tar jvxf xorp-1.8.5-src.tar.bz2
```
Compile and build XORP
```
$cd xorp
$scons
$sudo scons install
```

5)	Automate OSPF

To test the automation we login to each router and run the following commands.
```
av1540@router-1:~$ cd /local
av1540@router-1:/local$ sudo wget http://www.gpolab.bbn.com/exp/sysexpr/xorp_autostart.tar.gz
av1540@router-1:/local$ sudo tar -zxvf xorp_autostart.tar.gz
av1540@router-1:/local/xorp_autostart$ /bin/bash start-xorp.sh
```
You should see a similar output
```
router-1.av1540-wiki-prep.ch-geni-net.instageni.stanford.edu
2014-07-01 06:56:28 AM
XORP dir exist
xorp is already added to the group
xorp is running, stop it first
XORP is starting ......
Not doing pidfile...
```

6)	Verify the XORP process is running

    av1540@router-1:/usr/local/xorp/sbin$ ps -ef | grep xorp

You should see a similar output
```
root   1972   1  0 13:30 ?   00:00:02 xorp_fea
root   1973   1  0 13:30 ?   00:00:00 xorp_rib
root   1974   1  0 13:30 ?   00:00:00 xorp_policy
root   1975   1  0 13:30 ?   00:00:01 xorp_ospfv2
root   1976   1  0 13:30 ?   00:00:00 ./xorp_rtrmgr -b /etc/xorp/ospfd.conf -l /tmp/xorp_rtrmgr_log -d
```
#V.	DATA COLLECTION

*(Perform the below mentioned tasks for TCP and UDP)*

Measure **THROUGHPUT** and **DATA TRANSFER RATE** using 3 delays (100ms, 200ms, 300ms) for each of the 3 *scenarios* mentioned below.

**(a)**	When all links are up

**(b)**	When 1 link is down.

**(c)**	When 2 links are down

##**PROCEDURE**

**(1)** Introduce delay

**(2)** Identify which link to drop, using traceroute (for the above *scenarios* **(b)** and **(c)**)

**(3)** Measure Throughput

**(4)** Measure Data Transfer Rate

*(NOTE: The same procedure needs to be implemented for TCP and UDP)*

##How to introduce **Delay**

Add Delay to the server, client and the interfaces of the routers connected to the server and client (ie; *Client > eth1, Server > eth1, Router1 > eth3 and Router6 > eth3*).

Keep jitter constant (*10ms*). Vary Delay to be 100ms, 200ms, 300ms.

    tc qdisc add dev IFNAME root netem delay DELAYms 10ms

where IFNAME is the name of the data interface, DELAY is the amount of average latency you want to add in milliseconds, and JITTER is the amount of variation in latency you want to add in milliseconds.

To remove the emulated latency on an interface, run

    tc qdisc del dev IFNAME root

##How to measure **Throughput for TCP** 

i.	Throughput is measured using iperf

ii.	Implement iperf on the server using the following command for TCP

    iperf -s
    
iii.	Implement iperf on the client using the following command for TCP

    iperf -c 192.168.20.11 --reportstyle C  -i 1 | tee OUTPUT.txt

##How to measure **Throughput for UDP**

i.	Throughput is measured using iperf

ii.	Implement iperf on the server using the following command for UDP

    iperf –s -u
    
iii.	Implement iperf on the client using the following command for UDP.

    iperf -c 192.168.20.11 –u --reportstyle C  -i 1 | tee OUTPUT.txt

##How to measure **Data Transfer Rate**

i.	Data transfer rate is measured using iperf.

ii.	This information is listed on the server side of the iperf output.

iii.	Note down this information as it will be needed for the R script.

##How to identify which **Link(s) to Drop**

i.	This step should be performed only for scenarios (b) and (c). (ie; when 1 or 2 links are down)

ii.	Do a traceroute to find the hop information between the server and client.

iii.	Randomly choose links to turn down based on the traceroute output obtained.

#VI.	SETTING UP DATA ANALYSIS ENVIRONMENT (R)


##1)    Set up resource 

a.	Login to geni and create a new slice

b.	Using Slice Jacks, request one node in this slice on your assigned aggregate (NYU Instageni)

c.	Name the node ‘rstudio’ and request a publicly routable IP address for it (by checking the "Publicly Routable IP" checkbox).

d.	Reserve the resource.

e.	Once resource is ready, log in and install git
```
sudo apt-get update
sudo apt-get install git
```
f.	clone the local repository where all the data from experiments are committed

g.	provide authentication using: sudo passwd USERNAME

h.	Install R and R studio and libraries
```
wget http://download2.rstudio.org/rstudio-server-0.98.1102-amd64.deb
sudo su
gpg --keyserver keyserver.ubuntu.com --recv-key E084DAB9
gpg -a --export E084DAB9 | apt-key add -
echo "deb http://cran.wustl.edu/bin/linux/ubuntu precise/" >> /etc/apt/sources.list
apt-get update
apt-get install r-base r-cran-rcpp
dpkg -i rstudio-server-0.98.1102-amd64.deb
echo "www-port=80" >>  /etc/rstudio/rserver.conf
rstudio-server restart
R
install.packages("codetools")
install.packages("plyr")
install.packages("MASS")
install.packages("ggplot2")
install.packages("reshape2")
quit('no')
exit
```

##2)	Using R
a.	Login to R studio

 * In the GENI portal, copy paste the hostname of your resource in your browser and hit enter
 * Login with the your credentials
 
b.	dat is the data structure where all the data is recorded 
```
dat<-read.csv("el6383-project-mpls/submit/client/tcp_100.txt")
cnames <- c("time", "srcip", "srcport", "dstip","dstport", "id", "interval", "data", "tput")
names(dat)<-cnames
dat$protocol <- "tcp"
dat$delay <- 100
dat$transfer_rate <- 1380000 (data seen from the server file)
NoneDown <- dat
```
c.	‘dat’ structures are updated for each files and using rbind, all the files are collected

d.	The files relating to ‘all links up file’ is inserted into a single node and bar grouped chart of throughput vs delay and also transfer rate vs delay is plotted

e.	The R script is provided which indicates the exact steps implemented

f.	Similarly, graphs for files relating to ‘1 link down’ and ‘2 links down’ are obtained

g.	All the graphs are saved and so is the script


#VII.	GRAPHICAL REPRESENTATION

![plot1](http://s11.postimg.org/4n33dnhbn/Plot1.png)
![plot2](http://s30.postimg.org/a3js9ufdd/Plot2.png)
![plot3](http://s13.postimg.org/gck9usyd3/Plot3.png)
![plot4](http://s1.postimg.org/628fvm0y7/Plot4.png)
![plot5](http://s1.postimg.org/ox46m10zz/Plot5.png)
![plot6](http://s15.postimg.org/asdb157hn/Plot6.png)

#VIII.	CONCLUSION: 

##Data Transfer Rate:
  * TCP transfer rate decreases with increase in delay. However the bringing down a few links does not have an effect on it.
  * UDP transfer rate remains constant irrespective of bringing down a few links or varying the delay.

##Throughput:
  * TCP has higher throughput when compared to UDP for all delays when all links are up. But when we take down links, the TCP throughput varies according to the shortest path configured by OSPF.
  * UDP throughput remains constant regardless of the shortest path configured by OSPF.
