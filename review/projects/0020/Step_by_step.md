A Step-by-step Guide to Reproduce Our Experiment
========


**This is a step-by-step guide to help you finish this experiment. You just need to use the same commands with a little change.**

We run 3 flows of a high-speed TCP variant over a long-RTT network path (~220ms) and 3 flows of long-term TCP-SACK flows over a short-RTT path 
(~20ms). These two paths share a bottleneck link of 25Mbps. In this experiment, to see how stable different protocols become as the buffer 
space of the bottleneck router varied, we vary the buffer space of the bottleneck router from 200% to 20% of the BDP of the bottleneck. The background TCP traffic is added to the bottleneck link.

First of all, you should reserve resources use GENI as we did in previous labs. We have provided a RSpec file of the whole topology 
called `cubic.xml` (inside the project folder), 
you just need to upload it to Slice editor, and choose your aggregate, then reserve resources.

##1. Buffer size - 20% of the BDP
You will need to set the latency and the buffer size of switches.

###1) Switches:
We have 4 Switches in the topology, they are named as switch1, switch2, bottleneck1 and bottleneck2. Please follow the 
instruction below to set the latency and buffer size for each switch. 

You **need to change** `ssh USERNAME@HOSTNAME -p PORT  -i /PATH/TO/PRIVATEKEY` to your own hostname, port and path to private key to log 
into the node.
####Switch1 and Switch2:
    ssh USERNAME@HOSTNAME -p PORT  -i /PATH/TO/PRIVATEKEY
    sudo su
    tc qdisc add dev eth1 root netem delay 50ms 2ms
    tc qdisc add dev eth2 root netem delay 50ms 2ms
    sysctl -w net.ipv4.tcp_wmem="1000000 1100000 1200000"
    sysctl -w net.ipv4.tcp_rmem="1000000 1100000 1200000"
    exit
    exit

####Bottleneck1 and Bottleneck2:
    ssh USERNAME@HOSTNAME -p PORT  -i /PATH/TO/PRIVATEKEY
    sudo su
    tc qdisc add dev eth1 root netem delay 5ms 0.5ms
    tc qdisc add dev eth2 root netem delay 5ms 0.5ms
    tc qdisc add dev eth3 root netem delay 5ms 0.5ms
    sysctl -w net.ipv4.tcp_wmem="1000000 1100000 1200000"
    sysctl -w net.ipv4.tcp_rmem="1000000 1100000 1200000"
    exit
    exit

###2) Servers and clients:
In the topology there are four nodes, regulars and regularc are server and client for running long-term 
TCP-SACK flows. highs and highc are server and client for running high-speed TCP flows. For these servers and clients, we 
need to install iperf. Then, set the "regular" client's TCP variant to be veno, and set the "high speed" client's TCP 
variant to be CUBIC. You should follow the commands below to get the iperf output.

For your convenience, **DO NOT CHANGE** the name of the output files, otherwise your need to modify those file names in the 
further steps.
####regulars:
    ssh USERNAME@HOSTNAME -p PORT  -i /PATH/TO/PRIVATEKEY
    sudo apt-get install iperf
    iperf -s

####regularc:
    ssh USERNAME@HOSTNAME -p PORT  -i /PATH/TO/PRIVATEKEY
    sudo su
    apt-get install iperf
    modprobe tcp_veno
    sysctl -w net.ipv4.tcp_congestion_control=veno
    sysctl net.ipv4.tcp_congestion_control
    iperf -c regulars -P 3 -t 600
    
####highs:
    ssh USERNAME@HOSTNAME -p PORT  -i /PATH/TO/PRIVATEKEY
    sudo apt-get install iperf
    iperf -s

####highc:
    ssh USERNAME@HOSTNAME -p PORT  -i /PATH/TO/PRIVATEKEY
    sudo su
    apt-get install iperf
    apt-get install git
    modprobe tcp_cubic
    sysctl -w net.ipv4.tcp_congestion_control=cubic
    sysctl net.ipv4.tcp_congestion_control
    iperf -c highs -P 3 -t 500 --reportstyle C  -i 1 | tee CUBIC-buffer20.txt

###3) Change TCP Variant:
Then you need to change the TCP variant of highc, and get iperf outputs again. **Please note: every time before you run iperf command on highc, 
you need to run `iperf -s` on regulars and highs, and run `iperf -c regulars -P 3 -t 600` on regularc.**
####Change TCP variant of highc (BIC):
    modprobe tcp_bic
    sysctl -w net.ipv4.tcp_congestion_control=bic
    sysctl net.ipv4.tcp_congestion_control
    iperf -c highs -P 3 -t 500 --reportstyle C  -i 1 | tee BIC-buffer20.txt

####Change TCP variant of highc (HSTCP):
    modprobe tcp_highspeed
    sysctl -w net.ipv4.tcp_congestion_control=highspeed
    sysctl net.ipv4.tcp_congestion_control
    iperf -c highs -P 3 -t 500 --reportstyle C  -i 1 | tee HSTCP-buffer20.txt

####Change TCP variant of highc (HTCP):
    modprobe tcp_htcp
    sysctl -w net.ipv4.tcp_congestion_control=htcp
    sysctl net.ipv4.tcp_congestion_control
    iperf -c highs -P 3 -t 500 --reportstyle C  -i 1 | tee HTCP-buffer20.txt

####Change TCP variant of highc (STCP):
    modprobe tcp_scalable
    sysctl -w net.ipv4.tcp_congestion_control=scalable
    sysctl net.ipv4.tcp_congestion_control
    iperf -c highs -P 3 -t 500 --reportstyle C  -i 1 | tee STCP-buffer20.txt
    
    
