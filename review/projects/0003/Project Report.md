# **Project Report**
## **Introduction:**
	In this project, a dumbbell network topology is chosen with a common LFN link between the two routers.
	Client side of the network has 3 clients, two of them send competing TCP flows and one UDP interruption flow. 
	Server side has corresponding 3 servers.
	The performance of each comepting TCP flow is studied and compared with the other (by observing throughput and resilience time)
	when interrupted by a burst of dominating protocol like UDP.

## **Project Goal:**
	The goal of this project is to observe throughput and resilience time of two competing TCP variants when interrupted
	by a burst of dominating protocol like UDP.

## **Parameters & Metrics:**
	As we are studying the performance of each comepting TCP flow when interrupted by a burst of dominating protocol 
	like UDP. We wil observe the following metrics :

	* Throughput
	* Reslience Time

	And as we are studying competing TCPs we would change the following parameters :

	* TCP Variant

	Note: We will keep TCP highspeed as fixed and change other variants to study the competing TCP flows under the influence of UDP

## **Project Application:**
	By doing this experiment we are basically creating a network environment that mimics the scenerio of the network traffic 
	being interrupted by massive tcp flows, like FTPs.
	For this matter we introduce a UDP burst in our network traffic.
	The throughput data will be comapred with the data from other flows in a comparative environment such as a graph of throughput
	of competing TCP variants over time.
	We have chosen this visualization because it gives a good idea of the throughput variation with time, and also the resilience 
	time of the flow. 

## **Project Implementation:**
	In this section we give a basic summary of project implementation. The steps to reproduce the projects are given seperately in
	detail later in this report.
	We are using GENI Portal for the implementation of this project. Following steps are performed to implement the project
	* First we reserve resources using RSPEC file. The rspec file creates a dumbell topology
	* Then we login to our resources and run the configuration files to configure all the clients and nodes for libraries and
	correct TCP variants. 
	* After configuring all the nodes, we start the transmission on client1 and client 2 and once they have established a stable 
	thoroughput we interrupt the flow
	  by a massive UDP burst. This is to disturb the stable flow and study their response to the interruption
	* All of the Iperf data is stored in text file, which is used by Rstudio (R files) to genereate .png files. These png files 
	are a graph of throughput w.r.t time of 
	  competing TCP flows under UDP interruption influence. 
## **Observation of Results:**
	We measured the throughput of the standard TCP variant Highspeed (on client1) with different TCP variants- Cubic, Reno and Scalable (on Client2) under the interruption on UDP packets(on client-UDP), sent at 60 Mbps.

	First, we measured and compared the throughput of Highspeed and Cubic under the influence of UDP packets.
	
