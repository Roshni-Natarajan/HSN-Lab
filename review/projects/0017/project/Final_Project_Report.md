Goal of the experiment

The goal of the experiment is to compare the packet processing time of the following routers:
1.XORP
2.OVS with local flow
3.Linux kernel Router

Experiment Design:

Our experiment involves a basic topology containing a client node connected to a server node through  a router. 

Varying the parameters :
 We varied the type of routers and were able to measure packet processing time for each router.
For each configuration of parameter,we ran an experiment  with 100 UDP packets(packet size 1000) flowing from client to server.This traffic was captured  at the ingress and egress interface of the router and by observing the arrival time at each interface,packet processing time for each router was calculated.Data was collected through TCPdump and analysed using R script.

Analysis plan:In R,we calculated the CDF of packet processing time for each router and by studying the CDF plot,we observe how the delay varies depending upon the traffic.

Experiment Results:
From the graphs shown below we can conclude following things: 
$$$$$$$$$$$$ OVS LOCAL FLOW $$$$$$$$$$$$$$$$$$
![ovs] (https://bytebucket.org/abhinav1586/el6383-av1586geniproject/raw/fe8a05f094aee1273b571c877049d8f74c6cb015/project/final_OVS/ovs.png?token=614fd2c6463ea8fa66d19f588f6800bce1ddc36e)

This is a graph for OVS with local flow router. It shows that almost 97 of the total packets (100) experience a very small delay (0.00003-0.00004s) ,that is,
processing time for almost 97% packets is between 0.00003s to 0.00004s. Very few packets experience th delay of 0.00050 sec to 0.00080 sec.

$$$$$$$$$$$$ Linux $$$$$$$$$$$$$$$$$

![linux] (https://bytebucket.org/abhinav1586/el6383-av1586geniproject/raw/0df8bafadf0f5d31356e5c9bce744a1d4e927258/project/final_linux/linux.png?token=df682f11422c6464335fed36d5a64d662c05082c)

From the CDF, it can easily observed that all the packets are processed within 0.00004sec. Moreover 98 out of 100 packets were processed in 0.00002 sec.

![xorp] (https://bytebucket.org/abhinav1586/el6383-av1586geniproject/raw/0df8bafadf0f5d31356e5c9bce744a1d4e927258/project/final_Xorp/abhinav_xorp.png?token=b8a1624071e448c75ef869b9c1af826fc2101ed8)

This plot shows that almost 97% of the packets were processed in 0.00003-0.00004sec. While some packet took almosst 0.0001sec to get processed.

We conducted many such trails with different number of packets with different sizes and most of the times we got the similar results.



$$$$$$$ Raw data -> Results: $

Data Analysis in R :

Log on to the GENI portal and create a new slice called lab2b-netID (using your own netID, as usual). Using Slice Jacks, request one node in this slice on your assigned aggregate (note: there are some different aggregate assignments this week, make sure to use the correct one). Name the node rstudio and request a publicly routable IP address for it (by checking the "Publicly Routable IP" checkbox). Then reserve the resource. Once your resource is ready, log in and install git: sudo apt-get update sudo apt-get install git

Then use git clone to clone a copy of your fork of the lab repository. set up a password on this individual system (since we'll be using a web interface that doesn't support key-based authentication). To set a password, run

`sudo passwd USERNAME`

where USERNAME is the username you use to log in to this resource. You should see output like Enter new UNIX password: [type password here, hit Enter] Retype new UNIX password: passwd: password updated successfully

Next, install R and R Studio. Run

`wget http://download2.rstudio.org/rstudio-server-0.98.1102-amd64.deb`

Become root with `sudo su`, then run


`gpg --keyserver keyserver.ubuntu.com --recv-key E084DAB9 gpg -a --export E084DAB9 | apt-key add -`

`echo "deb http://cran.wustl.edu/bin/linux/ubuntu precise/" >> /etc/apt/sources.list`

`apt-get update apt-get install r-base r-cran-rcpp dpkg -i rstudio-server-0.98.1102-amd64.deb` 

`echo "www-port=80" >> /etc/rstudio/rserver.conf` 

`rstudio-server restart`

Next, we'll install a couple of libraries. From the root shell prompt, run


`R`


and at the prompt, run


`install.packages("codetools")`


Choose a mirror by entering a numeric value, then let it install the package. When it's finished, install a few more:


`install.packages("plyr")`


`install.packages("MASS")` 


`install.packages("ggplot2")` 


`install.packages("reshape2")`


`quit('no')`

Log in to R Studio If you look at your slice details in the GENI portal, you should see a hostname for your resource: 

![q] (http://uppix.com/f-A0DBO4V553190600018c2d0.png)

Copy this hostname into the address bar of your browser and hit enter. You should see a screen like the following: 

![w] (http://uppix.com/f-icT5J35553191390018c2d2.png)

Log in with the same username you use to log in to the node, and the password you just set up for this username on the node. Once you're in, you should see an interface like the following:

![f] (http://uppix.com/f-nmjszdZ5531918f0018c2d3.png)

To read the .csv file generated use: 


`T1<-read.table("path to the .csv file1.csv" ,sep=":")` 

$for Xorp choose file project/final_Xorp/time1.csv
$for linux choose file project/final_linux/l1.csv
$for OVS choose file project/final_OVS/OVS5.csv

`T2<-read.table("path to the .csv file2.csv" ,sep=":")`

$for Xorp choose file project/final_Xorp/time2.csv
$for linux choose file project/final_linux/l2.csv
$for OVS choose file project/final_OVS/OVS6.csv

One thing we can see immediately is that dat does not have "friendly" column names. To assign names to the columns of T1 and T2, 
we'll save the list of columns into a variable called cnames, then apply that to the column names of T1 and T2:


`cnames<-c("date","minute","sec")`


`names(t1)<-cnames`


`names(t2)<-cnames` 


To access a particular column in a data frame, we use the $ operator.


`a=b=NULL`

`a=t1$sec` # to get t1's sec column values in a


`b=t2$sec` # to get t2's sec column values in b


`d=NULL`

###packet size strictly less than 1470

`T=Total byes you gave`   # that you gave in iperf command after -n


`N=No of bytes in each packet`  # that you gave in iperf command after -l


`I=integer(T/N)`


Use a for loop for calculating delay i.e. subtracting arrival time at egress and ingress port


`For(n in 1:I){d[n]=b[n]-a[n]}`  #we wil get a delay in d for each frame


`s=sum(c)`  


`p=NULL`


Calculating CDF


`For(n=1:i){p[n]=sum(c[1:n]/s)` #we will get a CDF values in p


Plotting the CDF


`library(ggplot2)`



`temp<-data.frame(cc,p)`


`q <- ggplot(temp)`


`q<- q + geom_point(aes(x=cc,y=p))`


`q <- q + geom_line(aes(x=cc,y=p))`


`q`

##repeat this script for each router and hence you will get three graphs. 

$$$$$  Existing experiment setup


We created three slices

1) FOR XORP

Client-ssh av1586@pc1.instageni.rnoc.gatech.edu -p 31547

Server- ssh av1586@pc1.instageni.rnoc.gatech.edu -p 31547

Router- ssh av1586@pcvm1-1.instageni.rnoc.gatech.edu

2) FOR OVS

Client-ssh kf930@pcvm2-20.genirack.nyu.edu

Server-ssh kf930@pcvm2-20.genirack.nyu.edu

Router-ssh kf930@pc2-20.genirack.nyu.edu -p 35899

3) For LINUX

Client- ssh asr471@pc2.genirack.nyu.edu -p 30522

Server - ssh asr471@pc2.genirack.nyu.edu -p 30524

Router- ssh asr471@pc2.genirack.nyu.edu -p 30523


Open two router terminal on your git bash and run tcpdump

on each of them

`sudo tcpdump –i eth1 -w file1.pcap`

`sudo tcpdump –i eth2 -w file2.pcap`

• On server run

`iperf –s -u`

• On client run
#### Very Important: Packet size strictly less than 1470 bytes (that is the value after -l).#####
`iperf –c 10.10.2.2 -u –n 100k -l 1000`  

• After the packets are transmitted,terminate tcpdump and run

the following command on the router. By executing these commands you will get 

timing information for each frame in excel format.

`tshark –r file1.pcap –Tfields –e frame.time > file1.csv`

`tshark –r file2.pcap –Tfields –e frame.time > file2.csv`

• First move the files into destination repository folder and then push the files into your repository using the following commands

`sudo mv file1.csv destination_folder`

`cd REPOSITORY_NAME`

`sudo git add folder/*`

`sudo git commit –m “message”`

`sudo git push –u origin master`

$$$$$  Setup experiment

Use your GENI account for the first time
To use GENI, you must create a GENI account and join a project. This involves a one-time account setup.
First, go to http://portal.geni.net and click on "Use GENI":

![f] (http://witestlab.poly.edu/~ffund/el6383/lab1/geni-portal-home.png)

On the next screen, you will be prompted to choose an Identity Provider. Choose "New York University" and press "Continue":

![d]  (http://witestlab.poly.edu/~ffund/el6383/lab1/geni-login-nyu.png)

Log in with your NYU NetID;

Review the policies on the next page, check both boxes, and click "Activate":

![c] (http://witestlab.poly.edu/~ffund/el6383/lab1/geni-accept.png)

Are you having trouble logging in with your NYU NetID? See Appendix A.
Once in the portal, you need to join a project. Click on the "Projects link":

![b]  (http://witestlab.poly.edu/~ffund/el6383/lab1/geni-projects.png)

You will see a list of projects. Click "Join" next to "EL6383-NYU-S2015":

![a] (http://witestlab.poly.edu/~ffund/el6383/lab1/geni-join-project.png)


After submitting your join request, on the portal homepage, you should see the oustanding join request:

![w]  (http://witestlab.poly.edu/~ffund/el6383/lab1/geni-join-outstanding.png)

After an instructor has approved your project join request, you should see the project listed under "My Projects" on your portal homepage, as follows:

![r] (http://witestlab.poly.edu/~ffund/el6383/lab1/geni-joined-project.png)

Next, you must specify SSH keys to use for logging into resources.
First, you must determine what SSH client you are using:
All Linux and Mac distributions come with a built-in SSH client. Just open a Terminal and type ssh to see the usage for the ssh command. You can also find information online on how to use the ssh command.
If you are using Windows, you will need to install an SSH client. The one that is recommended for this course is part of Git Bash. This option is most recommended because it is similar to the Mac/Linux environment (so that the commands will be the same for everyone) and because it also includes git, which you will need for this course.
In order to use GENI resources, you must set up a cryptographic key pair. The private key should be installed on your machine, and you must use it together with SSH. The public key should be installed on the GENI portal.
To set up your keys, on the GENI portal homepage, click on "Profile" in the top menu and then click on "SSH Keys":

![y]  (http://witestlab.poly.edu/~ffund/el6383/lab1/geni-portal-keypair.png)

If you already have a private/public key pair set up on your machine, you can just upload it to the GENI portal (choose "upload an SSH public key").
Otherwise, choose "generate and download an SSH keypair" and follow instructions to generate a new keypair. Download your private key, install it in an appropriate location on your machine, and make sure to use it when logging in to GENI resources. (If you are using Windows and Git Bash, this note may be helpful to you.)
Note: SSH is a standard tool, used by millions of people. If you are having a problem with SSH or SSH keys, you are probably not the first person to have that problem; please look online for an existing solution before asking for help.
Learn how to reserve, login to, and release resources in GENI
Next, you will create a slice for purposes of this lab exercise. On the portal homepage, where it shows your project memberships, click on "Create Slice":

![g]  (http://witestlab.poly.edu/~ffund/el6383/lab1/geni-create-slice.png)

Please name your slice project-netid using your individual NYU NetID, as shown in the image above. You do not need to enter a slice description.
On the page for this slice, press the "Slice Jacks (beta)" button.

![u]  (http://witestlab.poly.edu/~ffund/el6383/lab1/geni-slice-page.png)

In the window that opens, click the "Add Resources" button.

![p]  (http://witestlab.poly.edu/~ffund/el6383/lab1/geni-jacks-add.png) 

Wait for Jacks to open in editing mode, as follows:

![q]  (http://witestlab.poly.edu/~ffund/el6383/lab1/geni-jacks-editor.png)

Add resources to your canvas as follows:
Click the black VM box and drag it onto the canvas. This icon represents a virtual machine on a GENI rack.
Repeat the above step. You should now see two VM boxes on the canvas. Then drag one OF OVS router in between two VMs.

![rew] (http://uppix.com/f-Untitled5531a2210018c2e2.png)

Now click near one of the VM boxes on the canvas, then click and drag towards the router OF OVS. Release when you reach the router. You should now see a line and a box representing a network link connecting the VM and roouter.
Similarly repeat the step for another VM.

To change the name of a VM, click on the the VM box.
For the VM labeled node-0, click on the VM box and change "Name" to client. Repeat for node-1, but change the name to server. Similarly change the name of third node to router.
Next, click on the unlabeled box in the middle of the link. 
Click the "Site 0" box and select the aggregate you've been assigned from the pulldown menu. (The aggregate assignments are in Appendix B.)
The "Reserve Resources" button at the bottom of the pane should now be clickable. Click the "Reserve Resources" button near the bottom of the page.
On the next page, you may have to wait for some time before your resources are ready. Once your resources are ready, the "Status" field will say "Finished":
   
![qq]  (http://witestlab.poly.edu/~ffund/el6383/lab1/geni-resources-ready.png)

If your resource reservation request fails, try another aggregate according to the instructions in Appendix B.
Next, click on the "Slices" option in the top menu. Next to your slice, click on "Details":

![ww]  (http://witestlab.poly.edu/~ffund/el6383/lab1/geni-slice-details.png)

Then choose "Yes."
On the next page, the portal will query the aggregate you are using to find out if your resources are ready for login. When they are ready (this may take 5-15 minutes), you should see a green "READY" next to each resource:

![ee]  (http://witestlab.poly.edu/~ffund/el6383/lab1/geni-resources-ready-to-login.png)

Next to each VM, it will show you the hostname and port to use when logging in to the node.
To ssh into a VM from the command line on Linux or Mac machines, do the following (substituting the values given in the portal, and the location of your private key):
ssh USERNAME@HOSTNAME -p PORT  -i /PATH/TO/PRIVATEKEY
From a Windows machine, follow the instructions for your SSH client, using the values given in the portal.
Use SSH to log in to your client machine:

![rr]  (http://witestlab.poly.edu/~ffund/el6383/lab1/geni-ssh-client.png)

In a second terminal, log in to your server machine. Open another two windows and in both the windows log on to same router machine.


Release resources
The last thing you must do after completing your experiment is delete reserved resources so that they become available to others. In the portal, click on "Slices" in the top menu bar and choose "Delete" next to your slice name.


![tt]  (http://witestlab.poly.edu/~ffund/el6383/lab1/geni-delete-resources.png)


Appendix A
If you can't log in to the GENI Portal with your NYU NetID, you can request a login from the GENI Project Office instead. Here's how.
Visit https://shib-idp.geni.net/geni/request.html and fill out the form there:

![qw]  (http://witestlab.poly.edu/~ffund/el6383/lab1/geni-request-account.png)

Wait for an email confirming your account creation from the GENI Project Office. (This may take a couple of days.)
Once you receive the email, visit the GENI portal and click "Use GENI." When asked to choose an Identity Provider, select "GENI Project Office" and press "Continue":

![tr]  (http://witestlab.poly.edu/~ffund/el6383/lab1/geni-choose-account.png)

Log in with the GENI account you created in the previous step, and press "Continue." From now on, you will use this account every time you log in to the portal:

![re]  (http://witestlab.poly.edu/~ffund/el6383/lab1/geni-portal-login.png)

At this stage, you can return to the regular instructions and proceed from there.

Appendix B
Please use the aggregate that is assigned to you, according to the following table.
If your last name begins with...	use this aggregate:
A, B, or C	Clemson InstaGENI
D or E	Cornell InstaGENI
F, G, H, or I	Kansas InstaGENI
J, K, or L	Kentucky InstaGENI
M or N	Missouri InstaGENI
O, P, Q, or R	NYU InstaGENI
S	Northwestern InstaGENI
T, U, or V	UCLA InstaGENI
W, X, Y, or Z	Wisconsin InstaGENI
If and only if the aggregate assigned to you does not have available resources (i.e. the resource request fails), use one of the following aggregates instead:
GPO InstaGENI
Stanford InstaGENI
References
This procedure is based on the labs that have been conducted in the class.




Configuration of parameters:

a)	XORP
load this Rspec file: 
[Rspec](http://www.filedropper.com/rspec1)

Install XORP 1.8.5,on the router.The installation involved the following steps:
 
•	Install dependencies

		$sudo apt-get update 
		$sudo apt-get install libssl-dev 
		$sudo apt-get install ncurses-dev 
		$sudo apt-get install libpcap-dev 
		$sudo apt-get install g++ traceroute 
		$sudo apt-get install scons

 
•	Download XORP source files

        $cd ~/ 
		$wget http://www.xorp.org/releases/current/xorp-1.8.5-src.tar.bz2 
		$tar jvxf xorp-1.8.5-src.tar.bz2`


•	Compile and build XORP

		$cd xorp
		$scons
		$sudo scons install



b)	OVS with local flow

Load this Rspec file
[Rspec](http://www.filedropper.com/rspec1)
Following steps were involved  to  configure  OVS with local flow on router: 

1.	Login into OVS and create 2 OVS bridges. 
	
	`sudo ovs-vsctl add-br OVSbr1`
	
	`sudo ovs-vsctl add-br OVSbr2`
	
2.	Remove the IPs of dataplane interfaces as we assign them to the OVS 

     `$sudo ifconfig eth1 0`

     `$sudo ifconfig eth2 0`

3.	Attach each interfaces to its own OVS bridge.

	`$sudo ovs-vsctl add-port OVSbr1 eth1`
	
	`$sudo ovs-vsctl add-port OVSbr2 eth2`

4.	Verify the configurations by: 
	
	`$sudo ovs-ofctl show OVSbr1`
    
	`$sudo ovs-ofctl show OVSbr2`

c)	Linux kernel Router:
load this rspec File:
[Rspec](http://www.filedropper.com/rspec)

Software and metrics :
Several software tools were used in our experiment.We used iperf to generate UDP packets from client to server.Tcpdump was used to capture packets at the ingress and egress links of the router in .pcap files.We then used Tshark to to collect the arrival time field of the frame from the .pcap file and saved it in a .csv file.
The steps involved were:
•	Log  in the client and server node and install iperf 	

`sudo apt-get install iperf` 

•	Log in the router and install tcpdump and tshark

`sudo apt-get install tcpdump`
`sudo apt-get install tshark`
•	Open two router terminal on your git bash and run tcpdump
on each of them

`sudo tcpdump –i <interface-to-client> -w file1.pcap`
`sudo tcpdump –i <interface-to-server> -w file2.pcap`

•	On server run

`iperf –s -u`

•	On client run
#### Very Important: Packet size strictly less than 1470 bytes (that is the value after -l).#####
`iperf –c <server_data_interface> -u –n <byte_stream> -l <UDP_packet_size>`


•	After the packets are transmitted,terminate tcpdump and run
the following command on the router. By executing these commands you will get timing information for each frame in excel format.

`tshark –r file1.pcap –Tfields –e frame.time > file1.csv`

`tshark –r file2.pcap –Tfields –e frame.time > file2.csv`

•	move files to destination and then push the files into your repository using the following commands

`cd REPOSITORY_NAME`

`sudo git add folder/*`

`sudo git commit –m “message”`

`sudo git push –u origin master`


Data Analysis in R :

Log on to the GENI portal and create a new slice called lab2b-netID (using your own netID, as usual).
Using Slice Jacks, request one node in this slice on your assigned aggregate (note: there are some different aggregate assignments this week, make sure to use the correct one).
Name the node rstudio and request a publicly routable IP address for it (by checking the "Publicly Routable IP" checkbox). Then reserve the resource.
Once your resource is ready, log in and install git:

`sudo apt-get update`

`sudo apt-get install git`

Then use git clone to clone a copy of your fork of the lab repository.
set up a password on this individual system (since we'll be using a web interface that doesn't support key-based authentication). To set a password, run

`sudo passwd USERNAME`

where USERNAME is the username you use to log in to this resource. You should see output like
Enter new UNIX password:  [type password here, hit Enter] Retype new UNIX password:  passwd: password updated successfully

Next, install R and R Studio. Run

`wget http://download2.rstudio.org/rstudio-server-0.98.1102-amd64.deb`

Become root with sudo su, then run

`gpg --keyserver keyserver.ubuntu.com --recv-key E084DAB9` 

`gpg -a --export E084DAB9 | apt-key add -`  

`echo "deb http://cran.wustl.edu/bin/linux/ubuntu precise/" >> /etc/apt/sources.list`  


`apt-get update` 

`apt-get install r-base r-cran-rcpp  dpkg -i rstudio-server-0.98.1102-amd64.deb` 

`echo "www-port=80" >>  /etc/rstudio/rserver.conf rstudio-server restart`

Next, we'll install a couple of libraries. From the root shell prompt, run

`R`

and at the prompt, run

`install.packages("codetools")`

Choose a mirror by entering a numeric value, then let it install the package. When it's finished, install a few more:

`install.packages("plyr")`

`install.packages("MASS")`

`install.packages("ggplot2")` 

`install.packages("reshape2")` 


`quit('no')`

Log in to R Studio

If you look at your slice details in the GENI portal, you should see a hostname for your resource:

![R](http://uppix.com/f-A0DBO4V553190600018c2d0.png)

Copy this hostname into the address bar of your browser and hit enter. You should see a screen like the following:

![Rs](http://uppix.com/f-icT5J35553191390018c2d2.png)
Log in with the same username you use to log in to the node, and the password you just set up for this username on the node.
Once you're in, you should see an interface like the following: 

![rss](http://uppix.com/f-nmjszdZ5531918f0018c2d3.png)

To read the .csv file generated use:

`T1<-read.table("path to the .csv file1.csv" ,sep=":")` 


`T2<-read.table("path to the .csv file2.csv" ,sep=":")`

One thing we can see immediately is that dat does not have "friendly" column names. To assign names to the columns of T1 and T2, 
we'll save the list of columns into a variable called cnames, then apply that to the column names of T1 and T2:


`cnames<-c("date","minute","sec")`


`names(t1)<-cnames`


`names(t2)<-cnames` 


To access a particular column in a data frame, we use the $ operator.


`a=b=NULL`

`a=t1$sec` # to get t1's sec column values in a


`b=t2$sec` # to get t2's sec column values in b


`d=NULL`

###packet size strictly less than 1470

`T=Total byes you gave`   # that you gave in iperf command after -n


`N=No of bytes in each packet`  # that you gave in iperf command after -l


`I=integer(T/N)`


Use a for loop for calculating delay i.e. subtracting arrival time at egress and ingress port


`For(n in 1:I){d[n]=b[n]-a[n]}`  #we wil get a delay in d for each frame


`s=sum(c)`  


`p=NULL`


Calculating CDF


`For(n=1:i){p[n]=sum(c[1:n]/s)` #we will get a CDF values in p


Plotting the CDF


`library(ggplot2)`



`temp<-data.frame(cc,p)`


`q <- ggplot(temp)`


`q<- q + geom_point(aes(x=cc,y=p))`


`q <- q + geom_line(aes(x=cc,y=p))`


`q`
 
 
 By repeating this program for every router you will get three graphs shown above in the report. By comparing these 3 graphs we can observed which of the three routers processing time is faster.
 Our final outputs are in project/final_ Xorp, project/final_linux, project/final_OVS.