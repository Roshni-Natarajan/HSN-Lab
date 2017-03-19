#Project Report

##Goal:
The goal of the experiment is to compare and contrast the performance of TCP and UDT (UDP based Data Transfer) by taking into account the metrics, namely, throughput, bandwidth and packet drop. The performance of TCP and UDT is compared for each and evry metric based on a graph plot generated on rstudio and an appropriate conclusion can be obtained for each metric.

##Parameters:

The parameters to be varied are delay, packet drop rate and bandwidth. The range in which they will be varied are: delay in the range of 0 to 10ms , packet drop rate in the range of 0 to 0.01 and Bandwidth in th range of 10Mbps to 1Gbps

##Metrics:

The metrics that will be measured are Throughput and Bandwidth.


##Analysis Plan:

The project is carried out in three parts: 

* Part 1: TCP vs. UDP for different bandwidth capacities of a link, in the presence and absence of link delay and loss.

* Part 2: TCP vs UDP in the case of concurrent flows 

* FTP and UDT Comparison.


#Steps for Execution

1.	Log in to the GENI portal

2.	Create a slice on GENI

3.	Upload the following rspec file. The topology generated should look like the following.*

4.	Reserve resources specified in the rspec file, found in `el6383-project/Rspec`.

5.	Find out SSH login information for slice resources from the GENI portal. Note that the resources may take some time to be ready. In case a failure occurs, go back to step 4.

6.	SSH into the 3 nodes separately, i.e. PC1, PC2 and delay node.

7.	The experiment has three parts: 

	##Part 1: TCP vs. UDP for different bandwidth capacities of a link:
	
	In this part, TCP and UDP are compared under different network conditions in the presence and absence of delay and loss. The three cases are executed as follows:
	
	###Case 1 : No Delay and No Loss 
	
	First, log in to the delay node using the ssh command. Set bandwidth, delay and loss using the following commands:
	
	`sudo ipfw pipe 60111 config bw 100M delay 0 plr 0`
	
	`sudo ipfw pipe 60121 config bw 100M delay 0 plr 0`
	
	Log in to pc1 (server) and start the server in TCP mode using iperf :
	
	`iperf –s`
		
	Log in to pc2 (client) and start the TCP client mode using the command:
	
	`iperf -c 192.168.1.2 --reportstyle C  -i 1 |  tcp_0delay_100mBW-1.txt`
		
	Stop the server in TCP mode on pc1 (server) and start the server in UDP mode using iperf :
	
	`iperf –s -u`
		
	Log in to pc2 (client) and start the TCP client mode using the command:
		
	`iperf  -u -c 192.168.1.2 --reportstyle C  -i 1 |  udp_0delay_100mBW-1.txt`
		
	In a similar way, execute these steps by setting the bandwidth at 500Mbps and 1000Mbps on the delay node. Name the files as : `tcp_0delay_500mBW-1.txt` , `tcp_0delay_1000mBW-1.txt` , `tcp_50delay_100mBW_0loss.txt` , `tcp_50delay_500mBW_0loss.txt` , `tcp_50delay_1000mBW_0loss.txt` , `tcp_0delay_100mBW_0.01loss.txt` , `tcp_0delay_500mBW_0.01loss.txt` and `tcp_0delay_1000mBW_0.01loss.txt` . Similarly for UDP. 
		
	###Case 2: 50ms Delay and No Loss
	
	Set delay and loss on the delay node using the following commands:

	`sudo ipfw pipe 60111 config bw 100M delay 50 plr 0`
	
	`sudo ipfw pipe 60121 config bw 100M delay 50 plr 0`

	Log in to pc1 (server) and start the server in TCP mode using iperf :
	
	`iperf –s`
	
	Log in to pc2 (client) and start the TCP client mode using the command:
	
	`iperf -c 192.168.1.2 --reportstyle C  -i 1 |  tcp_50delay_100mBW.txt`

	Stop the server in TCP mode on pc1 (server) and start the server in UDP mode using iperf :

	`iperf –s -u`

	Log in to pc2 (client) and start the TCP client mode using the command:

	`iperf  -u -c 192.168.1.2 --reportstyle C  -i 1 |  udp_50delay_100mBW.txt`
	
	###Case 3: No Delay and 0.1% Loss
	
	Set delay and loss on the delay node using the following commands:

	`sudo ipfw pipe 60111 config bw 100M delay 0 plr 0.0001`

	`sudo ipfw pipe 60121 config bw 100M delay 0 plr 0.0001`

	Log in to pc1 (server) and start the server in TCP mode using iperf :
		
	`iperf –s`

	Log in to pc2 (client) and start the TCP client mode using the command:

	`iperf -c 192.168.1.2 --reportstyle C  -i 1 |  tcp_0delay_100mBW_0.01loss.txt`

	Stop the server in TCP mode on pc1 (server) and start the server in UDP mode using iperf :

	`iperf –s -u`

	Log in to pc2 (client) and start the TCP client mode using the command:

	`iperf  -u -c 192.168.1.2 --reportstyle C  -i 1 |  udp_0delay_500mBW_0.01loss.txt`

	In a similar way, execute these steps by setting the bandwidth at 500Mbps and 1000Mbps on the delay node.

	In a similar way, execute these steps by setting the bandwidth at 500Mbps and 1000Mbps on the delay node. 
	
	
	

	##Part 2: TCP vs UDP in the case of concurrent flows 

	In this part, the bandwidth is set to 100 Mbps by logging into the delay node. There is no delay and packet drop between the client and the server.

	There are 2 cases implemented:

	###Case 1: Concurrent flows in TCP

	From the client side, 3 concurrent flows are sent using the following command:

	`iperf -c 10.1.1.2 -P 3 --reportstyle C  -i 1 | tee concurrent_tcp.txt`

	At the server side, we run the following command

	`iperf –s`

	###Case 2: Concurrent flows in UDP

	Similar to that of TCP, in this case as well, 3 concurrent flows are sent from the client using the following command:

	`iperf –c -u 10.1.1.2 -P 3 --reportstyle C  -i 1 | tee concurrent_udp.txt`

	At the server side, we run the following command:

	`iperf –s –u`
	
	
	
	
	##Part 3: FTP and UDT Comparison.
	
	This part involves performance comparison of FTP(TCP based) and UDT(UDP based) for different file sizes.

	Initially log in to the delay node and set the bandwidth as 100M, delay as 0 and loss as 0.

	###Case 1: Using FTP

	On the terminal of pc2, execute the following command and set the username as anonymous:

	`ftp pc1`

	`get sm.10M /dev/null`

	Make note of the data rate achieved.

	Perform the FTP again for the different file sizes by replacing sm.10M by med.100M and lg.1G.

	###Case 1: Using UDT

	Start a UDT file transfer server on pc1 using the command:
	
	`/local/udt4/app/sendfile`

	Start a UDT file transfer client on pc2 using the command:

	`/local/udt4/app/recvfile pc1 9000 /local/datafiles/sm.10M /dev/null`

	Make note of the data rate achieved.

	Perform the UDT again for the different file sizes by replacing sm.10M by med.100M and lg.1G.

	The data rate achieved in FTP is in kilo Bytes per second and that of UDT is in mega bits per second. Convert the UDP data rate by calculating (UDPrate x 1000)/8. Make a note of the newly calculated values.
	
