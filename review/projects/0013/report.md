# Traffic Control: Policing vs Shaping


### Project Idea and Goal:

As content on the Internet increasingly requires higher bandwidth speeds than ever before, there has been a growing interest in limiting speeds to provide more even bandwidth allotments for all users of the network. The goal of this experiment is to see how closely one can get the actual throughput of a connection to match the desired limit, while using different policies such as 'Policing' and 'Shaping'. We will be varying the max rate and burst of a connection between two nodes, and then measuring the throughput. 'OVS' is used for the Policing case, while 'tc' will be used for the shaping case. 

### Node Names and Port Numbers:

If at any point, you are having trouble setting up the experiment, there are nodes already set up with the necessary software installed. 

(*Yes, the hostnames are reversed for each case.*)

For the Policing case:

Node-0: node-0.ShapingCase.ch-geni-net.genirack.nyu.edu, Port: 41018

Node-1: node-1.ShapingCase.ch-geni-net.genirack.nyu.edu, Port: 41019

For the Shaping case:

Node-0: node-0.PolicingCase.ch-geni-net.genirack.nyu.edu, Port: 34874

Node-1: node-1.PolicingCase.ch-geni-net.genirack.nyu.edu, Port: 34875

### Policing:

Access the Project tab and create a Slice called policing. 

An RSpec XML file is in the project repository named: `PolicingShapingRSpec.XML`

Enter Jacks to Add Resources. To upload Rspec choose ‘File’ and upload the file to Geni.

You should see:

