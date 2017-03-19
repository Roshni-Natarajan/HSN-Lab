Project Proposal for EL6383
===========================


## Project idea

Write a 1-2 paragraph summary of your project. Your summary should describe:

* What topic in high speed networks is your project related to? (Your topic should be *substantially* different from the prepared labs you've already completed - "Performance of different TCP variants over networks with a high BDP" is not an acceptable topic, for example.)
  We will study data transfer using TCP and UDP 
  
* What is the goal of your experiment? Make sure to follow best practices for setting an experiment goal, as we've discussed in class. Be as *specific* as you can. 
  You should have a narrow goal that dictates a particular experiment design, not a broad open-ended evaluation. You only have a few weeks for this project; set a realistic goal.
  
  The goal of our experiment is to transfer packets of different sizes using TCP and UDP over links 
  of different bandwidths and latencies and compare the transfer rates and time taken for transfer.  
  

## Experiment design

Describe your experiment design, including the following details (refer to lab slides for more information):

* What is the service you are going to study?
  We are studying TCP and UDP

* What metric(s) will you measure?
  We will measure 
  1) Data transfer rate of packets
  2) Throughput
  3) Time taken for transfer
  
* What parameter(s) will you vary? In what range?
  We will vary 
  1) Bandwidth – 100Mbps to 1 Gbps
  2) Latency – 0ms to 100ms
  3) Data size – 10MB to 1GB

* Describe the configuration of your experiment setting (e.g. network environment).
  Configuration will be simple and will include 2 Virtual machines - one serving as a server and one as a client
  
* What kind of "real" setting is this meant to represent? How do you know this experiment setting is representative? In what ways is your experiment setting *not* representative?
  This represents the traffic between any type of file transfer, for example getting files from a server account to your desktop
  
* What software will you use for your experiment?
  We will use 
  1) iperf - to generate TCP and UDP traffic
  2) tcpdump - to capture packets
  3) ipfw - to change and display link characteristics

* How will you collect the data from your experiment? Does the software that generates data already output in a machine-friendly format? Will you need to modify the software, or write a post-experiment processing script
  to get your data into a useful format? (Manually noting down measurements is not acceptable - your experiment data *must* be generated by a software process.)
  We are using iperf and tcpdump. This will allow us to have the output in the form of an outfile which we will later process.
   
* What kind of data analysis will you perform on your raw data?
  We will be performing quantitative data analysis of the raw data using R programming and generate graphs for the same.

* How will you test for interactions between experiment parameters?
  We will perform any runs of the experiment and then gather results to minimise any interactions.

* How will you communicate the quantitative experiment results? Sketch any visualization(s) that you expect to create at the end of your
  experiment, showing your experiment results. Obviously you don't actually *have* the results yet, but you should know what form they will take; so you can
  draw a plot with "fake" results. Upload your sketch to any image hosting service, and include it in this document.
  
  We will communicate our result as the image in the link provided:
  
  http://postimg.org/image/lgys7d1dn/
  
  Be as *specific* as you can.
