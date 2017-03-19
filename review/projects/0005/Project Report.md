**Project Overview**:
To evaluate the performance of Random Early Detection(RED) scheduling algorithm and default scheduling algorithm p-First in First Out- Fast(pfifo-fast)
in a static route based LAN.
We have chosen RED and pfifo-fast scheduling algorithms for studying the varitaion in throughput when implemented on a static route based LAN. 
The data generation is using iperf, which by default gives the data in machine friendly format and then using R-Studio for statistically showing the results.

We created a small LAN based topology in the GENI testbed, using Virtual Machines(VMs). Our topolgy consists of 2 Routers and 4 Host. Each router 
connected to 2 hosts and sharing the same subnet.  We used iperf to generate traffic, by creating one host on 1 subnet as server and 
the 2 hosts on the other subnet as clients.
For instance if Host-1 acts as the server, the traffic will be generated from host-3 and host-4, 
both of which will be acting as clients.

**Steps to reproduce the experiment:**

**Experiment Setup**
1) Use your GENI account and do some one time setup

   * Login to the GENI Experimenter Portal 

   * Join a project

   * Specify SSH keys for use logging into resources

 2) Learn how to reserve, login to, and release resources in GENI

   * Create and renew a slice

   * Generate and reserve your own topology of GENI resources using Jacks

   * Learn how to delete resources in GENI

 3) Understand the difference between the control and data plane interfaces on each node

   * Use `ifconfig` to identify your data and control plane interfaces

   * Use `ping` and `iperf` to test connectivity between the reserved resources

To use GENI, you must create a GENI account and join a project. This involves a one-time account setup.

