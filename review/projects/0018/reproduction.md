###Experiment Goal: 

Evaluate the performance by observing their throughput over different networks. 
We will vary these parameters: network environment(SDN and regular) and link delays.

###Parameters: 

Link Latency (100ms & 200ms)
OpenFlow network & Normal network

###Metrics: 

Throughput

###Data collection and analysis: 

Measure throughput under different link latency (100ms & 200ms) and network (SDN & normal). 
Then use R to plot and compare their mean value. 


#Project Reproduction Procedure: 

We will start with how to reserve slices on GENI testbed. However, we have reserved resources already for your convenience. 
Please refer to Appendix and login as guest. 

If you use our resources, you can skip step 1 and step 2 since they are to reserve and configure the network. 
You can just login to our controller and start the learning switch controller by typing the following code and keep the command window open: 

    cd /tmp/pox
    ./pox.py --verbose forwarding.l2_learning


Then you can go to step 3 and change the link latency of the network. 
Now you can measure the throughput between different hosts. 
Afterthat, you can continue to step 4 and step 5 to use R to analyze throughput you measured in step 3. 



##Step 1: Reserve slices

Our project is to evaluate the performance by observing their throughput over different networks. 
We will vary these parameters: network environment(SDN and regular) and link delays.
So we will reserve three slices: 2 for OpenFlow (1 for controller and 1 for Vswitch and hosts) and 1 for normal network. 


1.a OpenFlow controller

In your slice that will run the OpenFlow controller: Reserve a VM running the controller using the Portal called XEN VM POX Ctrl. 