[hs-cubic](http://imgur.com/rvpESGh)
	
	From the graph, we observe that Cubic has higher throughput than Highspeed, but when UDP interrupts, throughput of both drops down.
	We can also observe Cubic has better resilience time than Highspeed.

	Secondly, we measured and compared the throughput of Highspeed and Reno under the influence of UDP packets.
	
[hs-reno](http://imgur.com/SWdKY4h)
	
	From the graph, we observe that Reno has higher throughput than Highspeed, but when UDP interrupts, throughput of both drops down.
	We can also observe that Reno has better resilience time than Highspeed.

	Third, we measured and compared the throughput of Highspeed and Scalable under the influence of UDP packets.
	
[hs-scalable](http://imgur.com/vrWsu9C)
	
	From the graph, we can observe that Scalable has higher throughput than Highspeed, but when UDP interrupts, throughput of both drops down. 
	We can also  observe that Highspeed has better resilience time than Scalable.

	NOTE : 
	We also constructed 7 graphs, showing throughput of a single TCP variant on a separate graph.
	So, we have 3 graphs for Highspeed throughput wrt time under the influence of Cubic, Reno and Scalable with UDP.
	3 graphs for Cubic, Reno and Scalable throughput under the influence of Highspeed and UDP.
	1 graph for UDP throughput with respect to time.
	
## ** Reproducing the Experiment:**

	1.Log in to GENI and reserve the resources by using the provided resource specification file.
	The rspec can be found at the link : 
	
[Rspec](https://bitbucket.org/wizmehta/el6383-project-vsm263-tt1164-kn1042/downloads/rspec.xml)

	 # choose your appropriate aggregate

	2. There are 3 nodes at the client side. 
	Client 1 runs high speed
	client 2 runs cubic/reno/scalable variant
	client_udp is used to provide the udp interruption. 

	Similarly there are 3 nodes at the server side, each providing the server side data for the respective TCP variant and UDP.

	At each one of the 6 nodes, clone a copy of your Bitbucket repository. Then move the folder containing this project:
	**Note: Only client and server nodes should be logged into**
	sudo su
	apt-get update
	apt-get install git
	git clone [put the URL of your fork of the lab repository here]
	mv el6383* el6383
        mv el6383/review/projects/0003 project

	3. There are shell scripts inside folder project that are used to setup the configuration of each node.
	They can be found under the name “[nodename]_[tcpvariant].sh”

	navigate into the folder project and
	 At client1, run 
	sh client1_highspeed.sh
	at client2, run
	sh client2_cubic.sh
	at client-udp, run
	sh client_UDP.sh

	at server1, run
	sh server1_highspeed.sh
	at server2, run
	sh server2_cubic.sh
	at server-udp, run
	sh server_UDP.sh

	4. To execute the experiment, queue up the commands at both clients (1 & 2) and try to run them simultaneously. 
	At 30 seconds into the experiment, from the UDP node, run the UDP interruption.

		At client1, run
		sh client_hs_cubic_exe.sh
		At client2, run
		sh client_cubic_exe.sh

		At client-udp, run at 30 seconds
		sh UDP_interruption_exe.sh

	5. Setup and run separately for each variant. 
	Repeat step 3 (configuration) once for each TCP variant.

	at client2, run
	*for reno*, 
	sh client2_reno.sh

	*for scalable*,
	sh client2_scalable.sh


	Repeat step 4 (execution) once each for the different TCP variants.
		*for reno*
	At client1, run
		sh client_hs_reno_exe.sh
	At client2, run
		sh client_reno_exe.sh

	At client-udp, run at 30 seconds
		sh UDP_interruption_exe.sh

		*for scalable*
	At client1, run
		sh client_hs_scalable_exe.sh
	At client2, run
		sh client_scalable_exe.sh

	At client-udp, run at 30 seconds
		sh UDP_interruption_exe.sh


	# For each TCP variant, the Configuration and execution.

	6. Move the .txt files in each node into the appropriate folder 

	At client1*, run
		’mv *.txt client1testoutputs
	*At client2*, run
		mv *.txt client2testoutputs
	*At client-udp*, run at 30 seconds
		mv *.txt udptestoutputs


	7. Push the files from each node and sync them across the nodes.

	*At client-udp,*
		git add *
		git commit -m “commit message” 
		git push -u origin master

	*At client2,*
		git pull
		git add *
		git commit -m “commit message” 
	git push -u origin master

	*At client1, *
		git pull
		git add *
		git commit -m “commit message” 
		git push -u origin master

	8. In Client1, install R
		sh install_R.sh

	9. Log into R and install the necessary libraries. 
	R
	install.packages(“codetools”)
	install.packages(“plyr”)
	install.packages(“MASS”)
	install.packages(“ggplot2”)
	install.packages(“reshape2”)
	quit(‘no’)

	10. go to directory Rscripts and run the script titled finaltest.R
		cd Rscripts
		R CMD BATCH finaltest.R
	# individual pngs can be generated by running the respective .R scripts in this folder.
	The output png images can be viewed in this folder.

	11. Push the changes to view the files in the bitbucket.
		git add *
		git commit -m “commit message”
		git push -u origin master


