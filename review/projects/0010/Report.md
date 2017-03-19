#REPORT

##Experiment Design
The goal of this experiment is to measure the impact of varying the queue size on delay and packet loss using UDP traffic. We will be doing this by varying the queue size on an intermediate router. We intend to make a topology where of 3 VMs i.e source, destination and router; with the router VM being the intermidiate one where the queue sizes will be varied. We will be using `tc` command which is part of the netem tool which is used for network emulataion for varying the queue sizes, to create UDP traffic we will be using the iperf tool, this tool will also help us in identifying the packet loss; we will be using the ping tool for delay measurement. Using the data from the tool we will try and find a relation between the parameters and metrics which will lead us to a satisfactory conclusion. 

##Implementation of the Expeiment Design
We implemented the topology using the available Rspec file in the `GENI lab` called `GeniEdu - 09 Exploring queues`; we made sure it was ready and then proceded towards varying the parameters. We used `iperf` and `ping` to record the packet loss and delay values respectively for different queue values, the queue sizes were varied using the network emulation tool called `netem` from the iproute2 package. We use the qdisc class in the tc command to change the values of the Token Bucket Filter which is suited for slowing traffic down to a precisely configured rate. `tee` command was used to generate a text file for the output of these tools, these text files cannot be read in R. Thus, we wrote Python scripts to extract only the ping value `pingparser.py`, also the max value among them `maxdelay.py`and the number of loss packets along `Ploss.py` with the percentage loss `Plosspackets.py`. This data was plot with respect to the corresponding queue size they were observed with, thus three plots were generated `Queue Size v/s Peak Delay`, `Queue Size v/s No. of packets lost`, `Queue Size v/s Percentage of lost packet`; These plots were generated using the R script `plot2.R`. 


##Conclusion
From the plot we can infere that delay increases and packet loss decreases with respect to the queue size. We can obsereve from the ping output that intially the RTT keeps on increasing, then after reaching the peak it drops suddenly. These phenomenons can be explained by imagining a line of people trying to get through a door; Intially certain amount of people arrive to make a line, but the amount of people in the line is bounded by its size i.e in this case the queue size for packets. The first person in the line will go through fastest as compared to the arrival of people and the last will have maximum delay in getting through. Similarly, when new packets arrive, the delay keeps on increases until the last packet in the queue has reached, which has the maximum delay, then it falls as new set of packets would arrive. The Delay increases as the queue size increases because there are many packets in the queue to be processed, if there are many people in the line, longer will be the delay for the last person to get through. The packet loss decreases as the queue size increases because more number of packets can be processed and less packets will be dropped as queue size is high, if the number of people allowed to make a line is less than the number of people arrived to make it, the the extra number of people will be barred. Similiarly, when the queue size becomes smaller, the amount of dropped packets increases as they cannot be accomodated. 

