Project Report of Project2142
=============================

#Experiment Design

  The goal of our experiment is to verify the existence of extra latency introduced by the flow setup process.
  
  The parameter we used is whether there has a routing entry in the switch for the `ping` packets from one host to the other. The round-trip time (RTT) between two hosts is the metric. We will `ping` from one host to the other and record the RTT for every ICMP request and reply pair. After the data is collected, the R Studio will be used to do analysis. We will calculate the average values of the RTTs with and without flow setup.
  
  In fact, we planned to measure the throughputs of two cases using `iperf` in the initial project proposal. To do this, we need to modify the configuration files of the POX controller. But we found it a little complicated to do this in an experiment with reproducibility demand, and unnecessary to achieve the goal of verify the existence rather than measure the exact difference. Thus we did not use `iperf` in the end.
  
  We implemented a simple OpenFlow network, which contains one POX controller, one OVS (OpenFlow Virtual Switch) and two hosts connected to the switch. Then we used `ping` to measure the RTT between two hosts. Finally we used R Studio for processing and visualizing the data. The complete tutorial is presented with specific steps and explanations in the second part of this report.

#Description of Results

  ![](http://oi60.tinypic.com/a49bte.jpg)
  
  The value of each bar is the mean value of RTT of the corresponding case. Since our goal is to verify the existence of extra latency imposed by flow setup, the sample size or standard deviation are not so important in this experiment. If we are going to measure the exact extra latency, the difference between the sample size of two cases must be eliminated.
  
  As shown in this bar plot, the difference of RTT between two scenarios, whether the flow need to forward to control-plane or not, is significant. Thus the extra latency imposed by flow setup do exist.

---

Tutorial of Project2142
=======================

  The experiment goal is to verify the extra latency introduced by the flow setup process. You are going to get one software OpenFlow switch, one controller, and two hosts up to form a SDN topology on GENI. Then, you will measure and analyze the round-trip time (RTT) between two hosts in two scenarios, whether the flow need to forward to control-plane or not.
  
  In this tutorial, you will follow the complete instructions for setting up the experiment from scratch on GENI, executing the experiment and generating the data, and setting up the data analysis enviroment and creating your plots with your data.
  
  * To set up your data analysis environment and creating your visualizations from our raw data (which we provided in our repository), please go through Step 1a (but only need to reserve a controller), Step 4b, and Step 4c.
  
  * To generate your experiment data by logging into our existing setup on GENI and execute the experiment, please go through Step 1b, and Step 3.
  
  * To reproduce the whole experiment from scratch, please go through all the steps.

#Step 1: Set Up Experiment

  In this experiment, you are going to use [Open vSwitch (OVS)](http://openvswitch.org/) as an OpenFlow switch connected to two hosts. OVS is a software switch running on a compute resource. The other two hosts can only communicate through the OVS switch.
  
#1a. Reserve Resources
  
  **Note**: *If you want to use our existing experiment setup on GENI directly, please skip this step and go to Step 1b.*
  
  First you need to reserve resources on RENI in a new slice:
  
  1. In the first resource, reserve a VM running the controller using the RSpec in the "files" folder named "pox-controller.rspec.xml", with *Wisconsin InstaGENI* as site aggregate.
  
  2. Add another resource, reserve the swith and hosts topology using the RSpec in the "files" folder named "ovs-switch-hosts.rspec.xml", with *NYU InstaGENI* as site aggregate.
  
  You can also find these two RSpec files in the "files" folder. To download them, right click the "Raw" button on the upper right of each file page, and choose "Save Link As...".
  
  ![](http://oi60.tinypic.com/iqg26t.jpg)
  
#1b. Use Existing Setup

  **Note**: *If you are reserving resources by yourself, you should skip this step.*
  
  To login to the existing POX controller, run:
  
	ssh guest@pcvm2-24.instageni.wisc.edu
	
  and use "el6383s2015" as the password. The same with the following login procedures.
  
  To login to the existing OVS switch, run:
  
	ssh guest@pcvm1-26.genirack.nyu.edu
	
  To login to the existing host1, run:
  
	ssh guest@pc1.genirack.nyu.edu -p 39995
	
  To login to the existing host2, run:
  
	ssh guest@pc1.genirack.nyu.edu -p 39996
	
  Since all these VMs are already set up, you can skip the configuration instructions in Step 2 and go directly to Step 3.

#Step 2: Configure and Initialize

  In order to configure the OVS switch, we first login to the OVS switch.
  
##2a. Configure the Software Switch
  
  To save time in this tutorial, we have already started OVS and we have added an Ethernet bridge that will act as our software switch. Try the following to show the configured bridge:
  
	sudo ovs-vsctl list-br
	
  You should see only one bridge `br0`. Now we need to add the interfaces to this bridge that will act as the ports of the software switch.
  
  1. List all the interfaces of the node by `ifconfig`. Write down the interface names that correspond to the connections to your hosts. This information will be needed for the following steps. The correspondence is:
  
    * Interface with IP ''10.10.1.11'' to host1 - ethX
	
	* Interface with IP ''10.10.1.12'' to host2 - ethY

    ---
  
  2. For all interfaces other than `eth0` and `l0`, remove the IP from the interfaces (your interface names may vary):
  
		sudo ifconfig ethX 0
		sudo ifconfig ethY 0
     
	 **Note**: *The `ethX` and `ethY` in the above commands should be replaced by the names of the interfaces.*

    ---

  3. Add all the data interfaces to your switch (bridge): Be careful not to add interface `eth0`. This is the control interface. The other two interfaces are your data interfaces. (Use the same interfaces as you used in the previous step.)
  
		sudo ovs-vsctl add-port br0 ethX
		sudo ovs-vsctl add-port br0 ethY
		
	**Note**: *The `ethX` and `ethY` in the above commands should be replaced by the names of the interfaces.*
	
	After above steps, run `ifconfig` to verify the setting. The output should look like this:
	
	![](http://oi60.tinypic.com/2cika5k.jpg)
	
    ---	

  4. Now you have configured your software switch. To verify the two ports configured, run:
  
		sudo ovs-vsctl list-ports br0

##2b. Point your switch to a controller
  
  1. Login to the host that will be used as controller. In the controller window, find the control interface IP of your controller using `ifconfig`, and *note down the IP address of `eth0`*.
  
    ---
  
  2. In order to point our software OpenFlow switch to the controller, run the following command *in the OVS window*:
  
		sudo ovs-vsctl set-controller br0 tcp:<controller_ip>:6633
	
	**Note**: *The `<controller_ip_>` part in the above command should be replaced by the IP of controller's `eth0` noted down in the previous step.*

##2c. Set OVS to secure mode
  
  In `secure` mode, the controller is responsible for forwarding packets, and all packets are dropped if the controller is down.

  *In OVS window*, set OVS to `secure` mode by running
  
	sudo ovs-vsctl set-fail-mode br0 secure

  You can verify your OVS settings by running

	sudo ovs-vsctl show

#Step 3: Execute Experiment

  In this expriment we are going to run a very simple learning switch controller to forward traffic between host1 and host2.
  
  Before start our experiment, we need to ssh the following hosts:
  
  * One window with ssh into the controller
  * One window with ssh into host1
  
##3a. Start a Learning Switch Controller
  
  Before start the controller, you can try to run `ping host2` in the host1 window. The output should be `Destination Host Unreachable` since the controller is down and OVS will drop all the packets. Remember to stop `ping` by pressing "Ctrl-C".
  
  To start the learning switch controller, run the following two commands *in the controller window*:

	cd /tmp/pox
	./pox.py --verbose forwarding.l2_learning

  The output should look like this:

	POX 0.1.0 (betta) / Copyright 2011-2013 James McCauley, et al.
	DEBUG:core:POX 0.1.0 (betta) going up...
	DEBUG:core:Running on CPython (2.7.3/Apr 20 2012 22:39:59)
	DEBUG:core:Platform is Linux-3.2.0-56-generic-x86_64-with-Ubuntu-12.04-precise
	INFO:core:POX 0.1.0 (betta) is up.
	DEBUG:openflow.of_01:Listening on 0.0.0.0:6633
	INFO:openflow.of_01:[9e-38-3e-8d-42-42 1] connected
	DEBUG:forwarding.l2_learning:Connection [9e-38-3e-8d-42-42 1]

  Now the POX controller has started working. And since we've point the OVS switch to this POX controller in "Step 2b", now the controller can communicate with the switch over the control network and insert forwarding rules into the switch's forwarding table.

##3b. Start a ping

  Now we try to `ping host2` from *host1*. For this experiment, you need to store the output of `ping` into a .txt file. Run the following command *in the host1 window* and wait `ping` stop automatically after about 100 seconds:

	ping host2 -n -c 100 | tee ping.txt

  **Note**: *In this tutorial we named the output as "ping.txt". We need to process this file in R studio in Step 4.*
	
  The output should look like this:
	
	PING host2-lan1 (10.10.1.2) 56(84) bytes of data.
	64 bytes from 10.10.1.2: icmp_req=1 ttl=64 time=156 ms
	64 bytes from 10.10.1.2: icmp_req=2 ttl=64 time=1.62 ms
	64 bytes from 10.10.1.2: icmp_req=3 ttl=64 time=1.18 ms
	64 bytes from 10.10.1.2: icmp_req=4 ttl=64 time=1.17 ms
	64 bytes from 10.10.1.2: icmp_req=5 ttl=64 time=1.06 ms
	64 bytes from 10.10.1.2: icmp_req=6 ttl=64 time=1.09 ms
	64 bytes from 10.10.1.2: icmp_req=7 ttl=64 time=1.06 ms
	64 bytes from 10.10.1.2: icmp_req=8 ttl=64 time=1.05 ms
	64 bytes from 10.10.1.2: icmp_req=9 ttl=64 time=0.905 ms
	64 bytes from 10.10.1.2: icmp_req=10 ttl=64 time=1.12 ms
	...
		
  We can easily notice that the first ICMP request and reply pair have a obviously longer RTT (156 ms in the above example) than others. This is because it is the first packet goes to host2, and the OVS switch itself does not know how to forward this packet to the destination at the first time. Therefore the switch must request the controller for the forwarding rule of this new flow. Since the controller and switch are connected through a public network rather than a direct link (In this experiment, the controller is at *Wisconsin InstaGENI*, the switch and the hosts are at *NYU InstaGENI*), the process will impose a manifest extra delay to this very first ICMP request and reply packet pair.
	
  **Note**: *Please make sure that the first RTT corresponds to the flow setup situation; i.e. it is obviously larger than others. In case if it is not, you can start `ping` again after at least 10 seconds.*
	
  After instructed by the controller, the switch knows how to forward the packets from the same flow thereafter and does not need to request the controller. So the RTT of the after ICMP request and reply pairs are significantly lower than the first one.
	
  Furthermore, we can find that there are several large RTTs for every 31 ICMP Request and Reply pair.
	
	...
	64 bytes from 10.10.1.2: icmp_req=1 ttl=64 time=156 ms
	...
	64 bytes from 10.10.1.2: icmp_req=32 ttl=64 time=133 ms
	...
	64 bytes from 10.10.1.2: icmp_req=63 ttl=64 time=151 ms
	...
	64 bytes from 10.10.1.2: icmp_req=94 ttl=64 time=125 ms
	...
	
  This is because all rules on the switch have a *Hard Timeout*. It determines the total time that a flow will remain at the forwarding table, independent of whether packets that match the flow are received; i.e. the flow will be removed after the hard timeout expires. In this experiment, the Hard Timeout is 30 seconds.
	
  The rules on the switch also have a *Soft Timeout*. It determines for how long the flow will remain in the forwarding table of the switch if there are no packets received that match the specific flow. As long as packets from that flow are received the flow remains on the flow table. The Soft Timeout is 10 seconds in this experiment. Since we keep `ping` for 100 times, the soft timeout would not expire in our execution process.

  With all these above steps, we are able to verify that there do exist a significant extra latency imposed by the flow setup process.

#Step 4: Communicating Experiment Results

  In this step, we'll use R to analyze and visualize the results of your `ping` output.
  
  **Note**: *If you are using our existing setup, you can skip Step 4a and Step 4b, and go directly to Step 4c.*
  
##4a. Upload file to your Bitbucket from host1
  
  **Note**: *If you want to use our sample data file, you can skip this step and go directly to Step 4b.*
  
  *In the host1 window*, install `git`:
  
	sudo apt-get update
	sudo apt-get install git
  
  Then
  
	git clone https://URL/OF/YOUR/FORK
	
  where `https://URL/OF/YOUR/FORK` part should be replaced by the URL of your Bitbucket fork.
  
  Move the data file "ping.txt" to a new folder (e.g. "project2142") inside this working copy of your repository. (Use the `mkdir` command to create folder, the `mv` command to move file)
  
  Use `cd` to navigate to this repository (e.g. `cd el6383-netID/project2142/`), then run
  
	git add *
	git commit -m "Added data from ...."
	git push -u origin master

  to save your data file to Bitbucket. Verify on the Bitbucket web interface that your file appears there.
  
##4b. Install R and R Studio
  
  Since the controller alreadly has a publicly routable IP address, we'll install R and R Studio on the host of controller to save some time.
  
  If your POX controller is still working, kill it by pressing "Ctrl-C", and run `cd` to navigate to the root directory.
  
  *In the controller window*, install `git`:
  
	sudo apt-get update
	sudo apt-get install git
  
  Then
  
	git clone https://URL/OF/YOUR/FORK
	
  where `https://URL/OF/YOUR/FORK` part should be replaced by the URL of your Bitbucket fork.
  
  **Note**: *If you want to use our sample data file, look in the "files" folder.*
  
  To set up a password on this individual system, run
  
	sudo passwd USERNAME
	
  where `USERNAME` is the username you use to login to GENI resource. You should see output like
  
	Enter new UNIX password:  [type password here, hit Enter]
	Retype new UNIX password: 
	passwd: password updated successfully
	
  Next, install R and R Studio. Run
  
	wget http://download2.rstudio.org/rstudio-server-0.98.1102-amd64.deb
	
  Become root with `sudo su`, then run
  
```
gpg --keyserver keyserver.ubuntu.com --recv-key E084DAB9
gpg -a --export E084DAB9 | apt-key add -
echo "deb http://cran.wustl.edu/bin/linux/ubuntu precise/" >> /etc/apt/sources.list
```

```
apt-get update
```

```
apt-get install r-base r-cran-rcpp
```

```
dpkg -i rstudio-server-0.98.1102-amd64.deb
```

```
echo "www-port=80" >>  /etc/rstudio/rserver.conf
rstudio-server restart
```
	
  Next, we'll install a couple of libraries. From the root shell prompt, run
  
	R
	
  and at the prompt, run
  
	install.packages("codetools")

  Choose a mirror by entering a numeric value, then let it install the package. When it's finished, install a few more:
  
```
install.packages("plyr")
```
	
```
install.packages("MASS")
```
	
```
install.packages("ggplot2")
```
	
  and
  
	install.packages("reshape2")
	
  (in this order). Then run
  
	quit('no')
	
  to leave the R terminal and `exit` to leave the root shell.
  
##4c. Use R
  
  If you look at your slice details in the GENI portal, you should see a hostname for your resource of *controller*:
  
  ![](http://oi60.tinypic.com/24wburt.jpg)
  
  Copy this hostname into your browser. Log in with the same username you use to log in to the node, and the password you just set up for this username on the node.
  
  Next, use the R script "rscript.R" in the "files" folder to process the "ping.txt" to generate two plots. You also can just copy the following codes into R Studio to create a new R script:
  
	dat <- read.csv("el6383-project2142/files/ping.txt")
	names(dat) <- c('output')
	dat$size <- 0
	dat$from <- c('unknown')
	dat$icmp_req <- 0
	dat$ttl <- 0
	dat$time <- 0
	dat$case <- c('unknown')
	dat <- dat[1:(dim(dat)[1]-6),]
	library(reshape2)
	dat <- transform(dat, output = colsplit(output,"time=", names = c('other', 'time')))
	dat$time <- dat$output$time
	dat$output <- dat$output$other
	dat <- transform(dat, time = colsplit(time," ", names = c('time', 'unit')))
	dat$time <- dat$time$time
	dat <- transform(dat, output = colsplit(output,"ttl=", names = c('other', 'ttl')))
	dat$ttl <- dat$output$ttl
	dat$output <- dat$output$other
	dat <- transform(dat, output = colsplit(output,": icmp_req=", names = c('other', 'icmp_req')))
	dat$icmp_req <- dat$output$icmp_req
	dat$output <- dat$output$other
	dat <- transform(dat, output = colsplit(output,"bytes from ", names = c('size', 'from')))
	dat$size <- dat$output$size
	dat$from <- dat$output$from
	dat$output <- NULL
	dat[which(dat$icmp_req %% 31 == 1),]$case <- "with flowsetup"
	dat[-which(dat$icmp_req %% 31 == 1),]$case <- "without flowsetup"
	library(plyr)
	dat_ds <- ddply(dat, .(case), summarise, mean = mean(time), median = median(time), sd = sd(time))
	library(ggplot2)
	q <- ggplot(dat_ds) + geom_bar(stat="identity", aes(x=case, y=mean, fill=factor(case), width=0.7))
	q <- q + scale_y_continuous("RTT(ms)") + scale_x_discrete("") + ggtitle("SDN with controller in Wisconsin InstaGENI, switch and hosts in NYU InstaGENI") + theme(plot.title = element_text(size = rel(0.9)))
	ggsave("barplot.png", plot=q)
	
  **Note**: *If you want to use your own data file, the `el6383-project2142/files/ping.txt` part should be replaced by your repository of "ping.txt". Otherwise, please change it to use the path to our data file.*
  
  In this R script, we process the `ping` output to a "machine friendly" one, and mark each line of output with corresponding case. Finally we use these processed data to plot an visualized bar chart to communicate the experiment results.
  
  Run this R script by clicking the "Source" button on the upper right corner of the *Source* section.
  
  ![](http://oi61.tinypic.com/fpccuc.jpg)
  
  Click on the "Files" tab and you should see one plot you've just created in your home directory. It should look like the one at the beginning of this report.
  
#Step 5: Extended Experiments

  Our experiment goal is relatively simple: to verify the existence of additional latency imposed by flow setup. Thus we actually do not need to measure the specific difference between two cases, whether the flow forwarding in the switch involved with flow setup or not. Above steps are enough to achieve our goal.
  
  But there can have some extensions based on our experiment. We'll make a brief introduction of them in this step. Please note that it is not a necessary part of our experiment.
  
##5a. Controller in different places

  In this experiment, we use Wisconsin InstaGENI as the site aggregate of the POX controller. And the imposed extra delay is about 150 ms as a result of flow setup between the controller on Wisconsin InstaGENI and the switch on NYU InstaGENI.
  
  Thus, you can set up more controllers in difference places, and point your switch to each controller respectively to test the different values of latency imposed by flow setup. To do this, repeating Step 1, Step 2b, and Step 3.
  
  According to our measurement, with the switch on NYU InstaGENI, the flow setup RTT is 49.15 ms when the controller is on Rutgers InstaGENI, 152.75 ms when on Kentucky InstaGENI, 231 ms when on UCLA InstaGEN, and 28.68 ms when on NYU GENI.
  
##5b. Influence on throughput

  We verify the existence of extra latency imposed by flow setup in this experiment. In order to do this, we introduce one long "flow" using `ping` to record RTT for each packet. 
  
  Furthermore, we can test the actual influence of flow setup on a long flow using `iperf` through a route with high capacity. And you will find that there is little difference among the throughputs of each second whether the forwarding processes in that second involved with flow setup or not.
  
  This is because a long flow lasts for a long time, and the flow setup only happens on the first packet of the flow. There are a huge amount of packets forwarded by the switch in one second if the bandwidth of the route is large. Thus the long delay of the first packet is "diluted" by the short delay of the other packets in that specific second.
  
#Step 6: Release Slice Resources

  You should delete all the resources in your slice at the end of your experiment.
  
---
	
#References

  * [Intro to OpenFlow Tutorial](http://groups.geni.net/geni/wiki/GENIExperimenter/Tutorials/OpenFlowOVS)
  
  * [EL6383 - Lab 2b: Communicating experiment results](https://bitbucket.org/ffund/el6383/src/master/lab2b/README.md)