![jacks](https://i.imgur.com/DOjZaR3.png)

Reserve resources and SSH into ‘node-0’ and ‘node-1’

Install git on node-1 and clone your project repository. 

On node-0 set the rate and burst, and on node-1 we measure the rate at which node-0 can send data as a host ("-H" parameter). This is achieved using the following procedure and code:

Enter in these lines of code into both nodes:

```
sudo bash
apt-get -y update 
apt-get -y install qemu-kvm libvirt-bin bridge-utils virt-manager
apt-get -y install openvswitch-datapath-source bridge-utils 
module-assistant auto-install openvswitch-datapath 
apt-get -y install openvswitch-brcompat openvswitch-common 
wget https://gist.githubusercontent.com/anonymous/d8302f412f8afab2990d/raw/3c5f12968cd4ae5f0f724fea0865642509ffa5b5/BrCompatChange --output-document=/etc/default/openvswitch-switch
service openvswitch-switch restart 
```

Then, on node-0, enter in the following: 

```
ovs-vsctl add-br br-int 
ovs-vsctl add-port br-int eth1
ifconfig eth1 0
ifconfig br-int 10.10.1.1 netmask 255.255.255.0
route add -net 10.10.1.0 netmask 255.255.255.0 dev br-int
ovs-vsctl set-controller br-int tcp:127.0.0.1:6633 
apt-get install netperf
```

Then, on node-1, enter the following:

```
ovs-vsctl add-br br-int2
ovs-vsctl add-port br-int2 eth1
ifconfig eth1 0
ifconfig br-int2 10.10.1.2 netmask 255.255.255.0
route add -net 10.10.1.0 netmask 255.255.255.0 dev br-int2
ovs-vsctl set-controller br-int2 tcp:127.0.0.1:6633 
apt-get install netperf
```


Now, go back to node-0 and enter the following:

```
ovs-vsctl set interface br-int ingress_policing_rate=1000 
ovs-vsctl set interface br-int ingress_policing_burst=60
```

Go back to node-1 and enter the following:

```
netperf -H node-0 >> policing.txt
```

That command on node-1 should give you an output of about 1 for throughput. 

Go back to node-0 and change the rate and burst again. After each time you change the rate and burst on node-0, go back to node-1 and run the `netperf -H node-0 >> policing.txt` command. The rest of the rate and burst commands are below; just copy two lines to node-0, then `netperf -H node-0 >> policing.txt` on node-1, then the next two lines to node-0, and so on and so forth. All of the burst values are 6% of their rate values.

```
ovs-vsctl set interface br-int ingress_policing_rate=5000 
ovs-vsctl set interface br-int ingress_policing_burst=300 
```

```
ovs-vsctl set interface br-int ingress_policing_rate=10000 
ovs-vsctl set interface br-int ingress_policing_burst=600 
```

```
ovs-vsctl set interface br-int ingress_policing_rate=20000 
ovs-vsctl set interface br-int ingress_policing_burst=600 
```

```
ovs-vsctl set interface br-int ingress_policing_rate=30000 
ovs-vsctl set interface br-int ingress_policing_burst=600 
```

```
ovs-vsctl set interface br-int ingress_policing_rate=40000 
ovs-vsctl set interface br-int ingress_policing_burst=600 
```

```
ovs-vsctl set interface br-int ingress_policing_rate=50000 
ovs-vsctl set interface br-int ingress_policing_burst=600 
```

After completing all the commands, go to node-1 and run the following command to remove unnecessary lines from the output file ‘policing.txt’:

```
sed '1,/^$/ d; 8,/^$/ d; 15,/^$/ d; 22,/^$/ d; 29,/^$/ d; 36,/^$/ d; 43,/^$/ d; s/\s\+/,/g' policing.txt >> policing-data.txt
```

The `policing-data.txt` will be used in the R script. 
Move the `policing-data.txt` file into the Submit folder in the project repository and push your repo to bitbucket. 

Complete this part of the experiment and release the resource

### Shaping:

Access the Project tab and create a Slice called shaping. 

The same RSpec file from part one will be used in this section. 

Enter Jacks to Add Resources. To upload Rspec choose ‘File’ and upload the file to Geni.

You should see the same configuration as the policing set up.

Install git on node-1 and clone your project repository. 

Reserve resources and SSH into ‘node-0’ and ‘node-1’

On node-0, run the following commands:

```
sudo bash
apt-get -y update
apt-get install netperf
```

Once the above commands have been entered on node-0, switch to node-1, and run the following commands:

```
sudo bash
apt-get -y update
apt-get install netperf
tc qdisc add dev eth1 root handle 1: htb default 10
tc class add dev eth1 parent 1: classid 1:1 htb rate 1Mbit burst 60k
tc class add dev eth1 parent 1:1 classid 1:10 htb rate 1Mbit burst 60k
netperf -H node-0 >> shaping.txt
```

```
tc qdisc del dev eth1 root
tc qdisc add dev eth1 root handle 1: htb default 10
tc class add dev eth1 parent 1: classid 1:1 htb rate 5Mbit burst 300k
tc class add dev eth1 parent 1:1 classid 1:10 htb rate 5Mbit burst 300k
netperf -H node-0 >> shaping.txt
```

```
tc qdisc del dev eth1 root
tc qdisc add dev eth1 root handle 1: htb default 10
tc class add dev eth1 parent 1: classid 1:1 htb rate 10Mbit burst 600k
tc class add dev eth1 parent 1:1 classid 1:10 htb rate 10Mbit burst 600k
netperf -H node-0 >> shaping.txt
```

```
tc qdisc del dev eth1 root
tc qdisc add dev eth1 root handle 1: htb default 10
tc class add dev eth1 parent 1: classid 1:1 htb rate 20Mbit burst 1200k
tc class add dev eth1 parent 1:1 classid 1:10 htb rate 20Mbit burst 1200k
netperf -H node-0 >> shaping.txt
```

```
tc qdisc del dev eth1 root
tc qdisc add dev eth1 root handle 1: htb default 10
tc class add dev eth1 parent 1: classid 1:1 htb rate 30Mbit burst 1800k
tc class add dev eth1 parent 1:1 classid 1:10 htb rate 30Mbit burst 1800k
netperf -H node-0 >> shaping.txt
```

```
tc qdisc del dev eth1 root
tc qdisc add dev eth1 root handle 1: htb default 10
tc class add dev eth1 parent 1: classid 1:1 htb rate 40Mbit burst 2400k
tc class add dev eth1 parent 1:1 classid 1:10 htb rate 40Mbit burst 2400k
netperf -H node-0 >> shaping.txt
```

```
tc qdisc del dev eth1 root
tc qdisc add dev eth1 root handle 1: htb default 10
tc class add dev eth1 parent 1: classid 1:1 htb rate 50Mbit burst 3000k
tc class add dev eth1 parent 1:1 classid 1:10 htb rate 50Mbit burst 3000k
netperf -H node-0 >> shaping.txt
```

After completing all the commands, on node-1, run the following command to remove unnecessary lines from ‘shaping.txt’ output file:

```
sed '1,/^$/ d; 8,/^$/ d; 15,/^$/ d; 22,/^$/ d; 29,/^$/ d; 36,/^$/ d; 43,/^$/ d; s/\s\+/,/g' shaping.txt >> shaping-data.txt
```

The `shaping-data.txt` file will be used in the R script.
Move the `shaping-data.txt` file into the `Submit` folder in the project repository, which should already have the `policing-data.txt` file, and push your repo to bitbucket.

Install R on node-1.
To install R, please follow the guide from lab 2b. 

```
sudo su 
echo "deb http://cran.wustl.edu/bin/linux/ubuntu precise/" >> /etc/apt/sources.list
```

```
apt-get update
apt-get install r-base r-cran-rcpp
```

```
R
```

```
install.packages("codetools")
```

Select a mirror.

```
install.packages("plyr")
```

```
install.packages("MASS")
```

```
install.packages("ggplot2")
```

```
quit('no')
```

Navigate to the project directory where the R script file is run the following command:

```
Rscript PvS.R
```

The will script automatically save an graph named `PSgraph.png` of your results in your submit folder. Push the repo to your bitbucket. 
The result should look similar to this:

![sample graph](https://i.imgur.com/KT5nIiU.png)

Complete the experiment and release the resource. 

### Results:
As can be seen in OUR results, in the graph above, it appears that as the bandwidth limit rate increased, the Shaping policy did the best job at staying as close as possible to the set limit. What can also be seen from the graph is that the difference between Shaping and Policing for each set rate limit remains pretty constant throughout the experiment. This could mean that the set burst parameter of 6% could be more beneficial to Shaping and Policing, and perhaps Policing operates better at a different percentage of burst. This could have been included in our experiment, but it wouldn't be as concise and would take much longer to perform, as multiple burst values would have to be tested for every set rate value. 
