Experiment: Measuring the performance UDP and TCP (through File Transfer) under varying network conditions by using IPFW (IP Firewall)
Project Overview: In this project we first observed the average throughput achieved by TCP and UDT for a variety of conditions; analyzed and visualized the result using RStudio. 

The conditions are:

1) No additionally introduced delay or loss.

2) No delay and 0.01 loss. 

3) 10 ms delay and no loss, under different network bandwidths of 10 Mbps, 100 Mbps, and unlimited. 

We are using R for two reasons: 


1. R is a programming language and software environment for statistical computing and graphics.

2. R facilities reproducibility.

Metric: In this experiment we measured the throughput.

Parameters: In this we varied bandwidth, delay and packet loss rate.



Experiment Setup:
Download the attached rspec file from bitbucket, named “Project-RSpec.rspec” and save it. In Slice Jacks editor scroll down and upload the Rspec file in the “File” option. The aggregate will be automatically selected as “Utah ProtoGENI”.


![Image1](http://s10.postimg.org/3ucct02yx/image1.png)

Experiment Procedure
•	First login to node 1, node 2 and node 3.
•	After logging into node 3 which is the delay node use this command:
![Image2](http://s10.postimg.org/a1nqt5yq1/image2.png)

You’ll get something like this-

![Image3](http://s10.postimg.org/xkzhernyh/image_3.png)
 
 Above image show the internal information of the pipes. There are 2 pipe 60111 and    60121 one for each direction.

•	To change the parameters of the pipe use the following commands-

![image4](http://s10.postimg.org/pe7hn6xvt/image4.png)
 
 Where bw is the bandwidth of the link, delay is the amount of delay in the link and plr is the packet loss ratio. Here value of all the parameters are set to 0.

•	For Example-

![Image5](http://s10.postimg.org/nxvz51uyx/image5.png)

In the above screenshot the link has the bandwidth of 100M which means 100Megabits/second, delay 10 which means 10micoseconds and packet loss ratio of 0.1 which means 10% packet loss.
•	File transfer using UDT:

1)	 After logging to node 1 which is pc1 enter the following command.

![Image6](http://s10.postimg.org/cdvqqrbbd/image6.png)

This will start the UDT file transfer server and save the output in “.txt” file

2)	On node 2 which is pc2 use the command which will start the UDT file transfer client.

![Image7](http://s10.postimg.org/kxjq2991l/image7.png)

We measured 3 file sizes small (sm.10M) which is 10Megabytes, medium (med.100M) which is 100Megabytes and large (lg.1G) which is 1 Gigabytes. To measure the medium and large file transfer you have to use med.100M and lg.1G instead of sm.10m in the above example.
3)	You will get the output like this-

![Image8](http://s10.postimg.org/nswt94d1l/image8.png)

Which shows the result of file transfer.
•	File Transfer using FTP:
1)	There is already FTP server running in pc1 so to log into pc1, start the FTP client by using the command ftp pc1 in pc2.

![Image9](http://s10.postimg.org/nswt94d1l/image8.png)

Type anonymous as the login name and any password you want as shown in the screen shot. 
•	Still on pc2, request a file transfer by using the command-

![Image10](http://s10.postimg.org/51uvyyih5/image10.png)

Above screen shot shows the small size file transfer command and the file transfer rate.
Repeat the same for medium and large file size and take a screen shot of the output.

•	Plots on RStudio:
Now we will be using RStudio to plot various graphs to visualize the results depending on the throughput obtained in the experiment above. 
A.	UDT AND TCP BANDWIDTH THROUGHPUT PLOTS WITH NO LOSS NO DELAY 


+
Graph of UDT:
![Image11](http://s9.postimg.org/896zfy9xb/udt_ndnl.png)
Graph of TCP: ![Image12](http://s9.postimg.org/ebem6fydb/ftp_ndnl.png)

B.	UDT AND TCP BANDWIDTH THROUGHPUT PLOTS WITH 10% PACKET LOSS AND ZERO DELAY


+
Graph of UDT:
![Image13](http://s9.postimg.org/l5oww4r0f/udt_lossonly.png)
Graph of TCP: ![Image14](http://s9.postimg.org/sfaheu5kv/ftp_lossonly.png)

C.	UDT AND TCP BANDWIDTH THROUGHPUT PLOTS WITH 10ms DELAY AND ZERO PACKET LOSS


+
Graph of UDT:
![Image15](http://s9.postimg.org/cm5iydinz/udt_delay.png)
Graph of TCP: ![Image16](http://s9.postimg.org/6wpae2chr/ftp_delay.png)

Results: We observe the throughput observed by TCP and UDT in variety of conditions. While TCP remains at lower throughput, UDT displays close to maximum average throughput across the network when there is no added delay and loss.
The above images in the URLs. Show that the large delay impacts TCP while the impact on UDT is negligible. Further TCP is affected by the impact of delay, while UDT is affected by packet loss significantly as compared to delay, since throughput drops more with change of loss rather than in delay. 


Conclusion: We explored the performance of TCP and compared it with one from a UDP based data transfer protocol (UDT) under various conditions. The protocol performances were measured under various network settings of bandwidth, delay and loss using GENI testbed.
The showcased result has demonstrated that TCP throughput significantly suffered in higher bandwidth network especially with delays and the impact of loss was relatively less critical than the delay on TCP throughput.  On the other hand, UDT was very sensitive to packet loss; but overall according to analysis UDT is a more effective way to transfer files than TCP in case of large files transfer over changing network characteristics. The controllable virtual laboratory environments of GENI have offered us an invaluable and deep learning experience.
