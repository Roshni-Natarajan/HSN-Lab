
Lab 2: Flow and Congestion Control/Experiment Design
=====================================================

Please fill in your name and net ID in the table below.

Lab Assignment | 2 - Flow and Congestion Control
-------------- | --------------------------------
Name           | Roshni Natarajan 
Net ID         | rn979
Report due     | Sunday, 22 February 11:59PM


Please answer the following questions:

1)Describe (as specifically as possible) the goal of your experiment.

**Answer :** To observe the throughput of the TCP variants[YeAH, Scalable and Reno] w.r.t. bandwidth delay product. 

What makes this a good goal?
explain *how* your selected goal embodies those indicators.

**Answer :** Because the goal specifically states :

1. the environment(TCP variants) where the experiment is conducted.
2. the  performance that is being measured (throughput).
3. the parameters(bandwidth delay product) that are varied in order to measure the mentioned metric. 

2) What is the TCP congestion control variant you have selected
as the main subject of your study? Describe briefly (1 paragraph)
what characterizes this TCP congestion control, and how it works.
Cite your sources.

**Answer :** 

**YeAH TCP**

YeAH TCP is a delay-aware state-enabled congestion control algorithm.
Through delay measures, when the network is sensed unloaded it will quickly exploit the available capacity, trying to keep the network buffer utilization always lower than a threshold. 
Moreover it is designed to be internal and RTT fair, Reno-friendly and resilient on lossy links.


3) What is the other LFN TCP you have selected to use in your
experiment? Be brief (1 paragraph each), and cite your
sources. 

**Answer :** 

**Scalable TCP**

This is another algorithm for WAN links with high bandwidth and RTT. 
One of its design goals is a quick recovery of the window size after a congestion event. 
It achieves this goal by resetting the window to a higher value than standard TCP.

What is the non-LFN TCP you have selected to use
in your experiment? Be brief (1 paragraph each), and cite your
sources. 

**Answer :** 

**TCP Reno**

TCP Reno is a classical model used for congestion control. 
It exhibits the typical slow start of transmissions. 
The throughput increases gradually until it stays stable. 
As soon as the transfer encounters congestion, the window size is reduced by a multiplicative decrease algorithm and then the rate rises again slowly. 
The window is increased by adding fixed values.

Why did you choose these specifically?

**Answer :** The TCP variants YeAh and Scalable are designed exclusively for LFNs whereas TCP Reno is the most widely deployed classical model used for congestion control, hence these variants were chosen in order to observe the throughput in both LFNs and Non-LFNs. 
Among the variants designed for LFNs, YeAH is a delay based while Scalable is a loss- based algorithm, hence this makes them significantly different.


4) Describe the parameters you have chosen to vary in your
experiment. 

**Answer :**

1. **TCP variant**
2. **Bandwidth Delay product**


Why did you choose these? How does this selection help further your stated goal?

**Answer :** In order to study the different TCP variants mentioned above TCP Variant is one of the parameters. 
And as modifying the Bandwidth-delay product has a direct impact on the throughput, it also is a parameter.

5) What metrics are you going to measure in your experiment?

**Answer :  Throughput.**

Why did you choose these? How does this selection help further your stated goal?

**Answer :** It is a clear goal of most congestion control mechanisms to maximize
throughput, subject to application demand and to the constraints of
the other metrics.

6) For each **experimental unit** in your experiment, describe:

* The specific parameters with which this experimental unit ran
* The names of all the data files which give results from this experimental unit. Include all of these files in this `submit` folder.
* The specific values of the metrics you have chosen to measure.

**Answer :**

**LFN** 

**Bandwidth = 500Mbps ** 

 TCP Variant |  Delay            |  Throughput        |    Time        | Data File Name     
-------------|-------------------|--------------------|----------------|-------------------------------
 YeAH        |    100ms          |    2.08 MBps       |     70s        |  `exno_yeah_500Mbps_100ms`
 YeAH        |    200ms          |    1.06 MBps       |     2min 18s   |  `exno_yeah_500Mbps_200ms`
 YeAH        |    300ms          |    736  KBps       |     3min 24s   |  `exno_yeah_500Mbps_300ms`
 Scalable    |    100ms          |    1.74 MBps       |     83s        |  `exno_scalable_500Mbps_100ms`
 Scalable    |    200ms          |    914  KBps       |     2min 45s   |  `exno_scalable_500Mbps_200ms`        
 Scalable    |    300ms          |    617  KBps       |     4min 3s    |  `exno_scalable_500Mbps_300ms`
 Reno        |    100ms          |    1.53 MBps       |     96s        |  `exno_reno_500Mbps_100ms`
 Reno        |    200ms          |    771  MBps       |     3min 11s   |  `exno_reno_500Mbps_200ms`
 Reno        |    300ms          |    506  MBps       |     5min 2s    |  `exno_reno_500Mbps_300ms`
 
 

**Non-LFNs**