![](http://i62.tinypic.com/34q0555.png)


1.b Open vSwitch (OVS) as an OpenFlow switch connected to three hosts

In the slice that will run your hosts with OVS installed.: Reserve the topology using the Portal called OpenFlow OVS all XEN. 


![](http://i62.tinypic.com/213hgf5.png)


1.c Normal Network

In the slice that will run normal network: Reserve the topology using the Portal called 4 Xen VMs, star topology (IG) 

![](http://i60.tinypic.com/5ajg4x.png)



##Step 2: Configure and Initialize the OpenFlow Network 

Although OVS is installed and initialized on the host that is meant to act as a software switch, it has not been configured yet. 
There are two main things that need to be configured: (1) configure your software switch with the interfaces as ports and (2) point the switch to an OpenFlow controller.
In order to configure the OVS switch, we first login to the host that will be used as an OpenFlow switch. 

2.a Configure the Software Switch (OVS Window)

Login to the OVS reserved in 1.b using your SSH key. 

Now that you are logged in, we need first to configure OVS. To save time in this tutorial, we have already started OVS and we have added an Ethernet bridge that will act as our software switch. Try the following to show the configured bridge:
    
    sudo ovs-vsctl list-br
    
You should see only one bridge br0. Now we need to add the interfaces to this bridge that will act as the ports of the software switch.

List all the interfaces of the node

    ifconfig

Write down the interface names that correspond to the connections to your hosts. This information will be needed for one of the exercises. The correspondence is:
Interface with IP ''10.10.1.11'' to host1 - ethX
Interface with IP ''10.10.1.12'' to host2 - ethY
Interface with IP ''10.10.1.13'' to host3 - ethZ

Be careful not to bring down eth0. This is the control interface, if you bring that interface down you won't be able to login to your host. For all interfaces other than eth0 and l0, remove the IP from the interfaces (your interface names may vary): 
sudo ifconfig ethX 0
sudo ifconfig ethY 0
sudo ifconfig ethZ 0
Add all the data interfaces to your switch (bridge):Be careful not to add interface eth0. This is the control interface. The other three interfaces are your data interfaces. (Use the same interfaces as you used in the previous step.)
sudo ovs-vsctl add-port br0 ethX
sudo ovs-vsctl add-port br0 ethY
sudo ovs-vsctl add-port br0 ethZ

Congratulations! You have configured your software switch. To verify the three ports configured run:

    sudo ovs-vsctl list-ports br0

2.b Point your switch to a controller

In the controller window, find the control interface IP of your controller, use ifconfig and note down the IP address of eth0.

An OpenFlow switch will not forward any packet unless instructed by a controller. Basically the forwarding table is empty, until an external controller inserts forwarding rules. The OpenFlow controller communicates with the switch over the control network and it can be anywhere in the Internet as long as it is reachable by the OVS host.

In order to point our software OpenFlow switch to the controller, in the ovs window, run:

    sudo ovs-vsctl set-controller br0 tcp:<controller_ip>:6633
    
2.c Use a Learning Switch Controller

First start a ping from host1 to host2, which should timeout, since there is no controller running.

    ping host2 -c 10
    
We have installed the POX controller under /tmp/pox on the controller host. POX comes with a set of example modules that you can use out of the box. One of the modules is a learning switch. 
Start the learning switch controller which is already available by running the following two commands:

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
    
Keep this command window open. Then in the terminal of host1, ping host2: 

    [experimenter@host1 ~]$ ping host2 
    PING host2-lan1 (10.10.1.2) 56(84) bytes of data.
    From host1-lan0 (10.10.1.1) icmp_seq=2 Destination Host Unreachable
    From host1-lan0 (10.10.1.1) icmp_seq=3 Destination Host Unreachable
    From host1-lan0 (10.10.1.1) icmp_seq=4 Destination Host Unreachable
    64 bytes from host2-lan1 (10.10.1.2): icmp_req=5 ttl=64 time=23.9 ms
    64 bytes from host2-lan1 (10.10.1.2): icmp_req=6 ttl=64 time=0.717 ms
    64 bytes from host2-lan1 (10.10.1.2): icmp_req=7 ttl=64 time=0.654 ms
    64 bytes from host2-lan1 (10.10.1.2): icmp_req=8 ttl=64 time=0.723 ms
    64 bytes from host2-lan1 (10.10.1.2): icmp_req=9 ttl=64 time=0.596 ms
    
Now the ping should work.  


##Step 3: Store data from several trials for each experimental unit

On your resources, you should clone a copy of your git repository. First

    sudo apt-get install git

then

    git clone https://URL/OF/YOUR/FORK

where URL/OF/YOUR/FORK is the URL shown in Bitbuck for your individual fork
For each experimental unit, run several trials. Store the results of each trial using
meaningful file names that include the name of the experimental unit and an trial
identifier. (For example: host3-100m-1, host2-100m-2, etc.)
For the next part of this experiment we'll use iperf, a utility that generates network traffic.
On each node (host1 host2 and host3), run

    sudo apt-get install iperf

to install iperf.

Next, we will change the hosts’ link delays with the following command:

    sudo tc qdisc add dev eth1 root netem delay 100ms 10ms

To remove the emulated latency on an interface(eth1), run
    
    sudo tc qdisc del dev eth1 root

We need to delete the latency file every time we want to change to a new latency.
After we set all the hosts latency to be 100ms, then on the host1 node, run iperf in
server mode:

    iperf -s

For this lab, you need to store the output of each experiment trial in a data file.
Firstly, you need to make a new directory to store all the throughput outputs, run

    mkdir data

and

    cd data

If you run the iperf on host2 as follows:

    iperf -c 10.10.1.1 --reportstyle C -i 1 | tee OUTPUT.txt

where OUTPUT.txt is the name of an output file you'd like to create, it will report
throughput at one second intervals, in a comma-separated values format, and with
output saved to the OUTPUT.txt file. (Run cat OUTPUT.txt to see the contents of the
file.) Please use meaningful names for your output files.

Each line in the output will look something like the following:

    20150215191215,10.1.1.1,38878,10.1.1.2,5001,3,0.0-1.0,27131904,217055232

We should carry this experiment 3 times for each instance, totally we need to get the
host 2’s throughput in 100ms latency, host2’s throughout in 200 ms latency.host 3’s
throughput in 100ms latency, host3’s throughput in 200 latency.
Do the same experiment in the regular network environment and get the throughput in
the regular case.
Then, in each host, run (from inside the repository, use cd to navigate the filesystem):

    git add data/*
    git commit -m "Added data from ...." # insert details in the commit message
    git push -u origin master

To push all these files back to the repo, you need to push respectively on different
nodes in different network environment, remember to git pull before git push current
files. Push them one by one and make sure all the files are in the data folder under your
repo.

##Step 4: Install R

Log on to the GENI portal and create a new slice called "poroject-reproduction".
Using Slice Jacks, request one node in this slice on your assigned aggregate.
Name the node "rstudio" and request a publicly routable IP address for it (by checking the "Publicly Routable IP" checkbox). Then reserve the resource.
Once your resource is ready, log in and install git:

    sudo apt-get update
    sudo apt-get install git

Then use git clone to clone a copy of your fork of the lab repository (not our project copy!).
For convenience, we'll rename the el6383-NETID directory to el6383 so that everyone will have the same file path and can just copy and past commands. Renaming the directory in your working copy won't affect the name of your repository on Bitbucket. To rename the directory, run (with your own Net ID)
mv el6383-NETID el6383 
Run ls to verify the new name.
For this lab, you'll need to set up a password on this individual system (since we'll be using a web interface that doesn't support key-based authentication). To set a password, run

    sudo passwd USERNAME

where USERNAME is the username you use to log in to this resource. You should see output like

    Enter new UNIX password:  [type password here, hit Enter]
    Retype new UNIX password: 
    passwd: password updated successfully

If you forget this password, you can always reset it with the sudo passwd USERNAME command.
Next, install R and R Studio. Run

    wget http://download2.rstudio.org/rstudio-server-0.98.1102-amd64.deb

Become root with sudo su, then run

    gpg --keyserver keyserver.ubuntu.com --recv-key E084DAB9
    gpg -a --export E084DAB9 | apt-key add -

    echo "deb http://cran.wustl.edu/bin/linux/ubuntu precise/" >> /etc/apt/sources.list

    apt-get update
    apt-get install r-base r-cran-rcpp

    dpkg -i rstudio-server-0.98.1102-amd64.deb
    echo "www-port=80" >>  /etc/rstudio/rserver.conf
    rstudio-server restart

Next, we'll install a couple of libraries. From the root shell prompt, run

    R

and at the prompt, run

    install.packages("codetools")

Choose a mirror by entering a numeric value, then let it install the package. When it's finished, install a few more:

    install.packages("plyr")
    install.packages("MASS")
    install.packages("ggplot2")

and

    install.packages("reshape2")

(in that order). Then run

    quit('no')

to leave the R terminal and exit to leave the root shell.

##Step 5: Using R

###We have uploaded the R script named plot.R. You can use it as a reference. 


Log in to R Studio
If you look at your slice details in the GENI portal, you should see a hostname for your resource:
![](http://i61.tinypic.com/ojmno9.png)

Copy this hostname into the address bar of your browser and hit enter. You should see a screen like the following:
![](http://i58.tinypic.com/2due887.png)

Log in with the same username you use to log in to the node, and the password you just set up for this username on the node.
Once you're in, you should see an interface like the following: 
![](http://i58.tinypic.com/11sz49y.png)
It includes a console, as well as some other sections for viewing data, writing scripts, exploring the file system, viewing graphs, and viewing variables in your environment.

Loading and using `iperf` data

If you used `iperf` to collect data in your experiment, you will have 
data files filled with lines like these:

    20150215191215,10.1.1.1,38878,10.1.1.2,5001,3,0.0-1.0,27131904,217055232

This values in each line are (in order):

 1. Timestamp
 2. Source IP
 3. Source port
 4. Destination IP
 5. Destination port
 6. Connection ID
 7. Begin interval - End interval (in seconds)
 8. Data transferred in this interval (Bytes)
 9. Measured throughput in this interval (bits/second)

We'll experiment with some different ways to analyze this data. 

To read in the iperf data, we'll use the `read.csv` function.
Run

```
dat <- read.csv("data/host2_100_1.txt")
```

This will load the `host2_100_1.txt` data
into a variable called `dat`.

One thing we can see immediately is that `dat` does not have "friendly" 
column names. To assign names to the columns of `dat`, we'll save the list
of columns into a variable called `cnames`, then apply that to the 
column names of `dat`:

```
cnames <- c("time", "srcip", "srcport", "dstip", 
            "dstport", "id", "interval", "data", 
            "tput")
names(dat) <- cnames
```

Now, when you run `str(dat)`, you'll see that the columns are labeled. 
Here, `dat` is a kind of data structure called a *data frame* (which is 
similar to a table). To access a particular column in a data frame, 
we use the `$` operator.For example, try running

```
dat$tput
```

This data was collected in SDN and normal environment, over a network with capacity 100 Mbps, symmetric latency of 100 ms in each 
direction (for 200 ms total round trip delay), and it was trial number 1.
To record all this in `dat`, we'll add some columns and assign values to them:

```
dat$env <- "SDN"
dat$capacity <- 100
dat$rtt <- 100
dat$trial <- 1
dat$host <- 2
```

Look at the `dat` structure again (either with `str(dat)` or by opening it in 
the data viewer), and confirm that your new column has been added.


Let's load in another trial of this experiment and also two trials 
of an experiment with different parameters.

First, we'll save our current `dat` into another variable called
`all`:

```
all <- dat
```

Then we'll load in another trial of the same experiment into `dat`:

```
dat <- read.csv("data/host_100_2.txt")
names(dat) <- cnames
dat$env <- "SDN"
dat$capacity <- 100
dat$rtt <- 200
dat$trial <- 2
dat$host <- 2
```

To *combine* it with the `all` data frame, we'll then run:

```
all <- rbind(all, dat)
```

Finally, let's load other trials of the 100ms latency experiment:

```
dat <- read.csv("data/normal-host2-100-10_1.txt")
names(dat) <- cnames
dat$env <- "Normal"
dat$capacity <- 100
dat$rtt <- 100
dat$trial <- 1
dat$host <- 2
all2 <- dat

dat <- read.csv("data/normal-host2-100-10_2.txt")
names(dat) <- cnames
dat$env <- "Normal"
dat$capacity <- 100
dat$rtt <- 100
dat$trial <- 3
dat$host <- 2
all2 <- rbind(all2, dat)
```
......
```
dat <- read.csv("data/normal-host3-100-10_3.txt")
names(dat) <- cnames
dat$env <- "Normal"
dat$capacity <- 100
dat$rtt <- 100
dat$trial <- 3
dat$host <- 3
all4 <- rbind(all4, dat)
```

Now, we have results from four experiment runs, of two different types, 
stored in `all`,`all2`,`all3` and `all4`. 

Before we proceed, we'll take some steps to manipulate the data frame 
to make it more convenient to use. First of all, we can change "environment" to *factors*:

```
all$tcp <- as.factor(all$tcp)
```

We'll also subdivide the `interval` column into a `begin` and `end` time.
To do this, we'll load the `reshape2` library we installed earlier,
then call a function from it:

```
library(reshape2)
all <- transform(all, interval = colsplit(interval,"-", names = c('begin', 'end')))
all$interval.begin <- all$interval$begin
all$interval.end <- all$interval$end
all$interval <- NULL
```

Now you can do e.g.

```
all$interval.begin
all$interval.end
```

Similarly, operate the same command to `all2`,`all3` and `all4`.
```
all2$env <- as.factor(all2$env)
library(reshape2)
all2 <- transform(all2, interval = colsplit(interval,"-", names = c('begin', 'end')))
all2$interval.begin <- all2$interval$begin
all2$interval.end <- all2$interval$end
all2$interval <- NULL
all2$interval.begin
all2$interval.end
```
Our `iperf` data includes lines from midpoint intervals in an experiment (1 second long) as well as one line in each experiment with overall data. Let's separate those into two new data frames:

```
totals  <- all[all$interval.begin<=1 & all$interval.end>=10,]
details <- all[!(all$interval.begin<=1 & all$interval.end>=10),]
```

After that we calculate the mean of three trials
```
mean1 <- mean(total$tput)
...
mean4 <- mean(total4$tput)
```

Then, run this command to build a data frame for plotting the mean of the output in different environment.
```
tput <- c(mean1,mean2,mean3,mean4)
env <- c('SDN','Normal','SDN','Normal')
host <- c('host2','host2','host3','host3')
rtt100 <- data.frame(tput,env,host)
```

OK, now we're ready to plot some pictures. We're going to use a 
visualization library called `ggplot2`, so load it now:

```
library(ggplot2)
```

To create a plot with `ggplot`, we start by calling `ggplot` and telling 
it what data frame we want to plot. We save the `ggplot` object to a variable:

```
q <- ggplot(details)
```

We can also add additional *aesthestics* to the plot - for example, to show the TCP variant using color, we would run

```
q <- ggplot(details)
q <- q + geom_point(aes(x=interval.begin, y=tput, colour=env))
q
```
You can save any plot to a file. For example, to save the most recent plot in q

```
ggsave("file.png", plot=q)
```
Process all the data files you get from iperf and plot them all.

Click on the "Files" tab and you should see the file you've just created in your home directory on the node.

```
and you are expected to see pictures like these:
![](http://i62.tinypic.com/2qs5rx3.png)
![](http://i61.tinypic.com/2qb89wy.png)

#Conclusion:
From the 2 figures above, we can see that normal network environment’s throughputs are little bit higher than the SDN networks in most cases. We can say that SDN using open flow still performs very well, it’s competitive and proves that it’s a good substitute for normal networks in the future.  

#Appendix: 

###Login to Normal Network: 

host1:

    ssh guest@pc1.instageni.wisc.edu -p 40251
    
host2:  

    ssh guest@pc1.instageni.wisc.edu -p 40252
    
host3:  

    ssh guest@pc1.instageni.wisc.edu -p 40253
    
switch:  

    ssh guest@pc1.instageni.wisc.edu -p 40250
    
    
password: 

    el6383s2015
    
    
###Login to OpenFlow Network:

controller: 

    ssh guest@pcvm2-22.lan.sdn.uky.edu
    
Open vSwtich: 

    ssh guest@pcvm1-14.lan.sdn.uky.edu
    
host1: 

    ssh guest@pc1.lan.sdn.uky.edu -p 33083
    
host2: 

    ssh guest@pc1.lan.sdn.uky.edu -p 33084
    
host3: 

    ssh guest@pc1.lan.sdn.uky.edu -p 33085
    
    
password: 

    el6383s2015


###Login to R:

    rstudio.cl3381-normal.ch-geni-net.genirack.nyu.edu
    
    ssh guest@pcvm3-33.genirack.nyu.edu
    
password: 

    el6383s2015


# Reference

http://groups.geni.net/geni/wiki/GENIExperimenter/Tutorials/OpenFlowOVS 
