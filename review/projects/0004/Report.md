Goal of the project:

The goal of our project is to analyze and compute the different metrics for routing protocols and compare their results using parameters to measure the performances of routing protocols OSPF and RIP. 

Experiment Design:

We have used Open Shortest Path First (OSPF) and Routing Information Protocol (RIP) as two routing protocols and their results are compared to measure their performance under given conditions. For the topology design, we have used a 4-node topology in both the cases. We have used different parameters and metrics to perform a thorough comparison of two routing protocols. Further information about the experiment is given in below sections. We decided to use a 7-node topology to provide more comparisons and data, but the reservation of the resources failed in Geni so we have no choice but to give it up. But we will provide the Rspect for 7-node topology and anyone who could reserve the resources on Geni can just follow the same steps as 4-node to reproduce the experiment with the actual IP addresses.  
Configuration of  protocols: we use OSPF 4-node Rspect as the basic resources. The OSPF experiment could be done using this Rspect. After doing OSPF, we have to change the protocol from OSPF to RIP manually. First we login to each router, run the commad:
      
      sudo vi /etc/xorp/ospfd.conf

This file is the configuration file. Take router1 as example, there are several key information we observed:

Interface information:

![](http://ww4.sinaimg.cn/mw690/a1d340bajw1er9jwqab1tj20hw0cudht.jpg)


OSPF:

![](http://ww3.sinaimg.cn/mw690/a1d340bajw1er9jwsz6nwj20ik0j4wfz.jpg)

What we have to do is to change OSPF to RIP. We leave the interfaces unchanged, and replace OSPF codes (all codes of protocol function) with RIP codes:

![](http://ww3.sinaimg.cn/mw690/a1d340bajw1er9jwvwntnj20mq0jgwg6.jpg)

![](http://ww3.sinaimg.cn/mw690/a1d340bajw1er9jwymja4j20n60o8taz.jpg)

![](http://ww2.sinaimg.cn/mw690/a1d340bajw1er9jx27bp3j20iu0l8mys.jpg)

This link shows how to configure routing protocols under XORP:

http://www.xorp.org/getting_started.html#configuring

The conf file is also submitted for the 4 routers for reference, but reviewers do not need to do this part, just log into the nodes reserved and all routers’ already configured.

Parameters used for comparison of Routing protocols:

We have used Round Trip Time as a parameter in order to compare the two routing protocols. Round Trip Time or abbreviated as RTT is the amount of time taken by the packet to be transferred to destination from source along with the time it takes for destination to acknowledge the received packet to source. 

Metrics used to measure the performance of protocols:

The number of hop counts a protocol needs to reach the destination is one of the metrics we have calculated as a part of this project. For a routing protocol, the time consumed is a major basis of comparison of its efficiency. As number of hop counts increase, it also increases the RTT thus bringing down the overall efficiency of the routing protocol. Although, time consumed is one of the grounds for comparison, the maximum number of hop counts a protocol can limit itself to also plays a major role. We know that RIP has a maximum hop count of 15 and enters a count to infinity problem if it goes above 15. This is when OSPF can be used to build a larger topology. Apart from that, we have also measured the Throughput of these routing protocols using TCP and UDP. The results obtained for TCP are much higher as compared to UDP connection. We have also computed the Routing table for both protocols 

Explanation:

Router is a device that forwards data packets between computer networks, creating an overlay internetwork. It is connected to two or more data lines from different networks. When a data packet comes in on one of the lines, the router reads the address information in the packet to determine its ultimate destination. Then, using information in its routing table or routing policy, it directs the packet to the next network on its journey. It is a data table stored in a router or a networked computer that lists the routes to particular network destinations, and in some cases, metrics (distances) associated with those routes. They contain information about the topology of the network immediately around it.

The topology used for both routing protocols (OSPF and RIP) is the same. This is because we wanted to compare the results of parameters used. An effective comparison is possible only if we use same conditions and parameters for both and so we haven’t changed the topology. And we should also use the same aggregate for both protocols. We have also tried for the 7-node topology for OSPF and wanted to compare the results with its counterpart, RIP, but weren’t able to ping the server from the client. So, we have collected the data for both routing protocols only for a 4-node topology. 

Data Collection and Analysis:

We have compared the Round Trip Time collected by using traceroute command. This command gives us the time it needed to reach the subsequent router and the total time the packet needed to reach the server. The RTT is measured by traceroute command and each command makes three measurements. This gives us a table presented in the images below. We have also computed the routing table for the routing protocols when all the routers are working and when Router is down. Apart from these, the Throughput is measured for both routing protocols in case of TCP and UDP. Analyzing those results conclude that TCP connection gives much higher throughput than UDP connection.

Experiment steps: 

OSPF stands for Open Shortest Path First. It uses Link State Algorithm. It is the most widely used Interior Gateway Protocol. It gathers information about its neighboring routers only, and accordingly figures out the shortest path top reach the destination. It keeps a track of all the various links and sends the packet to destination accordingly. The primary function of a routing protocol is to construct a routing table. It then chooses the best path that takes lesser time and lower cost to reach the destination. It doesn’t use TCP and UDP protocols to transmit the packets but we have used them in this project only to measure the variance in Throughput using different protocols for OSPF.  We have used GENI testbed in order to compute the metrics and use different parameters to measure the performance of the protocol. We have used MS-Excel in order to communicate the results due to its ease and availability. 

Below, we have given the steps to perform metric measurements on this Routing protocol.

The steps for OSPF are as given below:

1.	Open terminal.

2.	Log into reserved recourse using the commands:

client: ssh guest@pc1.geni.it.cornell.edu -p 31034

server: ssh guest@pc1.geni.it.cornell.edu -p 31039

router1: ssh guest@pc1.geni.it.cornell.edu -p 31035

router2: ssh guest@pc1.geni.it.cornell.edu -p 31036

router3: ssh guest@pc1.geni.it.cornell.edu -p 31037

router4: ssh guest@pc1.geni.it.cornell.edu -p 31038

The passwords are: el6383s2015

The topology is:

![](http://ww3.sinaimg.cn/mw690/a1d340bajw1er9invg9qaj20dj08b3yq.jpg)

3.	Log into the ‘Client’ and ‘Server’. Once, we are logged in, we can check the IP addresses using ifconfig. Then we ping server (192.168.20.10) from the client (192.168.10.11). 

guest@client:~$ ping 192.168.20.10

PING 192.168.20.10 (192.168.20.10) 56(84) bytes of data.

64 bytes from 192.168.20.10: icmp_req=1 ttl=61 time=3.68 ms

64 bytes from 192.168.20.10: icmp_req=2 ttl=61 time=3.04 ms

64 bytes from 192.168.20.10: icmp_req=3 ttl=61 time=2.59 ms

64 bytes from 192.168.20.10: icmp_req=4 ttl=61 time=2.97 ms

64 bytes from 192.168.20.10: icmp_req=5 ttl=61 time=2.37 ms


4.	Run traceroute to the server using command

 traceroute 192.168.20.10

With this command, we get the Round Trip Time taken by the packet to reach the server and the path it has taken while doing so.

![](http://ww1.sinaimg.cn/mw690/a1d340bajw1er9inx3rsaj20p003ymyy.jpg) 

5.	Now, in order to get the routing table, we have to log into the router (e.g. Router 2), and run the command route.

![](http://ww4.sinaimg.cn/mw690/a1d340bajw1er9io2u627j20p008xq6l.jpg)

6.	We have to use iperf to measure the Throughput of the TCP and UDP protocols for OSPF. This can be done by logging into client and servers simultaneously and make the server to listen to client and use command to measure the Throughput for TCP connection.

Server Side :

Command: iperf -s -t 10 -i 1

![](http://ww3.sinaimg.cn/mw690/a1d340bajw1er9io4pm2hj20o10ahq6z.jpg)


client side:

command: iperf -c 192.168.20.10 -t 10 -i 1

![](http://ww1.sinaimg.cn/mw690/a1d340bajw1er9io802m8j20o10aywiv.jpg)

7.	Now, we would measure the Throughput for OSPF using UDP protocol. Repeat step 5 by adding –u in the command used to measure Throughput in the above case.

Server side:

Command: iperf -s -t 10 -i 1 –u

![](http://ww4.sinaimg.cn/mw690/a1d340bajw1er9ioc743yj20o10b079s.jpg)

client side:

command: iperf -c 192.168.20.10 -t 10 -i 1 -u

![](http://ww3.sinaimg.cn/mw690/a1d340bajw1er9ioibq8mj20o10fkjxa.jpg)

8.	The above results were obtained when all the links are working and all the routers are used for connection. For, the next part we would take the Router 2 eh1 link down and measure the same metrics again and compare the results.

9.	In order to perform this part, we have to log into Router 2 and use the command to put the link down:

sudo ifconfig eth1 down

10.	To measure the metrics with Router 2 link down, repeat steps 3-6.

This completes the OSPF Routing protocol and its metric measurements. The next Routing protocol that we’ll discuss is the Routing Information Protocol

RIP stands for Routing Information Protocol. In contrast to OSPF, RIP uses Distance Vector Routing that follows Bellman Ford Algorithm. In fact, it is one of the oldest Distance Vector Routing protocols. RIP has the information about the entire topology and so it already knows what path to take in order to reach the destination. It provides great network stability. It itself sends routing update message at regular intervals to update the routing table. It chooses the best routing path to reach the destination accordingly.One disadvantage of using RIP is that it has a maximum hop count of 15. If the hop count exceeds 15, it enters a count to infinity problem. The possible solution to this problem is using Split Horizon Technique. Another disadvantage of RIP is that it has slow convergence.

The steps for RIP are the same as OSPF, but using those commands to login recourses:

Client:  ssh guest@pc2.geni.it.cornell.edu -p 34362

Server: ssh guest@pc2.geni.it.cornell.edu -p 34367

Router1: ssh guest@pc2.geni.it.cornell.edu -p 34363

Router2: ssh guest@pc2.geni.it.cornell.edu -p 34364

Router3: ssh guest@pc2.geni.it.cornell.edu -p 34365

Router4: ssh guest@pc2.geni.it.cornell.edu -p 34366

Passwords are: el6383s2015

This completes the Routing Information Protocol and its metric measurements. 

We have achieved the results using the above steps and the screenshots for the same are depicted below.


Communication of Results obtained:

WE have used MS-Excel as mentioned earlier and obtained a way to effectively present our obtained results. The results are depicted below and can be used to verify while reproducing this project.

How to use Excel to get the charts:

1)	Type in a line with protocol type as well as trial number.

2)	Type in a row with time intervals or output-number for each trial.

3)	In the area between the line and row above in 1) & 2), type in the data gotten in the experiment accordingly.

4)	Use the ‘Graph Tools’ in Excel to generate the graph needed. (Because each version of Excel has some differences in its graph tool, we don’t explain specifically how to use the tool. Tutorials can be found in the Internet.)

5)	Add graph title and other marks needed.

![](http://ww4.sinaimg.cn/mw690/a1d340bajw1er9k6xm6gfj217e0d0dhv.jpg)

![](http://ww1.sinaimg.cn/mw690/a1d340bajw1er9k74gsqbj21ay0gomza.jpg)

Results:

![](http://ww1.sinaimg.cn/mw690/a1d340bajw1er9iolm8izj20el08sq3l.jpg)

This line chart shows the comparison of RTT (with all routers working appropriately) between OSPF and RIP. As the chart shows, it’s easy to find that the round trip time of OSPF is shorter than RIP, which we can interpret as the routing speed of OSPF from client to server is faster than RIP. That is, in general situation, using OSPF as routing protocol consumes less time for routing than RIP.   

![](http://ww1.sinaimg.cn/mw690/a1d340bajw1er9iomymm9j20el08s0td.jpg)

This line chart shows the comparison of RTT (with router-2 shut down) between OSPF and RIP. Since router-2 was shut down, the original routing path (client-router1-router2-router3-server) didn’t exist anymore, each protocol had to find a new routing path from client to server. And we can see, the performance of OSPF for finding a new routing path is also superior to RIP, which took less time for rerouting the client to the server. So in the situation with link failure or router shut-down, OSPF also performs better.

![](http://ww1.sinaimg.cn/mw690/a1d340bajw1er9ioq9868j20kx0clwgp.jpg)

![](http://ww4.sinaimg.cn/mw690/a1d340bajw1er9iorrg5pj20kx0clq4b.jpg)

By iperf, we got the throughput of communication between client and server. The two charts above show the bandwidth using OSPF and RIP. The charts show slightly better performance for OSPF than RIP in bandwidth.

Conclusion:

On analyzing the result of the performance of RIP and OSPF over a scenario for cost of transmission, router overhead, throughput, we can say that OSPF has better performance overall as it has the lesser cost of transmission, lower router overhead than RIP and better throughput amongst the two.

So for better effort service that is transmission of data packets OSPF performs better than RIP for throughput, utilization and overhead.