First, go to [http://portal.geni.net](http://portal.geni.net) and click on "Use GENI":

![GENI portal](http://witestlab.poly.edu/~ffund/el6383/lab1/geni-portal-home.png)

On the next screen, you will be prompted to choose an Identity Provider. Choose "New York University" and press "Continue":

![Choose NYU](http://witestlab.poly.edu/~ffund/el6383/lab1/geni-login-nyu.png)

Log in with your NYU NetID:

![NYU login](http://witestlab.poly.edu/~ffund/el6383/lab1/geni-nyu-sso.png)

Review the policies on the next page, check both boxes, and click "Activate":

![Accept policies](http://witestlab.poly.edu/~ffund/el6383/lab1/geni-accept.png)

Are you having trouble logging in with your NYU NetID? See [Appendix A](#markdown-header-appendix-a).

Once in the portal, you need to join a project. Click on the "Projects link":

![Projects link](http://s7.postimg.org/4p73gcmkb/Geni_home.png)

You will see a list of projects. Click "Join" next to "EL6383-NYU-S2015":

![Projects list](http://witestlab.poly.edu/~ffund/el6383/lab1/geni-join-project.png)

After submitting your join request, on the portal homepage, you should see the oustanding join request:

![Outstanding project request](http://witestlab.poly.edu/~ffund/el6383/lab1/geni-join-outstanding.png)

After an instructor has approved your project join request, you should see the project listed under "My Projects" on your portal homepage, as follows:

![Joined project](http://witestlab.poly.edu/~ffund/el6383/lab1/geni-joined-project.png)

Next, you must specify SSH keys to use for logging into resources.

First, you must determine what SSH client you are using:

 * All Linux and Mac distributions come with a built-in SSH client. Just open a Terminal and type `ssh` to see the usage for the `ssh` command. You can also find information online on how to use the `ssh` command.

 * If you are using Windows, you will need to install an SSH client. The one that is recommended for this course is part of [Git Bash](https://msysgit.github.io/). This option is most recommended because it is similar to the Mac/Linux environment (so that the commands will be the same for everyone) and because it also includes `git,` which you will need for this course.

In order to use GENI resources, you must set up a cryptographic key pair. The private key should be installed on your machine, and you must use it together with SSH. The public key should be installed on the GENI portal.


To set up your keys, on the GENI portal homepage, click on "Profile" in the top menu and then click on "SSH Keys":

![SSH Keys](http://s11.postimg.org/6qbl4qwdv/ssh_keys.png)

If you already have a private/public key pair set up on your machine, you can just upload it to the GENI portal (choose "upload an SSH public key").

Otherwise, choose "generate and download an SSH keypair" and follow instructions to generate a new keypair. Download your private key, install it in an appropriate location on your machine, and make sure to use it when logging in to GENI resources. (If you are using Windows and Git Bash, [this  note](http://serverfault.com/a/198691) may be helpful to you.)

*Note: SSH is a standard tool, used by millions of people. If you are having a problem with SSH or SSH keys, you are probably not the first person to have that problem; please look online for an existing solution before asking for help.*

## Learn how to reserve, login to, and release resources in GENI

Next, you will create a [slice](http://groups.geni.net/geni/wiki/GENIGlossary) for purposes of this lab exercise. On the portal homepage, 
where it shows your project memberships, click on "Create Slice":

![Create Slice](http://s29.postimg.org/c80skxhvb/new_slice.png)

Please name your slice `project-netid` using your individual NYU NetID, as shown in the image above. You do not need to enter a slice description.

On the page for this slice, press the "Slice Jacks (beta)" button.

![Slice page](http://s2.postimg.org/8ikipmgx5/created_slice.png)


 In the window that opens, click the "Add Resources" button.

 ![Jacks add](http://witestlab.poly.edu/~ffund/el6383/lab1/geni-jacks-add.png)

Wait for Jacks to open in editing mode, as follows:

![Jacks editor](http://witestlab.poly.edu/~ffund/el6383/lab1/geni-jacks-editor.png)

Add resources to your canvas as follows:

1. Click the black VM box and drag it onto the canvas. This icon represents a virtual machine on a GENI rack.
2. Repeat the above step. You should now see two VM boxes on the canvas.
3. Now click near one of the VM boxes on the canvas, then click and drag towards the other VM. Release when you reach the other VM. You should now see a line and a box representing a network link connecting the two VMs.

![Jacks added](http://witestlab.poly.edu/~ffund/el6383/lab1/geni-jacks-added.png)


To change the name of a VM, click on the the VM box.

For the VM labeled `node-0`, click on the VM box and change "Name" to `Host-1`. Repeat for `node-1`, but change the name to `Router-1`, 

repeat the same steps for `Host-2`, `Host-3`, `Host-4` and `Router-2`

Next, click on the unlabeled box in the middle of the link. Enter 10.1.1.1 as the IP address under "Interface to node host-1", with a mask of 255.255.255.0. Set the IP address under "Interface to node router-1 " to 10.1.1.3 with a mask of 255.255.255.0.

And repeat the above steps for each host as shown below.

![for host2](http://s18.postimg.org/lxddofd8p/host_2_and_router_1.png)
![for host3](http://s27.postimg.org/817mnkuvn/host_3_and_router_2.png)
![for host4](http://s7.postimg.org/j82r1eo8r/host_4_and_router_2.png)
![for router-1 and router-2](http://s15.postimg.org/b552fmhpn/router_1_and_router_2.png)

Note: The interface between `router-1` and `router-2` has netmask `255.255.255.252`

Click the "Site 0" box and select the aggregate you've been assigned from the pulldown menu. (The aggregate assignments are in [Appendix B](#markdown-header-appendix-b).)

The "Reserve Resources" button at the bottom of the pane should now be clickable. Click the "Reserve Resources" button near the bottom of the page.

On the next page, you may have to wait for some time before your resources are ready. Once your resources are ready, the "Status" field will say "Finished":

![Resources ready](http://s23.postimg.org/d04grwwt7/Reserved_Resources.png)

If your resource reservation request fails, try another aggregate according to the instructions in [Appendix B](#markdown-header-appendix-b).

Next, click on the "Slices" option in the top menu. Next to your slice, click on "Details":

On the next page, the portal will query the aggregate you are using to find out if your resources are ready for login. When they are ready (this may take 5-15 minutes), you should see a green "READY" next to each resource:

![Resources ready to login](http://s23.postimg.org/d04grwwt7/Reserved_Resources.png)

Next to each VM, it will show you the hostname and port to use when logging in to the node.

To `ssh` into a VM from the command line on Linux or Mac machines, do the following (substituting the values given in the portal, and the location of your private key):

    ssh USERNAME@HOSTNAME -p PORT  -i /PATH/TO/PRIVATEKEY

From a Windows machine, follow the instructions for your SSH client, using the values given in the portal.

Use SSH to log in to your `Router` machine:

In a second terminal, log in to your `Host` machine.



----------------




The network can be setup as depicted in the following image

![Topology](http://s9.postimg.org/8lz5qi1in/Network_Topology.png)

The Rspec of the topology is provided in the `el6383-project/data/topology.rspec`

The following points need to be kept in mind for the topology:

1. There are 4 Hosts and 2 Routers(i.e Host-1,Host-2,Host-3,Host-4 and Router-1 and Router-2). Host-1,Host-2 and Router-1 are on the same subnet, while host-3,host-4 and Router-2 are configured on the one subnet which is different from the subnet of the Router-1.
2. The interface between Router-1 and Router-2 is considered to be on a separate subnet.
3. Routes should be allocated using Static Routing and no Routing Protocol should be used.
4. The following command should be executed on routers to perform ip forwarding in the subnet.

`sysctl -w net.ipv4.ip_forward=1`


**Scheduling Algorithms**:
We have used two scheduling algorithms pfifo-fast and Random Early Detection(RED).First come first serve is the default algorithm implemented for scheduling of packets. For implementing 
Random Early Detection, you have to use 'tc' command. 

**pfifo-fast:**
pfifo-fast is the default qdisc of each interface.
Whenever an interface is created, the pfifo-fast qdisc is automatically used as a queue. If another qdisc is attached, 
it preempts the default pfifo-fast, which automatically returns to function when an existing qdisc is detached. For example, in the configuration
used in the experiment on interface eth0, eth1 and eth2 the scheduling algorithm used is pfifo and on eth3 we have implemented RED algorithm.

 `tc qdisc`
 
 `qdisc pfifo_fast 0: dev eth0 root refcnt 2 bands 3 priomap  1 2 2 2 1 2 0 0 1 1 1 1 1 1 1 1`
 
 `qdisc pfifo_fast 0: dev eth1 root refcnt 2 bands 3 priomap  1 2 2 2 1 2 0 0 1 1 1 1 1 1 1 1`
 
 `qdisc pfifo_fast 0: dev eth2 root refcnt 2 bands 3 priomap  1 2 2 2 1 2 0 0 1 1 1 1 1 1 1 1`
 
 `qdisc red 8002: dev eth3 root refcnt 2 limit 346000b min 100000b max 225000b ecn`

**Random Early Detection(RED)**
The average queue size is used for determining the marking probability. This is calculated using an Exponential Weighted Moving Average, which can be more or less sensitive to bursts.
When the average queue size is below min bytes, no packet will ever be marked. When it exceeds min, the probability of doing so climbs linearly up to probability, until the average queue size hits max bytes. Because probability is normally not set to 
100%, the queue size might conceivably rise above max bytes, so the limit parameter is provided to set a hard maximum for the size of the queue.

**Parameters**:

*min*-Average queue size at which marking becomes a possibility.

*max*-At this average queue size, the marking probability is maximal. Should be at least twice min to prevent synchronous retransmits, higher for low min.

*probability*-Maximum probability for marking, specified as a floating point number from 0.0 to 1.0.Suggested values are 0.01 or 0.02 (1 or 2%, respectively).

*limit*-Hard limit on the real (not average) queue size in bytes. Further packets are dropped.Should be set higher than *max+burst*. It is advised to set this a few times higher than max.

*burst*-Used for determining how fast the average queue size is influenced by the real queue size. Larger values make the calculation more sluggish, allowing longer bursts of traffic before marking starts. 
Real life experiments support the following guideline: (min+min+max)/(3*avpkt).

*avpkt*-Specified in bytes. Used with burst to determine the time constant for average queue size calculations.1000 is a good value.

*bandwidth*-This rate is used for calculating the average queue size after some idle time. Should be set to the bandwidth of your interface. Does not mean that RED will shape for you! Optional.

*ecn*-As mentioned before, RED can either 'mark' or 'drop'. Explicit Congestion Notification allows RED to notify remote hosts that their rate exceeds the amount of bandwidth available. Non-ECN capable hosts can 
only be notified by dropping a packet. If this parameter is specified, packets which indicate that their hosts honor ECN will only be marked and not dropped, unless the queue size hits limit bytes. Needs a tc binary with RED
support compiled in. Recommended.

**Commands to be used**:
 
`tc qdisc add dev <interface> root red limit bytes min bytes max bytes avpkt bytes burst packets [ ecn ] [ bandwidth rate ] probability chance`

For example to set up the scheduling algorithm on the two routers, we have used the following command for this particular set of values:

`tc qdisc add dev eth3 root red limit 366000 min 100000 max 225000 avpkt 1000 burst 141 probability 0.01`

The units of the various parameters used, are mentioned in the syntax given.

NOTE:The scheduling algorithms need to be implemented on the routers only and not the hosts.

To generate traffic:
Use iperf to generate traffic similarly as we did in lab. Run the server on one of the host(in one subnet) and run the 
client mode on the hosts of other subnet.For instance if Host-1 acts as the server, the traffic will be generated from host-3 and host-4, 
both of which will be acting as clients.

**Throughput using iperf commands**:

`sudo apt-get install iperf   // to install iperf`

`iperf-s // for server mode`

`iperf -c "host name" --reportstyle C -i 1 | tee filename.txt`

For example:

`iperf -c 10.1.1.2 --reportstyle C  -i 1 | tee OUTPUT.txt `

where OUTPUT.txt is the name of an output file which will be created.It will report throughput at one second intervals, 
in a comma-separated values format, and with output saved to the OUTPUT.txt file. (Run cat OUTPUT.txt to see the contents of the file.) 
Please use meaningful names for your output files.

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

**Store Data for Several Trials for each experimental unit**

On your resource, you should clone a copy of your git repository. First

` sudo apt-get install git `

then

` git clone https://URL/OF/YOUR/FORK`

where `URL/OF/YOUR/FORK` is the URL shown in Bitcucket for your indiviaul fork:

![Repository](http://s12.postimg.org/clrozepx9/Screen_Shot_2015_04_17_at_2_33_09_PM.png)

The run(from inside the repository, use `cd` to navigate the filesystem):

`git add project/data/*`

`git commit -m " Added data from....." # insert details in the commit message` 

`git push -u orign master`

To save the data on bitbucket. Verify on the bitbucket web interface that your file appears there.

**Exerimental Results**
### Get and set up a resource

Log on to the GENI portal and create a new slice called 
`project-netID` (using your *own* netID, as usual).

Using Slice Jacks, request *one* node in this slice on your assigned
aggregate.

Name the node `rstudio` and request a publicly routable IP address for it (by
checking the "Publicly Routable IP" checkbox). Then reserve the 
resource.

Once your resource is ready, log in and install git:

```
sudo apt-get update
sudo apt-get install git
```

Then use `git clone` to clone a copy of *your* fork of the lab repository 

For this project, you'll need to set up a password on this individual system (since we'll be using a web interface that doesn't support key-based authentication).
To set a password, run 

```
sudo passwd USERNAME
```

where `USERNAME` is the username you use to log in to this resource. 
You should see output like

```
Enter new UNIX password:  [type password here, hit Enter]
Retype new UNIX password: 
passwd: password updated successfully
```

If you forget this password, you can always reset it with the `sudo passwd USERNAME` command.

Next, install R and R Studio. Run

```
wget http://download2.rstudio.org/rstudio-server-0.98.1102-amd64.deb
```

Become root with `sudo su`, then run 

```
gpg --keyserver keyserver.ubuntu.com --recv-key E084DAB9
gpg -a --export E084DAB9 | apt-key add -

echo "deb http://cran.wustl.edu/bin/linux/ubuntu precise/" >> /etc/apt/sources.list

apt-get update
apt-get install r-base r-cran-rcpp

dpkg -i rstudio-server-0.98.1102-amd64.deb
echo "www-port=80" >>  /etc/rstudio/rserver.conf
rstudio-server restart
```


Next, we'll install a couple of libraries. From the root shell prompt, run

```
R
```

and at the prompt, run

```
install.packages("codetools")
```



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


```
install.packages("reshape2")
```
(in that order). Then run 

```
quit('no')
```

to leave the R terminal and `exit` to leave the root shell.




## Using R

### Log in to R Studio

If you look at your slice details in the GENI portal, you should see a hostname for your resource:

![hostname](http://s23.postimg.org/aynbmx2qj/image.jpg)

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


### Loading and using `iperf` data

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

The data files were read and stored into variables 'data, data1, data2, data3'. 
Using these variables we extracted the throughput and used them to calculate the average throughput for that particular run. The runs were performed in the following combinations of iperf `client-server`:

1. host-1-host-3 (ie. host1 sending packets to host3)
2. host-1-host-4
3. host-2-host-3
4. host-2-host-4
5. host-3-host-1
6. host-3-host-2
7. host-4-host-1
8. host-4-host-2

Note: When host 3/4 was receiving packets (in iperf server mode), it was receiving packets from hosts 1 and 2 simultaneously. Similarly, when host 1/2 was in iperf server mode - packets were being sent from hosts 3 and 4 simultaneously. 

To read in the iperf data, we'll use the read.csv function. Run

`data <- read.csv("el6383-project/data/fifo-1-run1-h3.txt")`

This will load the fifo-1-run1-h3.txt data into a variable called data.

To assign friendly names to the columns of data, we'll save the list of columns into a variable called cnames, then apply that to the column names of data:

`cnames <- c("time","srcip","srcport","dstip","dstport","id","interval","data","tput")`

Similarly, for the other runs of this scenario, we have 4 more files - fifo-1-run2-h3.txt, fifo-1-run3-h3.txt, fifo-1-run4-h3.txt, fifo-1-run5-h3.txt. Read the data in other variables - data1, data2, data3, data4.  

`data <- read.csv("el6383-project/data/fifo-1-run1-h3.txt",header=F)`

`data1 <- read.csv("el6383-project/data/fifo-1-run2-h3.txt",header=F)`

`data2 <- read.csv("el6383-project/data/fifo-1-run3-h3.txt",header=F)`

`data3 <- read.csv("el6383-project/data/fifo-1-run4-h3.txt",header=F)`

`data4 <- read.csv("el6383-project/data/fifo-1-run5-h3.txt",header=F)`

All trials of this scenario will be concatenated in variable all using rbind. Once all the values are concatenated, the average is stored in variable avgfifo13. Divide this by 1000000 to obtain values in Mbps.

`all <- rbind (data,data1,data2,data3,data4)`

`avgfifo13 <- mean(all$V9)/1000000`    #average throughput in Mbps

Repeat the above commands for all scenarios of FIFO. The client-server scenarios are given below:

1. Host-1,Host-3
2. Host-2,Host-3
3. Host-1,Host-4
4. Host-2,Host-4
5. Host-3,Host-1
6. Host-4,Host-1
7. Host-3,Host-2
8. Host-4,Host-2

Note : When a host is configured as server on one subnet, 2 hosts need to generate traffic from other subnet.

Similarly, for RED implementation, the follow these steps:

To read in the iperf data, we'll use the read.csv function. Run

`data <- read.csv("el6383-project/data/red-run1-h1-h3.txt.txt")`

This will load the red-run1-h1-h3.txt data into a variable called data.

To assign friendly names to the columns of data, we'll save the list of columns into a variable called cnames, then apply that to the column names of data:

`cnames <- c("time","srcip","srcport","dstip","dstport","id","interval","data","tput")`

Similarly, for the other runs of this scenario, we have 4 more files - red-run1-h1-h3.txt, red-run1-h1-h3.txt, red-run1-h1-h3.txt, red-run1-h1-h3.txt. Read the data in other variables - data1, data2, data3, data4.  

RED filenames have destination first, then source

`data <- read.csv("el6383-project/data/red-run1-h1-h3.txt",header=F)`

`data1 <- read.csv("el6383-project/data/red-run2-h1-h3.txt",header=F)`

`data2 <- read.csv("el6383-project/data/red-run3-h1-h3.txt",header=F)`

`data3 <- read.csv("el6383-project/data/red-run4-h1-h3.txt",header=F)`

`data4 <- read.csv("el6383-project/data/red-run5-h1-h3.txt",header=F)`

All trials of this scenario will be concatenated in variable all using rbind. Once all the values are concatenated, the average is stored in variable avgfifo13. Divide this by 1000000 to obtain values in Mbps.

`all <- rbind (data,data1,data2,data3,data4)`

`avgred14 <- mean(all$V9)/1000000`    #average throughput in Mbps

Repeat the above commands for all scenarios of RED. The client-server scenarios are given below:

1. Host-1,Host-3
2. Host-2,Host-3
3. Host-1,Host-4
4. Host-2,Host-4
5. Host-3,Host-1
6. Host-4,Host-1
7. Host-3,Host-2
8. Host-4,Host-2

Note : When a host is configured as server on one subnet, 2 hosts need to generate traffic from other subnet.

Next we created two tables containing the averages of FIFO runs and RED runs(with columns throughput, scheduler)

These tables are combined into a single table called 'finaltable'.

Finally using ggplot, we created a box plot using the following commands:

`box <- ggplot(finaltable)`

`box <- box+geom_boxplot(aes(x=Scheduler,y=Throughput,group=Scheduler),fill=c("green","red"))`

`box <- box + ggtitle("Bandwidth spread on varying scheduling algorithm on router nodes")`

`box <- box + scale_y_continuous("Throughput (Mbps)")`

`ggsave("Plot.png", plot=box)`

**Box Plot**
![Box Plot](http://s16.postimg.org/nh9fqb1np/Plot.png)

Using the *mean* command in R:

FIFO mean throughput = 51.56 Mbps

RED mean throughput = 50.82 Mbps

Using the *median* command in R:

FIFO median throughput = 51.16 Mbps

RED median throughput = 50.67 Mbps

Using *standard deviation* (sd) command in R:

Standard deviation for FIFO = 1.61 

Standard deviation for RED = 2.49

**Conclusion**

From our results, we observed that the FIFO scheduling algorithm provided a slightly higher average throughput as compared to the RED scheduling algorithm. 
However, these averages are not conclusive and only represent our particular experimental setup. Although the medians of FIFO and RED were comparable, 
RED provided a significantly larger spread of throughput values over multiple runs. This was verified by checking the standard deviations in both cases (FIFO/RED). 
This spread in values can be attributed to the fact that in RED, the scheduling algorithm probabilistically drops packets from the queues. 