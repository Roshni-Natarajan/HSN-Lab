# Lab 2b: Communicating experiment results

This lab exercise is due on March 9 at 11:59PM. Instructions on *how* to submit are included in this README. Please read these very 
carefully, and come to [office hours](http://witestlab.poly.edu/~ffund/el6383/) if you have any questions.

Before asking any questions, please read this *entire* document. If you still believe you need help after reading the complete document, come to the lab instructor
[office hours](https://www.google.com/calendar/embed?mode=WEEK&src=ff524%40nyu.edu&color=%23B1365F).


## Preliminaries

### Overview

In this lab, we'll use R to analyze and visualize the results of your 
flow and congestion control experiment.

We're using R for two reasons:

* R is a programming language and software environment for statistical computing and graphics. It has many powerful libraries for analyzing and visualizing scientific results.
* Using R facilitates reproducibility. Your data analysis and visualization will be saved in a script (unlike, say, using Excel to create a plot). Others can look at this script to see exactly how you manipulated the data (and whether your manipulations are valid), or run it themselves. R is free and open source (unlike, say, Matlab) so anybody can install it and run your script. 

### Prerequisites

This lab assumes that you have completed the "Flow and congestion control" lab exercise and have saved your output files in the `lab2/submit` folder. You will use these output files in this lab exercise.

This lab also assumes that you have picked up basic skills related to the tools in the lab. These include:

 * Log in to the GENI portal
 * Create a slice on GENI
 * Reserve simple resources using Slice Jacks
 * Find out SSH login information for slice resources from the GENI portal
 * Access GENI resources over SSH
 * Run basic commands on the Linux shell, especially commands related to directory and file structure: `cd`, `mv`, `cp`, `ls`
 * Use git to clone a repository and add/commit/push changes to the repository
 * Release (delete) resources in a slice when you're done with them

You probably won't need to learn R (beyond the instructions in this document) to do this lab;
but if you want to, there's a [good R tutorial here](http://tryr.codeschool.com/).
You may also be interested in a quick 
[ggplot tutorial](http://www.ceb-institute.org/bbs/wp-content/uploads/2011/09/handout_ggplot2.pdf).


### Update your repository

If you visit your fork on [Bitbucket](http://bitbucket.org),
you should see a message indicating that your fork is several
commits behind the main repository (see the message
on the right side of the screen in the screenshot below):

![BB update](http://i.imgur.com/UAPCIfF.png)

If you click "Sync now" you will see a message like the following:

![BB sync](http://i.imgur.com/fkBtKMS.png)

Click "Sync" to bring your repsitory up to date with the latest
changes from mine.

(Students who have trouble with the Git workflow are encouraged
to find and read more information and tutorials online. Git is
the most popular source control used in software development,
and it's a useful tool to know in some detail.)

### A note on the instructions in this file

The instructions here tell you *how* to do certain things, 
not *what* to do. It's up to you to determine what to do. Use this page as 
a reference, not a recipe - i.e., don't try to complete this lab by 
running all of the instructions in this file sequentially.


### Collaboration policy

These labs are to be completed individually. You are allowed to 
talk to other students about the lab, but you're expected to submit your 
own work, that you would be able to reproduce independently if asked.


Here are some things that are permitted forms of collaboration:

* Clarifying misunderstandings in the background material or instructions for the lab
* Discussing or explaining the general class material
* Providing debugging assistance on Linux, using the testbed facilities, or other tools

Here are some things that are *not* allowed:

* Running the lab or answering questions in a Markdown file while logged in as someone else
* Copying (or retyping) files or parts of files with minor modifications such as style changes or minor logic modifications, even if the repository permissions are incorrectly set to allow it
* Allowing someone else to copy your work
* Getting help that you do not fully understand in order to complete a lab exercise
* Looking at the questions in the instructions, discussing the answers and approach with another student, then completing the lab separately but using an identical approach and with identical answers.

When in doubt, ask the lab instructor.


### Get and set up a resource

Log on to the GENI portal and create a new slice called 
`lab2b-netID` (using your *own* netID, as usual).

Using Slice Jacks, request *one* node in this slice on your assigned
aggregate (note: there are some different aggregate assignments this 
week, make sure to use the correct one). 

Name the node `rstudio` and request a publicly routable IP address for it (by
checking the "Publicly Routable IP" checkbox). Then reserve the 
resource.

Once your resource is ready, log in and install git:

```
sudo apt-get update
sudo apt-get install git
```

Then use `git clone` to clone a copy of *your* fork of the lab repository (*not* my copy!)

For convenience, we'll rename the `el6383-NETID` directory to `el6383` 
so that everyone will have the same file path and can just copy and past commands. 
Renaming the directory in your working copy won't affect the name of your repository 
on Bitbucket. To rename the directory, run (with your *own* Net ID)

```
mv el6383-NETID el6383 
```

Run `ls` to verify the new name.


For this lab, you'll need to set up a password on this individual system (since we'll be using a web interface that doesn't support key-based authentication). To set a password, run 

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




## Using R

### Log in to R Studio

If you look at your slice details in the GENI portal, you should see a hostname for your resource:

![hostname](http://i.imgur.com/A0DBO4V.png)

Copy this hostname into the address bar of your browser and hit enter. 
You should see a screen like the following:

![rstudio login](http://i.imgur.com/icT5J35.png)

Log in with the same username you use to log in to the node, 
and the password you just set up for this username on the node.

Once you're in, you should see an interface like the following:
![rstudio ui](http://i.imgur.com/nmjszdZ.png)

It includes a console, as well as some other sections for viewing data,
writing scripts, exploring the file system, viewing graphs, 
and viewing variables in your environment.


### Loading and using `iperf` data

If you used `iperf` to collect data in your experiment, you will have 
data files filled with lines like these:

    20150215191215,10.1.1.1,38878,10.1.1.2,5001,3,0.0-1.0,27131904,217055232

This values in each line are (in order):

 1. Timestamp
 2. Source IP
 3. Source port
 4. Destination IP
 5. Destination port
 6. Connection ID
 7. Begin interval - End interval (in seconds)
 8. Data transferred in this interval (Bytes)
 9. Measured throughput in this interval (bits/second)

We'll experiment with some different ways to analyze this data. 

I've pre-populated the repository with some sample data (in the `lab2b/sample` folder).
These instructions will describe ways of working with the sample data; 
once you've finished these instructions, though, you need 
to load and work with your own experiment data.



**Note: All the commands in this section are to be entered in the R console 
in your browser.**

To read in the iperf data, we'll use the `read.csv` function.
Run

```
dat <- read.csv("el6383/lab2b/sample/sample-iperf-1.txt")
```

This will load the `sample-iperf-1.txt` data
into a variable called `dat`.

Let's take a quick look at `dat` and see what's in it. 
To see the names of the columns of `dat` and the first few values in each 
column, run

```
str(dat)
```

You'll also see that `dat` appears in the "Environment" tab on the 
top right part of the screen. Click on `dat` in the Environment list and
it will open up a data viewer where you can browse the contents of `dat`.

One thing we can see immediately is that `dat` does not have "friendly" 
column names. To assign names to the columns of `dat`, we'll save the list
of columns into a variable called `cnames`, then apply that to the 
column names of `dat`:

```
cnames <- c("time", "srcip", "srcport", "dstip", 
            "dstport", "id", "interval", "data", 
            "tput")
names(dat) <- cnames
```

Now, when you run `str(dat)`, you'll see that the columns are labeled. 
Here, `dat` is a kind of data structure called a *data frame* (which is 
similar to a table). To access a particular column in a data frame, 
we use the `$` operator.For example, try running

```
dat$tput
```

One thing missing from our `dat` is meta-information about what it means and 
how it was collected. Let's pretend that this data was collected using TCP BIC,
over a network with capacity 500 Mbps, symmetric latency of 100 ms in each 
direction (for 200 ms total round trip delay), and it was trial number 1.
To record all this in `dat`, we'll add some columns and assign values to them:

```
dat$tcp <- "bic"
dat$capacity <- 500
dat$rtt <- 200
dat$trial <- 1
```

Look at the `dat` structure again (either with `str(dat)` or by opening it in 
the data viewer), and confirm that your new column has been added.

You can get some summary statistics about a column in a data frame. 
For example, try running

```
mean(dat$tput)
var(dat$tput)
length(dat$tput)
range(dat$tput)

```

Of course, we can only calculate summary statistics for columns that make sense; 
try running

```
mean(dat$tcp)
```

and see what happens.

Looking at one trial at a time is not very interesting. 
Let's load in another trial of this experiment and also two trials 
of an experiment with different parameters.

First, we'll save our current `dat` into another variable called
`all`:

```
all <- dat
```

Then we'll load in another trial of the same experiment into `dat`:

```
dat <- read.csv("el6383/lab2b/sample/sample-iperf-2.txt")
names(dat) <- cnames
dat$tcp <- "bic"
dat$capacity <- 500
dat$rtt <- 200
dat$trial <- 2
```

To *combine* it with the `all` data frame, we'll then run:

```
all <- rbind(all, dat)
```

Finally, let's load in two trials of another experiment - say, one with TCP CUBIC:

```
dat <- read.csv("el6383/lab2b/sample/sample-iperf-3.txt")
names(dat) <- cnames
dat$tcp <- "cubic"
dat$capacity <- 500
dat$rtt <- 200
dat$trial <- 1
all <- rbind(all, dat)

dat <- read.csv("el6383/lab2b/sample/sample-iperf-4.txt")
names(dat) <- cnames
dat$tcp <- "cubic"
dat$capacity <- 500
dat$rtt <- 200
dat$trial <- 2
all <- rbind(all, dat)
```

Note that you can only combine data frames with the same columns - 
so if you neglect to add the experiment meta data (such as TCP type, capacity, and latency)  to `dat` first, you won't be able
to use `rbind(all, dat)`.


Now, we have results from four experiment runs, of two different types, 
stored in `all`. Run `table(all$tcp, all$trial)` to see how many samples
are in each. You should see 10 or 11 sample in each trial of each TCP.

Before we proceed, we'll take some steps to manipulate the `all` data frame 
to make it more convenient to use. First of all, if you run `str(all)`, you'll
note that `tcp` is a "character" data type and `trial` is a numeric data type.
We want both of these to be categorical data types, which we can achieve by 
changing them to *factors*:

```
all$trial <- as.factor(all$trial)
all$tcp <- as.factor(all$tcp)
```

(run `str(all)` after to verify).

We'll also subdivide the `interval` column into a `begin` and `end` time.
To do this, we'll load the `reshape2` library we installed earlier,
then call a function from it:

```
library(reshape2)
all <- transform(all, interval = colsplit(interval,"-", names = c('begin', 'end')))
all$interval.begin <- all$interval$begin
all$interval.end <- all$interval$end
all$interval <- NULL
```

Now you can do e.g.

```
all$interval.begin
all$interval.end
```

Our `iperf` data includes lines from midpoint intervals in an experiment (1 second long) as well as one line in each experiment with overall data. Let's separate those into two new data frames:

```
totals  <- all[all$interval.begin<=1 & all$interval.end>=10,]
details <- all[!(all$interval.begin<=1 & all$interval.end>=10),]
```

OK, now we're ready to make some pictures. We're going to use a 
visualization library called `ggplot2`, so load it now:

```
library(ggplot2)
```

To create a plot with `ggplot`, we start by calling `ggplot` and telling 
it what data frame we want to plot. We save the `ggplot` object to a variable:

```
q <- ggplot(details)
```

Then, we use the + operator together with various "geoms" ([geometric objects](http://docs.ggplot2.org/0.9.3.1/)) to add layers to the plot.

For example, to add a layer plotting the TCP data throughput versus begin interval as points, we would run

```
q <- q + geom_point(aes(x=interval.begin, y=tput))
```

Then we could run 

```
q
```

to see the plot in the "Plots" window.

We can also add additional *aesthestics* to the plot - for example, to show the TCP variant using color, we would run

```
q <- ggplot(details)
q <- q + geom_point(aes(x=interval.begin, y=tput, colour=tcp))
q
```

You can refer to the documentation for a given *geom* to find out what aesthetics it supports. For example, [here](http://docs.ggplot2.org/0.9.3.1/geom_point.html) is the documentation for 
`geom_point`.

You can add as many layers as you like to a plot - for example, to also connect the plots from each trial with a line, you could add a `geom_line` layer:

```
q <- ggplot(details)
q <- q + geom_point(aes(x=interval.begin, y=tput, colour=tcp))
q <- q + geom_line(aes(x=interval.begin, y=tput, colour=tcp, linetype=trial))
q
```


You can save any plot to a file. For example, to save the most recent plot in q

```
ggsave("file.png", plot=q)
```

Click on the "Files" tab and you should see the file you've just created in your home directory on the node.

Of course, looking at every single data point in a scatterplot is not always very useful, or practical if we have a lot of data. Let's take a look at some useful univariate plots:

```
q <- ggplot(details)
q <- q + geom_violin(aes(x=tcp, y=tput))
q
```

and

```
q <- ggplot(details)
q <- q + geom_boxplot(aes(x=tcp, y=tput))
q
```


You can add a title and axis labels to any plot. Try adding some to the previous plot:

```
q <- q + scale_x_discrete("TCP Variant")
q <- q + scale_y_continuous("Throughput (bps)")
q <- q + ggtitle("Boxplot of TCP throughput by variant")
```

Note that we used `scale_x_discrete` for the x-axis because a non-continuous 
(categorical) variable is plotted on the x-axis, but we used 
`scale_y_continuous` for the y-axis because a continuous variable is plotted 
on that axis.



### Loading and using `tinyhttpd` data

If you used `tinyhttpd` to collect data in your experiment, you will have 
data files filled with lines like these:

```
protocol: 5
domain: experimentname
start-time: 1424558368
sender-id: 3
app-name: tinyhttpd
schema: 0 _experiment_metadata subject:string key:string value:string 
schema: 1 _client_instrumentation measurements_injected:uint32 measurements_dropped:uint32 bytes_allocated:uint64 bytes_freed:uint64 bytes_in_use:uint64 bytes_max:uint64 
schema: 2 tinyhttpd_tcp socket:int32 state:int32 ca_state:int32 last_data_sent:int32 last_data_recv:int32 snd_cwnd:int32 snd_ssthresh:int32 rcv_ssthresh:int32 rtt:int32 rttvar:int32 snd_mss:int32 rcv_mss:int32 rto:int32 ato:int32 unacked:int32 sacked:int32 lost:int32 retrans:int32 fackets:int32 total_retrans:int32 
schema: 3 tinyhttpd_peer socket:int32 ip:string port:int32 file:string 
content: text

4.034682    2   1   5   1   0   0   228 40  168 14480   31500   3000    1448    536 228000  40000   32  0   0   0   0   0
4.035314    1   1   1   0   18883   5907    12976   14345
5.007182    2   2   5   1   0   0   1204    131 168 14480   32000   3000    1448    536 232000  40000   97  0   0   0   0   0

```

We are interested in the lines of data with a '2' in the second column. The values in these lines are (in order):


 1. Timestamp
 2. Schema ID
 3. Sequence number (within a schema)
 4. Socket ID
 5. TCP state
 6. Congestion avoidance state
 7. Time since last data sent
 8. Time since last data received
 9. Send congestion window (in units of MSS)
 10. Send slow start threshold
 11. Receive slow start threshold
 12. RTT estimate in microseconds
 13. Smoothed mean deviation maximum of RTT in microseconds 
 14. Send maximum segment size (B)
 15. Receive maximum segments size (B)
 16. Retransmit timeout
 17. ACK timeout (for delayed ACKs)
 18. Unacknowledged packets
 19. Selectively acknowledged packets
 20. Lost packets
 21. Retransmits
 22. Forward acknowledged packets
 23. Total retransmits for entire connection

We'll experiment with some different ways to analyze this data. 

I've pre-populated the repository with some sample data (in the `lab2b/sample` folder).
These instructions will describe ways of working with the sample data; 
once you've finished these instructions, though, you need 
to load and work with your own experiment data.

To use the data from `tinyhttpd`, we have to do some preprocessing on it first.

I have given you a script that will do this preprocessing, *if* you have generated your data files exactly as instructed. Pass the script a list of paths to files to process, and it will generate R-readable files containing the TCP data from your experiment.

To run this script on some sample 
`tinyhttpd` results, navigate to the `lab2b` directory on your GENI node and run

```
bash tinyhttpd_processor.sh "sample/sample-tinyhttpd-1.txt" "sample/sample-tinyhttpd-2.txt" "sample/sample-tinyhttpd-3.txt" "sample/sample-tinyhttpd-4.txt" 

```

Now, if you run `ls` inside the `sample` directory, you'll see some new files:
sample-tinyhttpd-1.txt-processed.txt, sample-tinyhttpd-2.txt-processed.txt, 
sample-tinyhttpd-3.txt-processed.txt, and sample-tinyhttpd-4.txt-processed.txt.

Once you've generated these processed data files, you can start working with this data in the R console.


**Note: All the commands in this section are to be entered in the R console 
in your browser.**

To read in the `tinyhttpd` data, we'll use the `read.table` function.
Run

Run

```
dat <- read.table("el6383/lab2b/sample/sample-tinyhttpd-1.txt-processed.txt")
```

This will load the processed `sample-tinyhttpd-1` data
into a variable called `dat`.

Let's take a quick look at `dat` and see what's in it. 
To see the names of the columns of `dat` and the first few values in each 
column, run

```
str(dat)
```

You'll also see that `dat` appears in the "Environment" tab on the 
top right part of the screen. Click on `dat` in the Environment list and
it will open up a data viewer where you can browse the contents of `dat`.

One thing we can see immediately is that `dat` does not have "friendly" 
column names. To assign names to the columns of `dat`, we'll save the list
of columns into a variable called `cnames`, then apply that to the 
column names of `dat`:

```
cnames <- c("oml.ts","oml.id","oml.seq",
    "socket","state","ca.state","last.data.sent","last.data.recv",
    "snd.cwnd","snd.ssthresh","rcv.ssthresh","rtt","rttvar","snd.mss",
    "rcv.mss","rto","ato","unacked","sacked","lost","retrans","fackets",
    "total.retrans")
names(dat) <- cnames
```

Now, when you run `str(dat)`, you'll see that the columns are labeled. 
Here, `dat` is a kind of data structure called a *data frame* (which is 
similar to a table). To access a particular column in a data frame, 
we use the `$` operator.For example, try running

```
dat$tput
```

One thing missing from our `dat` is meta-information about what it means and 
how it was collected. Let's pretend that this data was collected using TCP BIC,
over a network with capacity 500 Mbps, symmetric latency of 100 ms in each 
direction (for 200 ms total round trip delay), and it was trial number 1.
To record all this in `dat`, we'll add some columns and assign values to them:

```
dat$tcp <- "bic"
dat$capacity <- 500
dat$rtt <- 200
dat$trial <- 1
```

Look at the `dat` structure again (either with `str(dat)` or by opening it in 
the data viewer), and confirm that your new column has been added.

You can get some summary statistics about a column in a data frame. 
For example, try running

```
mean(dat$cwnd)
var(dat$cwnd)
length(dat$cwnd)
range(dat$cwnd)

```


Of course, we can only calculate summary statistics for columns that make sense; 
try running

```
mean(dat$tcp)
```

and see what happens.

Looking at one trial at a time is not very interesting. 
Let's load in another trial of this experiment and also two trials 
of an experiment with different parameters.

First, we'll save our current `dat` into another variable called
`all`:

```
all <- dat
```

Then we'll load in another trial of the same experiment into `dat`:

```
dat <- read.table("el6383/lab2b/sample/sample-tinyhttpd-2.txt-processed.txt")
names(dat) <- cnames
dat$tcp <- "bic"
dat$capacity <- 500
dat$rtt <- 200
dat$trial <- 2
```

To *combine* it with the `all` data frame, we'll then run:

```
all <- rbind(all, dat)
```


Finally, let's load in two trials of another experiment - say, one with TCP CUBIC:

```
dat <- read.table("el6383/lab2b/sample/sample-tinyhttpd-3.txt-processed.txt")
names(dat) <- cnames
dat$tcp <- "cubic"
dat$capacity <- 500
dat$rtt <- 200
dat$trial <- 1
all <- rbind(all, dat)

dat <- read.table("el6383/lab2b/sample/sample-tinyhttpd-4.txt-processed.txt")
names(dat) <- cnames
dat$tcp <- "cubic"
dat$capacity <- 500
dat$rtt <- 200
dat$trial <- 2
all <- rbind(all, dat)
```

Note that you can only combine data frames with the same columns - 
so if you neglect to add the experiment meta data (such as TCP type, capacity, and latency) to `dat` first, you won't be able
to use `rbind(all, dat)`.

Now, we have results from four experiment runs, of two different types, 
stored in `all`. Run `table(all$tcp, all$trial)` to see how many samples
are in each. 

Before we proceed, we'll take some steps to manipulate the `all` data frame 
to make it more convenient to use. If you run `str(all)`, you'll
note that `tcp` is a "character" data type and `trial` is a numeric data type.
We want both of these to be categorical data types, which we can achieve by 
changing them to *factors*:

```
all$trial <- as.factor(all$trial)
all$tcp <- as.factor(all$tcp)
```

(run `str(all)` after to verify).

OK, now we're ready to make some pictures. We're going to use a 
visualization library called `ggplot2`, so load it now:

```
library(ggplot2)
```

To create a plot with `ggplot`, we start by calling `ggplot` and telling 
it what data frame we want to plot. We save the `ggplot` object to a variable:

```
q <- ggplot(all)
```

Then, we use the + operator together with various "geoms" ([geometric objects](http://docs.ggplot2.org/0.9.3.1/)) to add layers to the plot.

For example, to add a layer plotting the TCP send congestion window versus time as points, we would run

```
q <- q + geom_point(aes(x=oml.ts, y=snd.cwnd))
```

Then we could run 

```
q
```

to see the plot in the "Plots" window.

We can also add additional *aesthestics* to the plot - for example, to show the TCP variant using color, we would run

```
q <- ggplot(all)
q <- q + geom_point(aes(x=oml.ts, y=snd.cwnd, colour=tcp))
q
```

You can refer to the documentation for a given *geom* to find out what aesthetics it supports. For example, [here](http://docs.ggplot2.org/0.9.3.1/geom_point.html) is the documentation for 
`geom_point`.

You can add as many layers as you like to a plot - for example, to also connect the plots from each trial with a line, you could add a `geom_line` layer:

```
q <- ggplot(all)
q <- q + geom_point(aes(x=oml.ts, y=snd.cwnd, colour=tcp))
q <- q + geom_line(aes(x=oml.ts, y=snd.cwnd, colour=tcp, linetype=trial))
q
```


You can save any plot to a file. For example, to save the most recent plot in q

```
ggsave("file.png", plot=q)
```

Click on the "Files" tab and you should see the file you've just created in your home directory on the node.

You can look at any column in the data frame. In a study of TCP over LFNs, we are interested in the amount of data "in flight" (unacknowledged), so let's plot that:

```
q <- ggplot(all)
q <- q + geom_point(aes(x=oml.ts, y=unacked, colour=tcp))
q <- q + geom_line(aes(x=oml.ts, y=unacked, colour=tcp, linetype=trial))
q
```



Of course, looking at every single data point in a scatterplot is not always very useful, or practical if we have a lot of data. Let's take a look at some useful univariate plots:

```
q <- ggplot(all)
q <- q + geom_violin(aes(x=tcp, y=unacked))
q
```

and

```
q <- ggplot(all)
q <- q + geom_boxplot(aes(x=tcp, y=unacked))
q
```


You can add a title and axis labels to any plot. Try adding some to the previous plot:

```
q <- q + scale_x_discrete("TCP variant")
q <- q + scale_y_continuous("Unacknowledged data")
q <- q + ggtitle("Boxplot of data in flight, by TCP variant")
```

Note that we used `scale_x_discrete` for the x-axis because a non-continuous 
(categorical) variable is plotted on the x-axis, but we used 
`scale_y_continuous` for the y-axis because a continuous variable is plotted 
on that axis.


### Using your own data

The plots we have created so far were only examples, using sample data. 
Now, it's up to you to create appropriate images from *your* experiment 
given your experiment design and the data you have collected.

Follow the suggestions given in the lecture about visualizing quantitative
data, and try to make your plots as effective as possible.

When using aggregate information (such as averages), make sure to use graphic types
that show information about variance and/or 
distribution - such as box plots, violin plots, scatter plots with error bars 
showing confidence intervales (look into [geom_errorbar](http://docs.ggplot2.org/0.9.3.1/geom_errorbar.html)), 
or line plots with standard error (look into [geom_smooth](http://docs.ggplot2.org/0.9.3.1/geom_smooth.html)),


`ggplot` is a tremendously powerful and popular visualization library. The examples above should get you started experimenting with this library.
If you have a particular plot in mind that you'd like to create but you don't know how, you can usually find help and related examples online. You can also send me an email or come to my office hours.


### Creating an R script

R can be used in interactive mode (which we've been doing so far), or you can save a sequence of R commands to a file and run it from the command line.

To run an R script located in the current directory and named `myscript.R` from the command line on your GENI node, just do

```
R CMD BATCH myscript.R
```

The execution log (which shows any output that would have been printed, had you ) will be saved to a file named `myscript.Rout`, and you can view its contents using `cat`.

Create an R script that generates the image(s) you are submitting in your report. Save it as a file `plot.R` in the `lab2b/submit` folder. (It should be possible for me to create the same image you have submitted, just by cloning a copy of your repository, navigating to the `lab2b/submit` folder, and running 
`R CMD BATCH plot.R`.)



## Release slice resources

You must delete all resources in your slice at the end of your experiment.


## What to submit

Submit your R script (add it to git in the `lab2b/submit` folder).

Also, place a copy of each image in the `lab2b/submit` folder and submit those as well.


## Appendix A

Please use the aggregate that is assigned to you, according to the following table.

If your last name begins with...  | use this aggregate:
------------- | -------------
A, B, or C  | SoX InstaGENI
D or E | NYSERNet InstaGENI
F, G, H, or I  | Illinois InstaGENI
J, K, or L  | Kentucky InstaGENI
M or N  | Kettering InstaGENI
O, P, Q, or R  | NYU InstaGENI
S  | Northwestern InstaGENI
T, U, or V  | Georgia Tech InstaGENI
W, X, Y, or Z  | Wisconsin InstaGENI


If and only if the aggregate assigned to you does not have available resources (i.e. the resource request fails), use one of the following aggregates instead:

 * NYSERNet InstaGENI
 * GPO InstaGENI