##2. Buffer size - 200% of the BDP

Now, you need to log into the switches again and change the buffer size to 200% of the BDP.
####For Switch1, Switch2, Bottleneck1 and Bottleneck2, run the commands below on each node respectively:
    ssh USERNAME@HOSTNAME -p PORT  -i /PATH/TO/PRIVATEKEY
    sudo su
    sysctl -w net.ipv4.tcp_wmem="10000000 11000000 12000000"
    sysctl -w net.ipv4.tcp_rmem="10000000 11000000 12000000"
    exit
    exit

And you are going to get the iperf output again:
####regulars:
    ssh USERNAME@HOSTNAME -p PORT  -i /PATH/TO/PRIVATEKEY
    iperf -s

####regularc:
    ssh USERNAME@HOSTNAME -p PORT  -i /PATH/TO/PRIVATEKEY
    sudo su
    modprobe tcp_veno
    sysctl -w net.ipv4.tcp_congestion_control=veno
    sysctl net.ipv4.tcp_congestion_control
    iperf -c regulars -P 3 -t 600

####highs:
    ssh USERNAME@HOSTNAME -p PORT  -i /PATH/TO/PRIVATEKEY
    iperf -s

####highc:
    ssh USERNAME@HOSTNAME -p PORT  -i /PATH/TO/PRIVATEKEY
    sudo su
    modprobe tcp_cubic
    sysctl -w net.ipv4.tcp_congestion_control=cubic
    sysctl net.ipv4.tcp_congestion_control
    iperf -c highs -P 3 -t 500 --reportstyle C  -i 1 | tee CUBIC-buffer200.txt
    
###Change TCP Variant:
Then you need to log into highc and change the TCP variant, and get iperf outputs. **Please note: every time before you run iperf command on highc, 
you need to run `iperf -s` on regulars and highs, and run `iperf -c regulars -P 3 -t 600` on regularc.**
####Change TCP variant of highc (BIC):
    modprobe tcp_bic
    sysctl -w net.ipv4.tcp_congestion_control=bic
    sysctl net.ipv4.tcp_congestion_control
    iperf -c highs -P 3 -t 500 --reportstyle C  -i 1 | tee BIC-buffer200.txt

####Change TCP variant of highc (HSTCP):
    modprobe tcp_highspeed
    sysctl -w net.ipv4.tcp_congestion_control=highspeed
    sysctl net.ipv4.tcp_congestion_control
    iperf -c highs -P 3 -t 500 --reportstyle C  -i 1 | tee HSTCP-buffer200.txt

####Change TCP variant of highc (HTCP):
    modprobe tcp_htcp
    sysctl -w net.ipv4.tcp_congestion_control=htcp
    sysctl net.ipv4.tcp_congestion_control
    iperf -c highs -P 3 -t 500 --reportstyle C  -i 1 | tee HTCP-buffer200.txt

####Change TCP variant of highc (STCP):
    modprobe tcp_scalable
    sysctl -w net.ipv4.tcp_congestion_control=scalable
    sysctl net.ipv4.tcp_congestion_control
    iperf -c highs -P 3 -t 500 --reportstyle C  -i 1 | tee STCP-buffer200.txt,

Then, if you check the directory by using command `ls`, you should see 10 files:

* CUBIC-buffer20.txt
* BIC-buffer20.txt
* HSTCP-buffer20.txt
* HTCP-buffer20.txt
* STCP-buffer20.txt
* CUBIC-buffer200.txt
* BIC-buffer200.txt
* HSTCP-buffer200.txt
* HTCP-buffer200.txt
* STCP-buffer200.txt

You should clone a copy of your git repository, do

    git clone https://URL/OF/YOUR/FORK
    
Where `URL/OF/YOUR/FORK` is the URL shown in Bitbuck for your individual fork.

Make a directory:

    mkdir data
    
Move the data files to the 'data' folder inside this working copy of your repository.

    mv CUBIC-buffer20.txt data
    mv BIC-buffer20.txt data
    mv HSTCP-buffer20.txt data
    mv HTCP-buffer20.txt data
    mv STCP-buffer20.txt data
    mv CUBIC-buffer200.txt data
    mv BIC-buffer200.txt data
    mv HSTCP-buffer200.txt data
    mv HTCP-buffer200.txt data
    mv STCP-buffer200.txt data

    mv data el6383-NETID/proj

where `el6383-NETID` is the name of your repository.

Then run (from inside the repository, use cd to navigate the filesystem):

    cd el6383-NETID/
    git add proj/*
    git commit -m "Added data from highc"
    git push -u origin master
    
to save your data file to Bitbucket. Verify on the Bitbucket web interface that your file appears there.

##3. Analyze your data using R

###1) Install R on VM Rstudio:

Check "details" of your slice on GENI to get the login information of VM rstudio, then login.

Then install git and R, just like what we did in [lab2b](https://bitbucket.org/ffund/el6383/src/c91349619100eca34af28298fa4289bf7311c4a8/lab2b/README.md?at=master).

After everthing is installed, you can log into the web interface of R by using your username and password.

###2) Modify file "index.R":

Your should modify the file "index.R" to make it match your repository path. the whole "index.R" file is shown below:
 
```
# script and data folder addresses
script_folder_addr<-"~/cubic-stability-project/script/"
folder_addr <- "~/cubic-stability-project/data/"
# name of your row data1 without ext
file1_name1 <- "CUBIC-buffer20"
file1_name2 <- "BIC-buffer20"

...
```

You need to replace `~/cubic-stability-project/script/` and `~/cubic-stability-project/data/` by your own path to R_script1.R 
and data files.

Then, copy the script of file index.R to the Rstudio and run, you will get 10 graghs.