8.	Evaluating results.

	The different results obtained are plotted using R studio.

	Initial set up is done by setting up a single node and allocating an aggregate. Note that while setting up the node, check the Publicly Routable box.

	SSH into this node and execute the following command by inserting a valid username:

		sudo passwd USERNAME

		wget http://download2.rstudio.org/rstudio-server-0.98.1102-amd64.deb

		gpg --keyserver keyserver.ubuntu.com --recv-key E084DAB9`

		gpg -a --export E084DAB9 | apt-key add –

		echo "deb http://cran.wustl.edu/bin/linux/ubuntu precise/" >> /etc/apt/sources.list apt-get update

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
	


	Use the hostname on the GENI portal to run R studio on the browser. Log in and execute the shell for the three parts of the experiment

	* Rscript_tcp_part1.R and Rscript_udp_part1.R are to generate plots for part 1 of the experiment.

	* Rscript_concurrent.R is to generate plot for part 2 of the experiment.

	* Rscript_part3.R is to generate plot for part 3 of the experiment.

#Conclusion:

## Part 1: TCP vs. UDP for different bandwidth capacities of a link:

TCP: While comparing TCP with three conditions we observe that there is not much of a variation in throughput when comparing network with delay and a network with loss at different bandwidth but there is significant difference in throughput when delay is introduced on a network with no delay and loss initially.
![TCP Part 1](http://i62.tinypic.com/2ij22zd.png)

UDP: For UDP the variation in throughput is almost negligible when comparing a network where delay is introduced, whereas when loss comes into the picture there is a significant variation to be seen. 

![UDP Part 1](http://i.imgur.com/afQQLDX.png)

## Part 2: Comparing TCP and UDP on constant condition for concurrent flows

For the analysis we have plotted throughputs of TCP and UDP in accordance to time. We observe that the overall bandwidth utilization for TCP is higher than UDP and TCP occupies bandwidth more rapidly than UDP but due to such characteristics congestion occurs thus dropping the rate whereas in UDP the rate is lower but the flow is steady thus having lower congestion frequency than TCP. 

![Part 2](http://i.imgur.com/dsuTix6.png)

## Part 3: FTP v/s UDT file transfer

We have selected 3 files of 10MB 100MB and 1000MB, the conclusions that we came up are as following:

1. FTP utilizes more bandwidth than UDT for all the 3 files, the rate at which FTP sends is almost the same irrespective of file size.

2. UDT utilizes bandwidth in accordance to file size. 

3. Time taken for smaller files to transfer is same for UDT and FTP. UDT takes more time to send larger files.

![Part 3](http://i.imgur.com/Tr3sW9l.png)







