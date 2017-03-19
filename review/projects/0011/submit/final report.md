#EL6383 HIGH-SPEED NETWORK FINAL PROJECT


## I. Introduction to the 1+1, 1:1 and 1:N network protection.

### 1+1 Protection

  ![](http://i.imgur.com/NuMFnvr.png?1)

  Figure shown above is the simulation image of 1+1 protection

  In the 1+1 network protection, both the primary path as well as the backup path carry the traffic which is end to end (e.g from client to server in this project).
  And it is up to the receiver to determine picking which one of the traffic between the two incoming flow. 
  The two traffics carry the same signal but their delay time to the receiver might be different, which means the signals transmitted to the receiver by different traffic is not simultaneous.

  This mechanism of protection guarantees the simplest and the fasted among the protections in this project, however, on both sides the traffics would reserve and transmit the signal, leading 
  to the huge-volume occupation on the bandwidth shared by the network.

### 1:1 Protection

  In this network topology, the primary traffic and the backup traffic would be set up at the provisioning time which prior to the failure time, the backup path do not have necessarily the same
  constrain in terms of the delay time and bandwidth compared with the primary path. The whole network need to reserve less bandwidth for the backup path in case of failure. The backup path would
  not carry traffic flow (or in idle situation) unless its primary path fails. When failure occurs on the primary path, a fault indication signal would be send back to the transmitter 
  (or client in this project), as soon as the transmitter receives the signal, the traffic would be switched to the alternate path. 

  ![](http://i.imgur.com/x47PPvH.png?1)

  Figure shown above is the simulation image of 1:1 protection

  Although this protection mechanism is slower and requires considerable signal overhead, the network utilization is better in this architecture.

### 1:N Protection

  ![](http://i.imgur.com/G9OUaLj.png?1)

  Figure shown above is the schematic diagram of 1:N protection

  This protection scheme allows up to N working channels to be protected by only one backup path. When all the primary traffics are in well condition, the backup would be left idle until one of the primary traffics fails.
  This protection is widely used in p-cycle network topology since the protection capacity can be used to protect multiple connections. Comparing with 1+1 and 1:1 protection, this protection is more resource-efficient,
  however, the provisioned network needs to be preconfigured carefully and the detection of failures and rerouting traffic is a time-consuming operation.

### Overview and objective of this project

  In this project, we would design the topology of three different protections with the help of GENI. By setting different parameters on each protection, we can use the PING method on the terminal and disconnect the link 
  manually to realize the scenario of failure of the network. By disconnecting the connection on the Ethernet interface, we simulate the restoration of 1+1 and 1:1 protections. Through calculating the delay time of PING 
  before and after manually disconnecting the interface, our purpose on the experiment is to prove the characteristics of 1+1 and 1:1 protection and making comparison between these two protection in terms of the time of
  delay (restoration time).

## II. Experiment design:

Because we cannot swith to the backup path automacially, we can only switch the path manually. We decided to use PING method because PING could check whethe paths are failed and return the RTT to the client.

To reduce errors other irrelevant factors bring about during the experiment, we decided to use 3-node topology since it is simple.

![](http://i.imgur.com/WWGy9ri.jpg)


P1 and P2 are two paths established, one working path and one backup path. In order to calculate the recovery time, we set up the different amount of average latency on different link (We change `delay` here). When we ping the server from the client, we observe the delay of the different protection scheme. The difference between the normal network and failure is recovery time.


First, we try to use the topology we mentioned before to yield the conclusions, just as following.

![](http://i.imgur.com/BqXQ3fG.jpg)


However, when we brought down eth1 of the router to make P1 fail, we cannot ping the server. Then we tried to ping eth1 of the router, which also failed. The result is different from that we assumed that when we made P1 fail, the data packets could use P2 as backup path. Because of we lacking experience of setting up and configuring the router in geni, when we brought down one of the interface of the router, the router could not forward the data packets anymore. So we cannot obtain the results through this method, and we need to change the topology.


Therefore, we equivalent the topology to the following one, which is more directly and more visual. We add a router in the middle of each path so that we can bring down the interface of the adding routers.. P1 and P2 are two paths established.

![](http://i.imgur.com/552Yd9t.jpg)

### 1+1

For 1+1 protection scheme, we assume that P1 is working path and P2 is backup path. Client sends the data both on P1 and P2. When one of them fails, we just need to ensure that the other one is normal, and server just pick up the data from the normal one.

P1 fails,  server pick up the data from P2;

P2 fails,  server pick up the data from P1.

### 1:1

As 1+1 protection scheme, we assume that P1 is working path and P2 is backup path. P1 carries data, P2 idle first. Then we make P1 fail and data packets will be forwarded on P2. Finally, we calculate the recovery time and compare with it of 1+1 protection.

### 1:N

![](http://i.imgur.com/OH0XQ6t.jpg)

## III.Experiment Preparation:
 
First, we need to set up our network environment. Log into geni, create a new slice then we need to add resource. We can just upload our lab_request_rspec.xml file(in submit folder). Then set it to your assigned aggregate.

![](http://i.imgur.com/4H2Swlz.png)

![](http://i.imgur.com/hwuWagD.png)

We need to wait it to be ready.

![](http://i.imgur.com/kUTDIIi.png)

Hostname and port to log into for each machine:

Use password: el6383s2015


Client: 

    ssh guest@pc5.lan.sdn.uky.edu -p 31546

Server: 
    
    ssh guest@pc5.lan.sdn.uky.edu -p 31551

Router-1: 
    
    ssh guest@pc5.lan.sdn.uky.edu -p 31547

Router-2: 
    
    ssh guest@pc5.lan.sdn.uky.edu -p 31548

Router-3: 
    
    ssh guest@pc5.lan.sdn.uky.edu -p 31549

Router-4: 
    
    ssh guest@pc5.lan.sdn.uky.edu -p 31550

## IV. Experiment Details:

Our goal is to study the 1+1 and 1:1/1:N protection scheme for network. As we mentioned above we should set up our topology first (RSpec code will be in a separate file).

### 1+1

As in figure, there are two paths from client to server. If we ping server from client, the packets should through 2 paths (P1: client  router1  router2  router3  server; P2: client  router1  router4 router3 server). We should give latency on each link, so we can easily calculate the RTT of each path, which P1 is 600ms and P2 is 800ms.

![](http://i.imgur.com/X1gYC8x.png)

PS: the delay on each link is from end to end (one direction), since ping causes clinet sends a packet and received from server, so the RTT would be 2 multiply delay.

Before the experiment, you must make sure all the interfaces up on all the nodes. you can use command

    ifconfig

to check every node.

On router 1: eth0, eth1, eth2, eth3 must exist.

On router 2: eth0, eth1, eth2 must exist.

On router 3: eth0, eth1, eth2, eth3 must exist.

On router 4: eth0, eth1, eth2 must exist.

On client: eth0, eth1 must exist.

On server: eth0, eth1 must exist.

If any eth is down, you must run

    sudo ifconfig XXX up

on the particular router/server/client, which XXX is the interface number like eth1.

on client

    sudo tc qdisc add dev eth1 root netem delay 100ms 0ms

on server 

    sudo tc qdisc add dev eth1 root netem delay 100ms 0ms

on router1

    sudo tc qdisc add dev eth1 root netem delay 100ms 0ms
    sudo tc qdisc add dev eth2 root netem delay 100ms 0ms
    sudo tc qdisc add dev eth3 root netem delay 50ms 0ms


on router2

    sudo tc qdisc add dev eth2 root netem delay 50ms 0ms
    sudo tc qdisc add dev eth1 root netem delay 50ms 0ms

on router3

    sudo tc qdisc add dev eth1 root netem delay 100ms 0ms
    sudo tc qdisc add dev eth2 root netem delay 100ms 0ms
    sudo tc qdisc add dev eth3 root netem delay 50ms 0ms

on router4

    sudo tc qdisc add dev eth1 root netem delay 100ms 0ms
    sudo tc qdisc add dev eth2 root netem delay 100ms 0ms

Now, we will show how 1+1 protection scheme works. Since there are 2 paths, the RTT will take the average from both paths. So the RTT should be 700ms. Let us check our result.

on client

    ping -c 20 192.168.20.10

you can also save you output to txt file by run

    ping -c 20 192.168.20.10 > ping-1.txt

![](http://i.imgur.com/1MYr5si.png)

In this figure, we can find the RTT is as we assumed, which is near 700ms. Now, if we bring router2 eth1 down, the P1 will be failed. So, the packet could only through P2, which makes RTT be 800ms. Let us check the result.

on router2 

    sudo ifconfig eth1 down

on client
    
    ping -c 10 192.168.20.10

you can also save you output to txt file by run
    
    ping -c 10 192.168.20.10 > ping-2.txt
 
![](http://i.imgur.com/e62kIUn.png)

From this figure, we can find as we assumption, the RTT becomes 800ms. What if we bring router2 eth1 up and bring router4 eth1 down? Then P1 will be in good condition and P2 will be failed. Let us check our results by experiments results.

on router2

    sudo ifconfig eth1 up

on router4

    sudo ifconfig eth1 down

on client

    ping -c 10 192.168.20.10

you can also save you output to txt file by run

    ping -c 10 192.168.20.10 > ping-3.txt

![](http://i.imgur.com/EXtUHEY.png)

From our results, it is obviously that the RTT becomes nearly 600ms. This means all the packets through P2, but P1 is failed. What happened if we bring router4 eth1 up and bring router2 eth1 down during the ping period? Let us check the result.

on router4

    sudo ifconfig eth1 up

on router2 

    sudo ifconfig eth1 down (during ping period)
    
on client

    ping -c 10 192.168.20.10

you can also save you output to txt file by run

    ping -c 10 192.168.20.10 > ping-4.txt

![](http://i.imgur.com/snACAlT.png)
 
We can obviously find the RTT switched from 700ms to 800ms at `icmp_req 4` and `icmp_req 6` and `icmp_req 5` lost. Since only one ICMP packet lost, we may give the conclusion that the recovery cost of 1+1 is very low.

![](http://i.imgur.com/DP5Gyot.png)

After the experiment, you need to bring router2's eth1 up, by run

on router2

    sudo ifconfig eth1 up

Since the 1+1 protection scheme means the sender sends packets through 2 paths to receiver. If one path failed, packets through another path could reach to the receiver. Since every packet sends out through 2 paths and the receiver will pick one from the packets, the recovery cost of 1+1 protection could be very low. The response to link failure would be very fast. Actually, no additional recovery time needed, the time differences are cost by the different rates between different paths (delay in this experiment). What about the advantage of 1+1 protection? Since each path needs the backup path, this means we need considerable resources for this protection scheme. The cost of network architecture would be really high.

### 1:1/1:N

1:1 protection scheme means each path will have a backup path. However, the backup path only carries packets when the normal path failed. 1:N protection scheme means N paths share one backup path. The backup path only carries packets when the normal path failed. The experiment will focus on the 1:1 protection scheme.

First, we use the same topology as the 1+1 scheme. 

![](http://i.imgur.com/X1gYC8x.png)

We assume P1 (client router1 router2 router3 server) is the normal path and P2 (client router1 router4 router3 server) is the backup path. Due to our lack experience and limited time in GENI portal, we choose to manually switch P1 to P2 when P1 failed during the ping period.

on router4

    sudo ifconfig eth1 down
    
Then during ping period, after router2 eth1 down

    sudo ifconfig eth1 up

on client

    ping -c 20 192.168.20.10

you can also save you output to txt file by run
    
    ping -c 20 192.168.20.10 > ping-5.txt

on router2 (during ping period)

    sudo ifconfig eth1 down
 
![](http://i.imgur.com/guBYenS.png)

After the experiment, you need to bring router2's eth1 up, by run

on router2

    sudo ifconfig eth1 up

We can obviously find the RTT switched from 600ms to 800ms between `icmp_req 3` and `icmp_req 15` and `icmp_req 4` to `icmp_req 14` lost. Since 11 ICMP packets lost, we may give the conclusion that the recovery cost of 1:1 is much higher than 1+1 protection scheme.

In this experiment, we switched to the backup path manually so it may not be as accurate as the real condition. In the real network architecture, the network will take the same steps as we did in this experiment. The network will detect and confirm the path failure and then switch to the backup path. This will takes more recovery time. However, 1:1 protection scheme is still very fast but high resource cost since each path has a backup path. 1:1 takes less network cost as 1+1 since 1:1 only need to send packets to receiver once instead of twice as 1+1 protection scheme.

1:N protection scheme is very like 1:1 the only difference is that N paths share one backup path. So, 1:N may still response to path failure very fast (may slightly slow than 1:1). 1:N may save a lot of network resources but you need to design the network very carefully. Also, if several paths fail, the backup path may get very crowded and this causes the network to be slow. 

## V. DATA

Since the PING output and PING txt files give the number of packets transmitted; number of packets received; percentage of packet loss; time; rtt min/avg/max/mdev. We do not need to do very much work on analysis these data. we can just compare the origin data with our assumptiom.

just like

![](http://i.imgur.com/1MYr5si.png)

Also, since we do the experiments several times, the TXT files may be different as the screenshot in the "picture" folder. However, both our experiments support our assumptions.

## VI. Conclusion：

Eventually we reached our goal. We successfully compare the different network protection schemes as we said above. It is worth nothing that during the experiment, we’ve met several problems and dilemmas. At first, it’s difficult for us to build the complete experimental structure. Due to some problems of the routers, retransmission seems to be randomly failed when we brought down some interfaces. After that we changed the structure of the topology to avoid this problem. Still, at first when comparing the results, we cannot recognize which path is in good condition because each path is under same environment. So we change the delay of each link so that we can easily analyze the experiment results. 

In the process of this experiment, the most important thing is not to find those data. When meeting problems, we’ve worked together trying to solve them. In this process, we used some skills from the previous experiments and learned something new. This is what I think the most important. We have to admit that we still have a lot of deficiency in such a simple experiment. When Paying attention to the simulation of 1:1, the method we used in the experiment is not that pricise. We’ll still keep searching for any possible methods about 1:1 and 1:N after submitting this report. We both think that learning more knowledge from the experiment is delightful so that we'll keep working.
