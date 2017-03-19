
Lab 3: Routing and resiliency
=====================================================

Please fill in your name and net ID in the table below.

Lab Assignment | 3 - Routing and resiliency
-------------- | --------------------------------
Name           |
Net ID         |
Report due     | Sunday, 29 March 11:59PM


Please answer the following questions:


## Dijkstra's algorithm experiment

1) Were you able to successfully produce experiment results? If so, show a screenshot of your experiment results (topology + completed table).

**Yes.**I was able to successfully produce the experiment results.

**Screenshots :** Please find the screenshots in the Submit folder.

2) How long did it take you to run this experiment, from start (create an account) to finish (getting a screenshot of results)?

It took me around **20 Minutes** to run this experiment from start to finish.

3) Did you need to make any changes or do any additional steps beyond the documentation in order to successfully complete this experiment? Describe *in detail*. How long did these extra steps or changes take to figure out?

**No.** No extra steps were needed to successfully complete this experiment.

4) In the [lecture on reproducible experiments](http://witestlab.poly.edu/~ffund/el6383/files/Reproducible+experiments.pdf), we mentioned six degrees of reproducibility. How would you characterize this experiment - where does it fall on the six degrees of reproducibility?

This experiment has a **Degree 6** reproducibility.

5) Given the materials and documentation provided by the experiment designers, how long do you think it would take you to set up and run the experiment if there was no web-based interface on hyperion.poly.edu?

It would have taken around **3 to 4 hours** to set up and run this experiment if there was no web-based interface on hyperion.poly.edu as we could have encountered problems which would required some time to fix.

## OSPF experiment

1) Were you able to successfully produce experiment results? If so, show your experiment results. You should have:

**Yes.**I was able to successfully produce the experiment results.


 * Traceroute from client to server with all links active
 
```
 rn979@client:~$ traceroute 192.168.20.10
traceroute to 192.168.20.10 (192.168.20.10), 30 hops max, 60 byte packets
 1  router-1-lan5 (192.168.10.10)  0.608 ms  0.556 ms  0.595 ms
 2  router-4-lan3 (192.168.4.1)  1.051 ms  1.040 ms  1.048 ms
 3  router-3-lan1 (192.168.2.2)  1.834 ms  1.898 ms  1.868 ms
 4  server-lan6 (192.168.20.10)  2.397 ms  2.371 ms  2.337 ms
```
 
 * OSPF table on router-1 with all links active
 
```
 root@router-1.lab3-rn979.ch-geni-net.instageni.rnet.missouri.edu> show route table ipv4 unicast ospf
192.168.2.0/24	[ospf(110)/20]
		> to 192.168.1.2 via eth1/eth1
192.168.3.0/24	[ospf(110)/20]
		> to 192.168.4.1 via eth2/eth2
192.168.5.0/24	[ospf(110)/20]
		> to 192.168.1.2 via eth1/eth1
192.168.20.0/24	[ospf(110)/30]
		> to 192.168.4.1 via eth2/eth2
```

 * Traceroute from client to server with the router-2 link down
 
```
 rn979@client:~$ traceroute 192.168.20.10
traceroute to 192.168.20.10 (192.168.20.10), 30 hops max, 60 byte packets
 1  router-1-lan5 (192.168.10.10)  0.805 ms  0.759 ms  0.725 ms
 2  router-2-lan0 (192.168.1.2)  1.446 ms  1.433 ms  1.398 ms
 3  router-3-lan1 (192.168.2.2)  1.877 ms  1.852 ms  1.819 ms
 4  server-lan6 (192.168.20.10)  2.418 ms  2.389 ms  2.358 ms
``` 

 
 * OSPF table on router-1 with the router-2 link down

```
root@router-1.lab3-rn979.ch-geni-net.instageni.rnet.missouri.edu> show route table ipv4 unicast ospf
192.168.2.0/24	[ospf(110)/20]
		> to 192.168.1.2 via eth1/eth1
192.168.3.0/24	[ospf(110)/30]
		> to 192.168.1.2 via eth1/eth1
192.168.5.0/24	[ospf(110)/20]
		> to 192.168.1.2 via eth1/eth1
192.168.20.0/24	[ospf(110)/30]
		> to 192.168.1.2 via eth1/eth1
```

2) How long did it take you to run this experiment, from start (reserve resources on GENI) to finish (getting the output to put in the previous )?

It took me around **an hour** to run this experiment from start to finish.

3) Did you need to make any changes or do any additional steps beyond the documentation in order to successfully complete this experiment? Describe *in detail*. How long did these extra steps or changes take to figure out?

**No.** No extra steps were needed to successfully complete this experiment. But in order to complete the required experiment, I had to verify the routing table by using **sudo ./xorpsh** command in order to view the ospf routing table.

4) In the [lecture on reproducible experiments](http://witestlab.poly.edu/~ffund/el6383/files/Reproducible+experiments.pdf), we mentioned six degrees of reproducibility. How would you characterize this experiment - where does it fall on the six degrees of reproducibility?

This experiment would fall under a **Degree 3** reproducibility.

5) Given the materials and documentation provided by the experiment designers, how long do you think it would take you to set up and run the experiment if the experiment artifacts (disk image, RSpec, etc.) were not provided for you?

It would have taken around **5 to 6 hours** to set up and run the experiment if the experiment artifacts were not provided. 