$ Raw data -> Results: $

to run the experiemnt, 

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

`apt-get update apt-get install r-base r-cran-rcpp dpkg -i rstudio-server-0.98.1102-amd64.deb echo "www-port=80" >> /etc/rstudio/rserver.conf rstudio-server restart`

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


`T1<-read.table("path to the .csv file2.csv" ,sep=":")`

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