![Delay vs Queue Size](http://i.imgur.com/M3L1Ybn.png)
![Packet Loss vs Queue Size](http://i.imgur.com/BLligDC.png)
![Packet Loss Percentage vs Queue Size](http://i.imgur.com/5Bchj9i.png)


##Instructions to perfom the Experiment
###Guest access instructions 
* To SSH into source `ssh guest@pc3.genirack.nyu.edu -p 36156` in the terminal. type yes then password `el6383s2015`. 
* To SSH into router `ssh guest@pc3.genirack.nyu.edu -p 36155` in the terminal. type yes then password `el6383s2015`.
* To SSH into destination `ssh guest@pc3.genirack.nyu.edu -p 36154` in the terminal. type yes then password `el6383s2015`.

Use the links below to download Python and Rscripts to your local computer 

[maxdelay.py](https://www.dropbox.com/s/w7dzemqwx2k0ihl/maxdelay.py?dl=0)  
[pingparser.py](https://www.dropbox.com/s/ostg6squ4v7q9v5/pingparser.py?dl=0)  
[ploss.py](https://www.dropbox.com/s/i18jqev4n9b0g5o/ploss.py?dl=0)  
[plosspackets.py](https://www.dropbox.com/s/qdpxox9twdzqt83/plosspackets.py?dl=0)  
[plot2.R](https://www.dropbox.com/s/u8wcppg0whj4ppu/plot2.R?dl=0) 

* Now, example all these files are saved on the Desktop in the Data folder then the following commands should be used, to change the command according to your saved destination just replace `/Users/username/Desktop/Data/filename` with your directory destination , you can use `pwd` to find your path, we will be using the following commands to transfer them to the source VM.  
* Eg :  
`sudo scp -P 36156 /Users/username/Desktop/Data/maxdelay.py guest@pc3.genirack.nyu.edu:/home/guest` then yes, then password `el6383s2015`  
`sudo scp -P 36156 /Users/username/Desktop/Data/pingparser.py guest@pc3.genirack.nyu.edu:/home/guest ` then yes, then password `el6383s2015`  
`sudo scp -P 36156 /Users/username/Desktop/Data/plosspackets.py guest@pc3.genirack.nyu.edu:/home/guest ` then yes, then password `el6383s2015`  
`sudo scp -P 36156 /Users/username/Desktop/Data/plot2.R guest@pc3.genirack.nyu.edu:/home/guest`then yes, then password `el6383s2015`


###If you do not have guest acces you can follow the steps below to setup your own slice. 
###Setting up a slice 
* Login to GENI Portal and click create slice to create a new slice. On the portal homepage, where it says project memberships, click on "Create Slice”.

* Please name your slice.You do not need to enter a slice description. On the page for this slice, press the "Slice Jacks (beta)" button.

* Click Add Resources and select choose RSpec and select existing RSpec called “GeniEdu - 09 Exploring queues” for this experiment, and any InstaGENI aggregate, then click Reserve Resources. This will create an RSpec that looks like this:  
![Topology for the Experiment](http://s2.postimg.org/4orkndt0p/PLpackets.png)

* Next, click on the "Slices" option in the top menu. Next to your slice, click on “Details”. On the next page, the portal will query the aggregate you are using to find out if your resources are ready for login. When they are ready (this may take 5-15 minutes), you should see a green "READY" next to each resource.

* When your resources have been allocated, open four SSH shells and log into the Destination node, the Router node and two instances of the Source node.

###Measuring Loss and Delay
* For this experiment we will use iperf, a utility that generates network traffic. On each node ( i.e source and destination), run the following command to instal iperf.

`sudo apt-get install iperf`

* We will be sending UDP traffic from the Source to the Destination, we will need to set up the Destination to receive UDP traffic as follows:

`iperf -s -u`     

-s for server and -u for UDP packets.

* For each of our experiments, we will be measuring two things: packet loss and packet delay. We will use our two connections to Source to measure these two things. In one source, type but do not send the following command:

`ping destination` 

This command will send out a "ping" to the Destination every second and report back its RTT (round trip time), a measurement of packet delay.  
**Note: To stop the ping command, use Ctrl-C**

* On the second Source connection, type but do not send the following command:

`iperf -c destination -u -b 20mb -t 10 &` 

This command will send the Destination node UDP traffic at a bandwidth of 20mb/s for 10 seconds. It will also report back the amount of packet loss it experiences.

* We want to start these commands back-to-back so we measure the delay occurring for the duration of the UDP traffic. Start the iperf traffic then quickly start the ping command. When the iperf command ends and returns feedback, stop the ping command by using Ctrl-C.

* In your iperf results you should see a readout similar to the one below:

 `[  3]  0.0-11.4 sec  23.8 MBytes  17.5 Mbits/sec   0.086 ms    0/17007 (0%) `

Your ping results should show a fairly consistent RTT over its duration.

* Make sure you are comfortable with this process and understand how to read the packet loss and delay from the iperf and ping results. The rest of the experiment will follow this same format.

###Throttling the Router
* In part above, we sent traffic at a bandwidth of 20mb/s and saw no loss and low delay. This is because our routers can handle much more than 20mb/s of traffic. In order to see queueing behavior, we must throttle the rate at which the intermediate router forwards traffic to be lower than the rate at which we are sending traffic. We will adjust it to send outgoing traffic at a rate of 18mb/s. Go to the Router shell and enter the following:
 
`sudo tc qdisc add dev eth1 root tbf rate 18mbit limit 1000mb burst 10kb`

* This command will change the outgoing interface to send at a rate of 18mb/s which enables a queueing behavior. In addition to the throttling the send rate, we also adjusted the limit to 1000mb and burst to 10kb. These effectively changed the size of the outgoing queue on the Router. Limit refers to how much information can we store in the queue before we begin dropping packets.  

* Now we will re-run our experiment from since we set the buffer size. In our two Source shells type, once again:

 `iperf -c destination -u -b 20mb -t 10 &`

 `ping destination`

* Run the commands back to back, manually stopping the ping (Ctrl-C) at the end of the 10 second iperf traffic. As before, there should be no packet loss. Your pings, however, should show gradually increasing delay.

###Collecting the Data 
* let's adjust the queue size to 3mb.

`sudo tc qdisc replace dev eth1 root tbf rate 18mbit limit 3mb burst 10kb` on the router shell

Note: Make sure while your adjusting the queue size  for the second time use the  following command `sudo tc qdisc replace dev eth1 root tbf rate 18mbit limit 3mb burst 10kb` and not `sudo tc qdisc add dev eth1 root tbf rate 18mbit limit 3mb burst 10kb`

If you end up using  ‘sudo tc qdisc add dev eth1 root tbf rate 18mbit limit 3mb burst 10kb’ for the second time you will get following output ‘RTNETLINK answers: File exists’. This means that the router queue length has not changed its value and still retains its previous value.
In order to change the value use this command ‘sudo tc qdisc replace dev eth1 root tbf rate 18mbit limit 3mb burst 10kb’.
‘Replace’ is the key word in order to make the change in the queue length.

* Now we'll repeat our experiment to measure packet loss and delay with our new queue size:


**Note : you can use easier file names which will be helpful later but add the extension .csv without fail**

`iperf -c destination -u -b 20mb -t 10 & | tee delay_3mb_que.csv`

`ping destination | tee packet_loss_3mb_que.csv`

* Let's adjust the queue size to 2mb.

`sudo tc qdisc replace dev eth1 root tbf rate 18mbit limit 2mb burst 10kb`

Rerun the experiment.

`iperf -c destination -u -b 20mb -t 10 & | tee delay_2mb_que.csv`

`ping destination | tee packet_loss_2mb_que.csv`

* Now let's make the queue even smaller. Adjust the limit to 1500kb (1.5mb).

`sudo tc qdisc replace dev eth1 root tbf rate 18mbit limit 1500kb burst 10kb`

Rerun the experiment.

`iperf -c destination -u -b 20mb -t 10 & | tee delay_1.5mb_que.csv` 

`ping destination | tee packet_loss_1.5mb_que.csv`

* Now let's make the queue even smaller. Adjust the limit to 1000kb (1mb).

`sudo tc qdisc replace dev eth1 root tbf rate 18mbit limit 1000kb burst 10kb`

Rerun the experiment.

`iperf -c destination -u -b 20mb -t 10 & | tee delay_1mb_que.csv`

`ping destination | tee packet_loss_1mb_que.csv`

* Now let's make the queue even smaller. Adjust the limit to 500kb (0.5mb).

`sudo tc qdisc replace dev eth1 root tbf rate 18mbit limit 500kb burst 10kb`

Rerun the experiment.

`iperf -c destination -u -b 20mb -t 10 & | tee delay_0.5mb_que.csv`

`ping destination | tee packet_loss_0.5mb_que.csv`

* Now let's make the queue even smaller. Adjust the limit to 100kb (0.1mb).

`sudo tc qdisc replace dev eth1 root tbf rate 18mbit limit 100kb burst 10kb`

Rerun the experiment.

`iperf -c destination -u -b 20mb -t 10 & | tee delay_0.1mb_que.csv`

`ping destination | tee packet_loss_0.1mb_que.csv`

###Generating the plots 
After generating CSV files:

* Run `pingparser.py` on your terminal. Using `python pingparser.py`  
It will ask filename, just type the .csv filenames without space and without extension .csv 
for eg : `filenamedelay_0.5mb_que` Do this for all the delay .csv files which have been generated. Therefore you will get 6 new files with the same name but with .txt extension.

* Now run `maxdelay.py` using `python maxdelay.py`, it will ask the for filename 6 times, where you have to enter the .txt filenames which have been generated previously.  
for eg : `filenamedelay_0.5mb_que` then enter, then again  
This will generate a delay.txt file 

* You can now run `ploss.py` using `python ploss.py` and `plosspackets.py` using `python plosspackets.py` the same way and input the filename of the Packet loss .csv files for both of them. 
They will generate two separate txt files : plosspackets.txt and plosspercentage.txt.

**Note: If the .csv files and the .py files are in different location then instead of filename you have to type the whole location**

* To use these files to plot the graph we need to install R, we need to follow the steps below :   
 

```
wget http://download2.rstudio.org/rstudio-server-0.98.1102-amd64.deb
```

Become root with `sudo su`, password `el6383s2015` then run 

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

* Then run the R script using the command `Rscript plot2.R` this will generate 3 png files which are our final graphs. 
* To view these files download them to your local filesystem, using the following commands : 
`sudo scp -P 36156 guest@pc3.genirack.nyu.edu:/home/guest/delay.png /Users/username/Desktop/`  
`sudo scp -P 36156 guest@pc3.genirack.nyu.edu:/home/guest/PLpackets.png /Users/username/Desktop/`  
`sudo scp -P 36156 guest@pc3.genirack.nyu.edu:/home/guest/PLpercentage.png /Users/username/Desktop/`  

* `/Users/username/Desktop/` can be replaced with any local directory you want to save it to. 

###If using your own slices changes required in the Rscript plot2.R
**Note : The Rscript will run assuming you are using the slice which we have used, incase you are using your own slice in the plot2.R you need to replace some lines which are give below :**

1. First navigate to the directory containing the files `delay.txt`, `plosspackets.txt` and `plosspercentage.txt`. enter `pwd` this will give you the output say : `x`.
consider if x = /users/netid we will have `maxdelay <- read.csv("/users/netid/delay.txt", header=F)$V1 `
 
2. Now open the `plot2.R` file replace the lines as shown below :  
   maxdelay <- read.csv("/users/rif217/delay.txt", header=F)$V1 **With** 
   maxdelay <- read.csv("x/delay.txt", header=F)$V1 
   
   packetslost <- read.csv("/users/rif217/plosspackets.txt", header=F)$V1 **With**  packetslost <- read.csv("x/plosspackets.txt", header=F)$V1
   
   packetslost <- read.csv("/users/rif217/plosspercentage.txt", header=F)$V1 **With** packetslost <- read.csv("x/plosspercentage.txt", header=F)$V1
   
   









