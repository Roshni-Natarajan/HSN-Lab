
*** Manual Installation of XORP in Ubuntu 12.04 on Virtual Machine(Router)

Step 1: Installing Dependencies
--> sudo apt-get update
--> sudo apt-get install libssl-dev
--> sudo apt-get install ncurses-dev
--> sudo apt-get install libpcap-dev
--> sudo apt-get install g++ traceroute
--> sudo apt-get install scons


Step 2: Downloading XORP source files
--> cd ~/
--> wget http://www.xorp.org/releases/current/xorp-1.8.5-src.tar.bz2
--> tar jvxf xorp-1.8.5-src.tar.bz2


Step 3: Compiling and building XORP
--> cd xorp
--> scons
--> sudo scons install

Note - The process takes about 40 minutes and upon the successful installation we can see the directory "xorp" under path /usr/local

Step 4: *** Enabling "ecn" on router (Switch to root)
--> echo 1 > /proc/sys/net/ipv4/tcp_ecn



*** Updating kernel to 3.18.3 in Ubuntu 14.04 64 bit (DCTCP enabled kernel) - on Virtual Machines (Server & Client)

Step 1: Downloading the kernel files
--> wget http://kernel.ubuntu.com/~kernel-ppa/mainline/v3.18.3-vivid/linux-headers-3.18.3-031803_3.18.3-031803.201501161810_all.deb
--> wget http://kernel.ubuntu.com/~kernel-ppa/mainline/v3.18.3-vivid/linux-headers-3.18.3-031803-generic_3.18.3-031803.201501161810_amd64.deb
--> wget http://kernel.ubuntu.com/~kernel-ppa/mainline/v3.18.3-vivid/linux-image-3.18.3-031803-generic_3.18.3-031803.201501161810_amd64.deb


Step 2: Installing the downloaded files
--> sudo dpkg -i linux-headers-3.18.3*.deb linux-image-3.18.3*.deb

[Click the option "OK" when prompted]


Step 3: Updating the grub and rebooting the computer

--> sudo update-grub
--> sudo reboot