**Bandwidth = 10Mbps ** 

 TCP Variant |  Delay            |  Throughput        |    Time        | Data File Name       
-------------|-------------------|--------------------|----------------|--------------------------------
 YeAH        |    1ms            |    1.19 MBps       |     2min 3s    |  `exno_yeah_10Mbps_1ms`
 YeAH        |    3ms            |    1.19 MBps       |     2min 3s    |  `exno_yeah_10Mbps_2ms`              
 YeAH        |    5ms            |    1.19 KBps       |     2min 3s    |  `exno_yeah_10Mbps_3ms`        
 Scalable    |    1ms            |    1.19 MBps       |     2min 3s    |  `exno_scalable_10Mbps_1ms`
 Scalable    |    3ms            |    1.19 KBps       |     2min 3s    |  `exno_scalable_10Mbps_2ms`        
 Scalable    |    5ms            |    1.19 KBps       |     2min 3s    |  `exno_scalable_10Mbps_3ms`
 Reno        |    1ms            |    1.19 MBps       |     2min 3s    |  `exno_reno_10Mbps_1ms`
 Reno        |    3ms            |    1.19 MBps       |     2min 3s    |  `exno_reno_10Mbps_2ms`
 Reno        |    5ms            |    1.19 MBps       |     2min 3s    |  `exno_reno_10Mbps_3ms`




7) Describe any evidence of *interactions* you can see in the results of your experiment.

**Answer :** Varying the Delay results in changes in the throughput. They seem to be inversely proportional.

8) Briefly describe the results of your experiment (1-2 paragraphs). You may include images by putting them on an online
image hosting service, then putting the image URL in this file
using the syntax

Answer : 

**LFNs :** 

**With a high delay,** 

1. Throughput of YeAH is superior to Scalable whose throughput is in turn superior to TCP Reno. The reason behind this is the fact that YeAH and Scalable were designed for LFNs whereas Reno is not. 
2. Furthermore, the Superiority in YeAH’s throughput over Scalable is justified as YeAH is a delay-based algorithm and this experiment varies the delay in order to measure the Throughput.

**Without a high delay,** 

There is not much difference in the throughput values measured using these three TCP variants. 

**Non-LFNs :** 

There is no difference in the throughput measured using these TCP variants in spite of varying the Delay.

[LFN Graph](https://drive.google.com/file/d/0Bx3lzg76xFNAVERyWGg4QW5WNEU/view?usp=sharing)

[Non-LFN Graph](https://drive.google.com/file/d/0Bx3lzg76xFNAMUhTN0VKVWtFVkk/view?usp=sharing)


9) Find a published paper that studies the same TCP congestion
control variant you have chosen (it may study others as well).
Identify the paper you have chosen with a full citation, and
briefly answer the following questions about it:

**Paper :** [http://citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.91.1019&rep=rep1&type=pdf](http://citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.91.1019&rep=rep1&type=pdf)


 * What research question does this study seek to answer?
 
 **Answer :** It seeks to answer how to achieve high performance without inducing stress to the network elements.
 
 * What kind of network environment was this study conducted in?
 
 **Answer :** a testbed whose primary scope was to recreate a realistic high-speed long-distance network environment to test congestion control algorithms was designed and implemented.
 
 * How representative is the above network environment of the network setting this TCP variant is designed for?
 
 **Answer :** It is very representative of the network setting this TCP Variant is designed for as they have values of Bandwidth ranging from 10kbps and 1Gbps and Delay ranging from 12ms and 480ms. 
 These ranges encompass the LFN criteria.
 
 * Does this study make some comparison to another TCP congestion
 control algorithm? If so, which, and does the author explain why these were selected?
 
 **Answer :** Yes, It makes a comparison to  STCP, HSTCP , H-TCP, BIC ,CUBIC ,FAST TCP, TCP Africa and COMPOUND TCP as they are the different strategies that have been explored in the recent literature, to address the problem of TCP in high BDP networks.

 * What parameters does the author of this study consider? Does the
 author explain why?
 
 **Answer :**
 
 1. Round-trip time
 2. Link loss probability   
 3. Bottleneck buffer size
 4. RTT Ratio
 5. Experiment Duration 

 No he has not stated the reasons for choosing these parameters.

 * What metrics does the author of this study consider? Does the author explain why?
 
 **Answer :** 
 
 1. Link Utilisation. 
 2. Normalised Average Queue Length.
 3. Fairness Index.
 
 No he has not stated the reasons for measuring these metrices.
 
 
 * Critique the experiment(s) in the paper. Does it make any of
 the common mistakes described in the lab lecture? Explain.
 
 **Answer :**
 
 * The goal of the paper is not very specific. 
 * The selection of above mentioned parameters or metrics have not been justified. 
 * The interactions between the parameters have been ignored.
 
 
 ** Citations : **
 
 http://citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.91.1019&rep=rep1&type=pdf
 http://interstream.com/node/1084
 http://www.ietf.org/rfc/rfc5166.txt


