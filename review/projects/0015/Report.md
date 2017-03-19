#Project

The main aim of the project is to study the performanc of SDN controllers POX and RYU by measuring their latency and flows per second 
using a benchmarking tool cbench that emulates required number of switches and MAC's per switches. More specifically we measure performance of 
the controllers POX and RYU for 4, 8, 16 and 32 switches and 1000 MAC's per switch.

##Overview:

**Tools::**Cbench and Rstudio

**Matrices::**latency and flows/ sec

**Parameters::** SDN Controllers, no of switches, no of MAC's per host

Using the above we are going to study the performanc of SDN controllers POX and RYU by measuring their latency and flows per second using a 
benchmarking tool cbench that emulates required number of switches and MAC's per switches.
Cbench can also be used to set other parameters like number of tests per switch and time per test.

POX and RYU are python based controllers that do not support multi-threading.
Hence their performance does not depend on the number of switches. The same should be evident from the experimental results.

We are going to study the performance over different number of switches (4,8,16,32) and 1000 hosts per switch. 
Cbench emulates the requirements and gives the performance output.

The output obtained then can be analysed in Rstudio to generate plots.
It should be evident from the plot that flows per second should not change drastically and should be centerd over some average 
value for different number of switches.


##Getting Started:

We use GENI test-bed for implementation. Log on to GENI portal and create three slices.
All the three slices must have one Xen-VM with Ubuntu 12.04 LTS respectively and Publicly routable IP box checked.
One of the VM will run the cbench tool and the other two VM's will run the RYU and POX controller respectively.
Select the appropriate aggregate and allocate the resources.