Sources:
1. [http://groups.geni.net/geni/wiki/GENIExperimenter/Tutorials/SystematicExprCaseStudy/InstallSoftware]
2. [http://www.linuxandubuntu.com/home/install-linux-kernel-to-3183-stable-in-ubuntu-linux-mint-peppermint]


Experimental Steps
Node 0 - Client
Node 1 - Server

Steps for reproducing the experiment :
sudo apt-get install git
git clone https://URL/OF/YOUR/FORK

Run the following commands for different sets of delays for cubic
modprobe tcp_cubic
sysctl -w ipv4.net.tcp__congestion_control=cubic
sysctl net.ipv4.tcp__congestion_control
tc qdisc add dev eth1 root netem delay 50ms//add latency of 50ms on both server and client
sudo apt-get install iperf //Install iperf package in both server and client by using 
iperf -s // start the server
iperf -c 10.0.163.1 --reportstyle C -i 1 | tee Cubic-50-rtt-1.txt

mv Cubic-50-rtt-1.txt to el6383/Results //moving file to Results folder
tc qdisc del dev eth1 root//remove emulated latency on both client and server interface
tc qdisc add dev eth1 root netem delay 100ms//add latency of 100ms on both server and client


iperf -c 10.0.163.1 --reportstyle C -i 1 | tee Cubic-100-rtt-1.txt
mv Cubic-100-rtt-1.txt to el6383/Results //moving file to Results folder

tc qdisc del dev eth1 root//remove emulated latency on both client and server interface
tc qdisc add dev eth1 root netem delay 200ms//add latency of 200ms on both server and client

iperf -c 10.0.163.1 --reportstyle C -i 1 | tee Cubic-200-rtt-1.txt
mv Cubic-200-rtt-1.txt to el6383/Results //moving file to Results folder


navigate to the repository by using cd command.
git add Results/*
git commit -m "Results file"
git push -u origin master


Run the following commands for different sets of delays for dctcp

modprobe tcp_dctcp
sysctl -w ipv4.net.tcp__congestion_control=dctcp
sysctl net.ipv4.tcp__congestion_control

tc qdisc add dev eth1 root netem delay 50ms//add latency of 50ms on both server and client
sudo apt-get install iperf //Install iperf package in both server and client by using 
iperf -s // start the server
iperf -c 10.0.163.1 --reportstyle C -i 1 | tee Dctcp-50-rtt-1.txt
mv Dctcp-50-rtt-1.txt to el6383/Results //moving file to Results folder
tc qdisc del dev eth1 root//remove emulated latency on both client and server interface
tc qdisc add dev eth1 root netem delay 100ms//add latency of 100ms on both server and client

iperf -c 10.0.163.1 --reportstyle C -i 1 | tee Dctcp-100-rtt-1.txt
mv Dctcp-100-rtt-1.txt to el6383/Results //moving file to Results folder

tc qdisc del dev eth1 root//remove emulated latency on both client and server interface
tc qdisc add dev eth1 root netem delay 200ms//add latency of 200ms on both server and client

iperf -c 10.0.163.1 --reportstyle C -i 1 | tee Dctcp-200-rtt-1.txt
mv Dctcp-200-rtt-1.txt to el6383/Results //moving file to Results folder


navigate to the repository by using cd command.
git add Results/*
git commit -m "Results file"
git push -u origin master



Run the following commands for different number of flows in Cubic
modprobe tcp_cubic
sysctl -w ipv4.net.tcp__congestion_control=cubic // set tcp variant to dctcp
sysctl net.ipv4.tcp__congestion_control // to see what tcp variant is running

iperf -s //Start the server
iperf -c 10.0.163.1 -P 4 --reportstyle C -i 1 | tee Cubic-flow-4.txt 
mv Cubic-flow-4.txt to el6383/Results  //moving file to Results folder and
   navigate to the repository by using cd command.


iperf -c 10.0.163.1 -P 8 --reportstyle C -i 1 | tee Cubic-flow-8.txt 
mv Cubic-flow-8.txt to el6383/Results  //moving file to Results folder and
   navigate to the repository by using cd command.



iperf -c 10.0.163.1 -P 12 --reportstyle C -i 1 | tee Cubic-flow-12.txt 
mv Cubic-flow-12.txt to el6383/Results  //moving file to Results folder and
   navigate to the repository by using cd command.


git add Results/*
git commit -m "Results file"
git push -u origin master






Run the following commands for different number of flows in Dctcp

modprobe tcp_dctcp
sysctl -w net.ipv4.tcp_congestion_control=dctcp // set tcp variant to dctcp
sysctl net.ipv4.tcp_congestion_control // to see what tcp variant is running
iperf -s //Start the server
iperf -c 10.0.163.1 -P 4 -i 1 | tee Dctcp-flow-4.txt 
mv Dctcp-flow-4.txt to el6383/Results  //moving file to Results folder and
   navigate to the repository by using cd command.


iperf -c 10.0.163.1 -P 8 --reportstyle C -i 1 | tee Dctcp-flow-8.txt 
mv Dctcp-flow-8.txt to el6383/Results  //moving file to Results folder and
   navigate to the repository by using cd command.

iperf -c 10.0.163.1 -P 12 --reportstyle C -i 1 | tee Dctcp-flow-12.txt 
mv Dctcp-flow-12.txt to el6383/Results  //moving file to Results folder and
   navigate to the repository by using cd command.


git add Results/*
git commit -m "Results file"
git push -u origin master






Installing Rstudio

Get and set up a resource
Log on to the GENI portal and create a new slice called lab2b-netID (using your own netID, as usual).
Using Slice Jacks, request one node in this slice on your assigned aggregate (note: there are some different aggregate assignments this week, make sure to use the correct one).
Name the node rstudio and request a publicly routable IP address for it (by checking the "Publicly Routable IP" checkbox). Then reserve the resource.
Once your resource is ready, log in and install git:
sudo apt-get update
sudo apt-get install git

Then use git clone

mv el6383-NETID el6383

sudo passwd USERNAME
Enter new UNIX password:  [type password here, hit Enter]
Retype new UNIX password: 
passwd: password updated successfully
wget http://download2.rstudio.org/rstudio-server-0.98.1102-amd64.deb
sudo su
gpg --keyserver keyserver.ubuntu.com --recv-key E084DAB9
gpg -a --export E084DAB9 | apt-key add -

echo "deb http://cran.wustl.edu/bin/linux/ubuntu precise/" >> /etc/apt/sources.list

apt-get update
apt-get install r-base r-cran-rcpp

dpkg -i rstudio-server-0.98.1102-amd64.deb
echo "www-port=80" >>  /etc/rstudio/rserver.conf
rstudio-server restart
R
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

Login to GENI portal and copy the host name of resource in browser and login to Rstudio.

Run R script:
R CMD BATCH flowscript.R
R CMD BATCH myscript.R


Note: 
Since we have already upgraded the kernel to the 3.18 version so users dont need to follow the above instructions in case of live setup.
