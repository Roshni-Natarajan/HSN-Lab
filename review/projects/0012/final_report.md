Project Report for EL6383
=============================


## Project explanation

Our project is related to Stochastic Fair Queue (SFQ) in scheduling. SFQ is a data packet scheduling implemented on Linux kernels.
It allows approximately fair allocation of bandwidth among flows.

The goal of our project is to study the effect of SFQ under a situation where a small data flow is competing with a large data flow in a network. 
We conducted our experiments in two different network environment. One was with 100Mbps bandwidth and the other one was with 1Mbps bandwidth. In each network environment,
we compared the performance of the application generating small data flows when SFQ was on and off.The metrics to measure the performance was latency.
Specially, when SFQ was off, the router was using the default queuing method which was a first-in-first-out queuing. 
 

The network topology of our experiment is as following:
![](https://lh6.googleusercontent.com/-1HI3b_CXYew/VTGKgzYdTDI/AAAAAAAAAAs/39oCChnCFZg/w1314-h564-no/topology.png)

We used `iperf` in our experiment as a tool to generate large data flows from *server* to *client*.
`ping` was used to evaluate the delay of small data flows from *client* to *server*. The output of `ping` was redirected to files as raw data.

In order to have a fair comparison between the performance when SFQ is on and off, and for the consideration of the possible interaction between the two parameters,
we set four experiment units for our project. Each was tested for four times. Raw data files can be found in *data* directory. 

| Unit No.| Unit Name | SFQ status | Bandwidth of each link | Data files name |
|:-------:|:---------:|:----------:|:----------------------:|:----------------|
|1        |off1m      |off         | 1 Mbps                 |off1m_1, off1m_2, off1m_3, off1m_4|
|2        |on1m       |on          | 1 Mbps                 |on1m_1, on1m_2, on1m_3, on1m_4    |
|3        |off100m    |off         | 100 Mbps               |off100m_1, off100m_2, off100m_3, off100m_4|
|4        |on100m     |on          | 100 Mbps               |on100m_1, on100m_2, on100m_3, on100m_4    |

`R studio` was used to perform data processing, data analyzing and data visualizing. The average delay and the delay changing over time are the two main aspects we inspected. 

For each network we created two visualizations. One was a dotplot of delay related to time. One is a violinplot of delay. 
As a summary of all the experiment units, we had a barplot of the average delay in each experiment unit. The files of the visualizations can be found in *plot* directory.



##Experiment results

Based on the data we got, we generated five plots to display our finding. 


![](https://bytebucket.org/zfyi/project-el6383/raw/a9930dc21a30d73ed8fb471f239a3ab1da14d0a0/plot/all1m_mean%26sd.png)

![](https://bytebucket.org/zfyi/project-el6383/raw/0c14739a69f7278fecc068cdbf2dcad9326cbc48/plot/all1m_violin.png)

![](https://bytebucket.org/zfyi/project-el6383/raw/a9930dc21a30d73ed8fb471f239a3ab1da14d0a0/plot/all100m_mean%26sd.png)

![](https://bytebucket.org/zfyi/project-el6383/raw/a9930dc21a30d73ed8fb471f239a3ab1da14d0a0/plot/all100m_violin.png)

![](https://bytebucket.org/zfyi/project-el6383/raw/03bbe802b999d0bd991553e8e54dbafd999b110b/plot/b_all_bar.png)

As we can see in the plots, there is not a significant difference in latency between the case where SFQ is on and SFQ is off, and the case where
it is in a large bandwidth environment or small bandwidth environment.

Also there is not any significant evidence showing that bandwidth and scheduling variants have interaction.

As a conclusion, we will say that SFQ does not have any better performance than the default scheduling method in network traffic control.






## Instruction for reproduce the experiment



### Setting up experiment


A preconfigured environment is provided below. To access the prconfigured environment, just login in the VMs by the following links. Password is "el6383s2015".

**server node for 100m environment:**guest@pc1.lan.sdn.uky.edu -p 32316

**router node for 100m environment:**guest@pc1.lan.sdn.uky.edu -p 32315

**client node for 100m environment:**guest@pc1.lan.sdn.uky.edu -p 32314

**server node for 1m environment:**guest@pc1.instageni.wisc.edu -p 35132

**router node for 1m environment:**guest@pc1.instageni.wisc.edu -p 35131

**client node for 1m environment:**guest@pc1.instageni.wisc.edu -p 35130



A new environment for this experiment can be configured by the following steps.


**Step1: Add a resource**

Create two new slices (referred as slice-1 and slice-2) and click the “add resource” button. 
Add the resource by scrolling down to where it says "Choose RSpec." 
Select the "File" option and then upload the file in *script* directory (load the file 100m.rspec on slice-1 for the large bandwidth experiment. Load the file 1m.rspec on slice-2 for small bandwidth experiment). After choosing the file, remember choose the suitable aggregate. Then click “Reserve Resource”.

**Step2: Preparation**

Log into the *server*, *client* and *router* nodes in GENI. Type `sudo apt–get install iperf` in *server* and *client* windows to install the software we need and ready for the experiment. In *server* window, run `iperf –s` to start a server. In *client* window, run `iperf –c server` to check the link capacity.




### Conducting experiment

After accessing a well-configured environment, Raw data can be generated and collected raw data by the following steps.



**Step3: Experiment without SFQ**

Open one more terminal to log into the *client* node. Now there will be two *client* windows, one is used as a user who was downloading with hug bandwidth, we call it client-d. The other one as a host, we call it client-h. 
First, type `iperf –s` in *server window* to listen on TCP. Than type `iperf –c server –t 240 –b “bandwidth” (et. replace “bandwidth” with 100mb or 1mb)` in *client-d* window to connect to the server with 240 seconds. After this, type `ping –c 120 server > “file name”` in *client-h* window to save the results. Repeat this step 3 more times with different filenames to collect enough data.



**Step4: Experiment with SFQ**

First, add the SFQ to the router. In *router* window, type `ifconfig` to check interfaces in the host.
For each of the two interfaces with IP address 10.1.X.X, type `sudo tc qdisc add dev "interface" root sfq perturb 10` to add SFQ into the interface in the router.
You will see the following screen shot by `tc qdisc` if SFQ is active in both interfaces.
![](https://lh5.googleusercontent.com/-_XtrU-f_stc/VTGKgUdBIYI/AAAAAAAAAAo/B3YYn6yq4k0/w1193-h89-no/tcqdisc.png)

After adding the SFQ, repeat **step3** for four times with different filename to save the data.



**Step5: Removing SFQ**

After finishing all the experiments, remove SFQ in both interfaces in *router* by typing `sudo tc qdisc del dev "interface" root`.




### Analyzing Data

We will use `R-studio` to perform data processing and data analysis. Following steps show how to setup an R server and perform data processing.



**Step6: Get and set up R**

First, reserve an one-node resource on GENI. Name the node `rstudio` and request a publicly routable IP address.

Once your resource is ready, log in and install git:

```
sudo apt-get update
sudo apt-get install git
```

Then use `git clone` to clone a copy of the repository containing raw data files. 


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




**Step7 Use R**


First we need log into R studio. Copy your hostname, which at your slice details in the GENI portal, 
into the address bar of your browser and hit enter. Log in with the same username you use to log in to the node
and the password you just set up for this username on the node.

Then, create a new R-script in your working environment. Copy and paste the code in Plot.R provided in *script* directory. 

Next, locate all the `read.csv` functions (totally 16 locations) and change the filename in the first argument to the actual path to data files. (If you use this repository as the clone repository, the origin paths should be valid and this step can be skipped.)

Finally, run the R-script just created. If all the pathname for data files are correct, five plots as shown above will be generated and saved.
