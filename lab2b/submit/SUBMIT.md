Lab 2b:  Communicating experiment results
=====================================================

Please fill in your name and net ID in the table below.

Lab Assignment | 2b -  Communicating experiment results
-------------- | --------------------------------------
Name           | Roshni Natarajan 
Net ID         | rn979
Report due     | Sunday, 9 March 11:59PM


**Inferences from Lab2 : **

The tool chosen(tinyhttpd) was not an appropriate one for the goal which was to observe the throughput of the TCP variants[YeAH, Scalable and Reno] w.r.t. bandwidth delay product 
as tinyhttpd does not measure the accurate throughput of the link.

iperf would have been a better tool for this particular goal. 

**Goal : **

To pictorially represent the throughput(calculated with the available data) of the TCP Variants(YeAH,Scalable and Reno) w.r.t bandwidth delay product. 

** Bandwidth-Delay Combinations : **

1. 500Mbps Bandwidth with 100ms, 200ms and 300ms Delays depicted by the plot `plot_500Mpbs.png`.
2. 100Mbps Bandwidth with 1ms, 2ms and 3ms Delays depicted by the plot `plot_10Mpbs.png`. 

** About the R script : **

 Since the throughput is not readily available in the data collected using tinyhttpd, the R script includes commands 
 to calculate the required throughput using the File Size and the time taken to transmit this file.
 A template which includes the Bandwidth of the link, the delay, TCP Variant and corresponding Trial number is created in order to generate a table. 
 The calculated throughput column is merged to this table. 
 This process is repeated until the data from all the processed files have been used to calculate the throughput. 
 The values of this table are utilized to create the required plot.
 
 
** The Submit folder includes : **

* R script used to create the different plots : `plot.R`.
* The Plots corresponding to 500Mbps Bandwidth`plot_500Mpbs.png` and 10Mbps Bandwidth`plot_10Mpbs.png`.
* File used to generate the initial template : `template.txt`


**References : **

* http://tryr.codeschool.com
* http://www.ceb-institute.org/bbs/wp-content/uploads/2011/09/handout_ggplot2.pdf
* http://stackoverflow.com/questions/10150579/adding-a-column-to-a-data-frame
