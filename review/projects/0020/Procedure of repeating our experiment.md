Procedure of Repeating This Experiment
===================
 
1. At the first beginning, you should read the "proposal.md" and the Group_Project_Report.md carefully to know the goal of this experiment as well as the method to achieve it. To get more specific information, you can read  the paper [CUBIC: A New TCP-Friendly High-Speed TCP Variant](http://www4.ncsu.edu/~rhee/export/bitcp/cubic-paper.pdf). 
      **(You should focus on experiment 3)**

2. The second step is to make the topological graph according to file" topology" and then configure latency of switches and capacity of links
    you can upload the file "cubic.xml" in your slice to get the whole topology.

3. Experiment procedure

    3.1. Set the buffer size of switches as 20% of the BDP and then run three flows of a high-speed TCP variant(for example CUBIC) over the long-RTT network path (~220ms) and three flows of long-term  TCP-SACK flows(which are used as backgroud ) over the short-RTT path (~20ms) use iperf between servers  and clients, you can get the data you want.

    3.2. Change the type of high-speed TCP four times and repeat 3.1 respectively. 

    3.3. change buffer size as 200% of the BDP, repeat 3.1 and 3.2:
     
    To make it easier, we wrote a file named "Step_by_step.md", which contains the whole step we used to complete the experiment.
    
    After doing all above, you should get 10 files. we provide the our results as reference in folder "data".
4. Once you get all the necessary data mentioned above, analyse them with R notice that each file has the data of three flows, which can not be handled directly, we figured out some sentences to separate the three flows according to their source port number. You can do config and run the "index.R" to repeat it .
  