![Imgu](http://i.imgur.com/CrSiz2i.png?1)

(**Note:** It is suggested to give appropriate relevant names to the slices and nodes in order to avoid confusion.)

Once the resources have been allocated SSH the servers using gitbash. Enter the passphrase and log in to VM.

###Installing and Configuring:

####Installing POX controller:
 
**Option 1:** Rspec

The Rspec of the POX controller **XEN VM POX Ctrl** is available on 
GENI portal. Select the Rspec and appropriate aggregare and simply allocate resources. 
SSH server and the VM created will have built in POX controller in /tmp directory.
[More details on the approach](http://groups.geni.net/geni/wiki/GENIExperimenter/Tutorials/OpenFlowOVS/DesignSetup)

![XENVMPOX](http://i.imgur.com/OJSoZEG.png?1)

**Option 2:**To set up manually.

Log in to the VM that will run your POX controller and enter the following command

`git clone http://www.github.com/noxrepo/pox`

`cd pox`

*To start POX controller*

`sudo ./pox.py --verbose openflow.of_01 --port=6633 forwarding.l2_learning`

*To stop POX controller*

`sudo killall -9 python2.7`

(**Note:**port number can be changed but make sure that when cbench connects the controller it uses the same specific port number)

Below is the output of a POX controller running.

![POX](http://i.imgur.com/UAcjl7g.png?1)

####Installing RYU controller:

Log in to the VM that will run your RYU controller and install prequisites using following commands.

`sudo apt-get update`

`sudo apt-get install python-setuptools python-bobo`

`time sudo apt-get install python-eventlet python-routes python-webob python-paramiko`

`sudo apt-get install python-pip python-dev libxml2-dev libxslt-dev zlib1g-dev`

`sudo pip install ryu`

Go to tmp directory. I installed in tmp

`cd`

`cd /tmp`

`git clone git://github.com/osrg/ryu.git`

`cd ryu`

`sudo python ./setup.py install`

Run RYU (By default RYU runs on port 6633)

`cd /tmp/ryu && ./bin/ryu-manager --verbose ryu/app/simple_switch.py`

Below is the output of RYU controller running.

![RYU](http://i.imgur.com/YKbp6O4.png?1)


####Installing Cbench:

Log in to one of the VM that will run your cbench tool and install the dependencies using the following command 

`sudo apt-get install autoconf automake libtool libsnmp-dev libpcap-dev libconfig8-dev`

Checking-out the source code of OpenFlow

`git clone git://gitosis.stanford.edu/openflow.git`
 
Switch to released version 1.0.0

`cd openflow`

`git checkout -b mybranch origin/release/1.0.0` 
 
Checking-out the source code of Oflops

`git clone git://gitosis.stanford.edu/oflops.git`
 
Build the source code

`cd oflops` 

`sh ./boot.sh` 

`./configure --with-openflow-src-dir= /your/directory/of/openflow/folder`

`make`

`sudo make install` 

(**Note:** "your/directory/of/openflow/folder" specify your directory of openflow folder here. In my case directory was /users/jrp497/openflow) 

Execute Cbench

`cd cbench`

Sample localhost execution

`cbench -c localhost -p 6633 -m 10000 -l 10 -s 16 -M 1000 -t`

(**Note:** -p specifies port number,-s number of switches, -M number of unique source MAC's per switch, -l tests per switch, -m specifies ms per test
and -c specifies IP (localhost for same computer and for remote VM use IP of that VM which can be obtained by `ifconfig` command)

Output of the above command looks like the following:

```
cbench: controller benchmarking tool
   running in mode 'throughput'
   connecting to controller at localhost:6633 
   faking 16 switches offset 1 :: 10 tests each; 10000 ms per test
   with 1000 unique source MACs per switch
   learning destination mac addresses before the test
   starting test with 0 ms delay after features_reply
   ignoring first 1 "warmup" and last 0 "cooldown" loops
   connection delay of 0ms per 1 switch(es)
   debugging info is off
controller msgbuf_read() = 0:   closed connection ... exiting  
``` 


###Executing final command

Log in to any one of the two VM on which you have the controller installed if you are not logged in already, depending on the controller
you intend to run either POX or RYU. Note down the IP of that Server before starting the controller using `ifconfig`.
Start the controller.

Log in to the VM that has cbench tool installed on it if you are not logged in already and follow the commands below.

`cd`

`mkdir output` creates folder output which will have all the outputs

`cbench -c (controllers server ip) -p 6633 -m 10000 -l 10 -s 16 -M 1000 -t > /users/(yournetid)/output/file_name.txt`

(**Note:** you must know the IP of the server on which controller runs. You may store the output in a text file anywhere. Here we store it in
the output folder. Just make sure to specify the path where you want to store file correctly. Also specify the IP address of the server running
the controller either POX or RYU correctly)

In my case

`cbench -c 192.86.139.81 -p 6633 -m 10000 -l 10 -s 16 -M 1000 -t > /users/jrp497/output/output_4_1000.txt`

##Generating Output

###Flows/second 

You can now change the number of switches & MAC's per switch and generate output for a particular controller.
To change the controller change the IP. Output is logged in a text file that can be processed in Rstudio to generate Plots.

Using the above procedure we can study the performance of a particular controller by knowing the flows/second for different number of switches
(4,8,16,32) and fixed MAC's per switch say 1000. Plot of flows/second VS number of switches can be plotted.

Also number of switches can be kept fixed say 16 and MAC's per switch can be varied (1000,10000,100000,1000000) for a particular controller and 
its flows/second can be noted down. Plot of flows/second VS MAC's per switch can be plotted. 

###Latency

Latency of the controller can be calculated keeping number of switches as 1 and number of MAC's per switch as desired say 10^3. Output flows/second 
is obtained, from which time taken by a single flow can easily be calculated.

##Results

####Flows/second measurements 

**Table 1:** Number of MAC's Per switch is 1000 for the below Flows/second measurement. Number of switches is varied. 
**(Refer Plot 1 of Number of switches VS Flows/second below)**

                                       
**Controller**         |  **4 Switches**      | **8 Switches**       | **16 Switches**      | **32 Switches**      |      
-----------------------|----------------------|----------------------|----------------------|----------------------|
**RYU**                | 1887.37 Flows/second | 1854.38 Flows/second | 1852.44 Flows/second | 1893.04 Flows/second |
**POX**                | 1780.30 Flows/second | 1779.66 Flows/second | 1820.60 Flows/second | 1762.44 Flows/second | 

**Table 2:** Number of switches is 16 for the below Flows/second measurement. Number of MAC's per switch is varied.
**(Refer Plot 2 of Number of MAC's per switch VS Flows/second below)**

**Controller**         |  **1000 hosts**      | **10000 hosts**       | **100000 hosts**      | **1000000 hosts**       |      
-----------------------|----------------------|---------------------- |---------------------- |----------------------   |
**RYU**                | 1770.58 Flows/second | 1801.37 Flows/second  | 1777.71 Flows/second   | 1752.61 Flows/second   | 
**POX**                | 2817.45 Flows/second | 2792.59 Flows/second  | 2602.35 Flows/second   | 2860.95 Flows/second   | 


####Latency Mesurements

Number of switches =1 and MAC's per switch = 10^5 for below Latency measuremant                          

**Controller** | **Latency**    | 
---------------|----------------|
**RYU**        | 0.5164 ms/flow | 
**POX**        | 0.6554 ms/flow |


**Output data text files can be found in datafiles/output folder in the repository.**

##Plot 1

![Plot](http://i.imgur.com/V18qJYH.png?1)

**Code for generating output plot 1 can be found in the plots folder of the repository in final_plot_1.R file** 

##Plot 2

![2.1](http://i.imgur.com/rQJQmIU.png?1)
![2.1](http://i.imgur.com/624LctC.png?1)

**Code for generating output plot 2 can be found in the plots folder of the repository in final_plot_2.R file** 


##Generating Output from pre-established setup

**Starting up RYU Controller: jrp497@pcvm2-34.genirack.nyu.edu**

Log in to slice/VM that has ryu controller installed.

Type the following command to start the controller. RYU Controller is present in /tmp folder

`cd /tmp/ryu && ./bin/ryu-manager --verbose ryu/app/simple_switch.py`

This will start your RYU controller.

**Starting up POX Controller: jrp497@pcvm1-33.genirack.nyu.edu**

Log in to slice/VM that has pox controller installed.POX controller is present in /tmp folder to assess type.

`cd /tmp/pox`

Type the following command to start the controller

`sudo ./pox.py --verbose openflow.of_01 --port=6633 forwarding.l2_learning`

This will start the POX controller.

**Starting up cbench tool: jrp497@pcvm1-47.genirack.nyu.edu**

Log in to slice/VM that has cbench controller installed.

Start cbench by typing the following command

`cbench -c 192.86.139.88 -p 6633 -m 10000 -l 10 -s 16 -M 1000 -t > /users/jrp497/output/output_4_1000.txt`

**(Note: change the IP according to the server on which your controller is running.
Also change the name and path of the file as desired.)

Output is recorded in a text file to view the contents of text file `cat file_name.txt` command can be used.



###Understanding reference output file format present in datafiles/output folder in the repository.
**Reference output data files are present in datafiles/output folder in the repository**

**For files with names latency_pox_1.txt , latency_ryu_10.txt, latency_pox_10.txt and so on:**

latency_ryu indicates latency for ryu controller _10 or _1 indicates Number of MAC's per switch. Note that all the latency outputs have been taken for single switch.

**For files with names output_16_1000.txt, output_8_1000.txt, output_4_1000.txt and so on:**

These files represent output of POX controller for 1000 MAC's per switch and 4, 8, 16 or 32 switches.

**For files with names ryu_output_16_1000.txt, ryu_output_8_1000.txt, ryu_output_4_1000.txt and so on:**

These files represent output of RYU controller for 1000 MAC's per switch and 4, 8, 16 or 32 switches.

**For files with names pox_s16_1000h.txt, ryu_s16_10000.txt, pox_s16_100000.txt and so on:**

These files represent outputs of RYU or POX controller as specified in the name for 16 switches (s16) and 1000, 10000, 100000 or 1000000 MAC's per switch

###References

[https://github.com/ARCCN/ctltest](https://github.com/ARCCN/ctltest)

[http://groups.geni.net/geni/wiki/GENIExperimenter/Tutorials/OpenFlowOVS](http://groups.geni.net/geni/wiki/GENIExperimenter/Tutorials/OpenFlowOVS)

[CEE-SECR '13 Proceedings of the 9th Central & Eastern European Software Engineering Conference in Russia Article No. 1  ACM New York, NY, USA ©2013 table of contents ISBN: 978-1-4503-2641-4 doi>10.1145/2556610.2556621](http://www.researchgate.net/profile/Ruslan_Smeliansky/publication/262155093_Advanced_study_of_SDNOpenFlow_controllers/links/0deec5214c88b0b98a000000.pdf)