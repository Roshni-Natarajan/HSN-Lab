# Lab 2: Flow and congestion control

This lab exercise is due on 2/22 at 11:59PM. Instructions on *how* to submit are
included in this README. Please read these very carefully, and come to
[office hours](http://witestlab.poly.edu/~ffund/el6383/) if you have difficulty.

Before asking any questions, please read this *entire* document
and the entire SUBMIT.md. If you still
believe you need help after reading the complete document, come to the lab instructor
[office hours](https://www.google.com/calendar/embed?mode=WEEK&src=ff524%40nyu.edu&color=%23B1365F).


## Preliminaries

### Prerequisites

This lab assumes that you have completed the "Hello GENI" lab exercise and are comfortable with the techniques practiced in that lab exercise. These will be used in this lab, but won't be explained in detail; you're expected to remember how to do them.

These include:

 * Log in to the GENI portal
 * Create a slice on GENI
 * Reserve simple resources using Slice Jacks
 * Find out SSH login information for slice resources from the GENI portal
 * Access GENI resources over SSH
 * Use `ifconfig`, `ping`, and `iperf`
 * Identify the control and data interfaces on a GENI resource,
 understand the difference between them, and know which to use for experimental traffic.
 * Release (delete) resources in a slice when you're done with them

### A note on the instructions in this file

Unlike the previous exercise, the instructions here tell you
*how* to do certain things, not *what* to do. It's up to you
to determine what to do.
Use this page as a reference, not a recipe - i.e., don't
try to complete this lab by running all of the instructions in
this file sequentially.



### Collaboration policy

These labs are to be completed individually. You are allowed to talk to other students about the lab, but you're expected to submit your own work, that you would be able to reproduce independently if asked.


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


## Lab overview

Your assignment is to design and execute a *simple* experiment
to study a TCP congestion control algorithm designed for "long fat networks"
(LFNs, i.e. networks with a large bandwidth-delay product).

Specifically, you must design an experiment that yields meaningful conclusions about:

* The performance of your selected TCP variant compared to another, significantly different, TCP variant designed for LFNs, as evaluated over a link that is representative of a LFN
* The performance of your selected TCP variant compared to a TCP
variant *not* designed for LFNs, as evaluated over a link
that is representative of a LFN.
* The performance of your selected TCP variant compared to another, significantly different, TCP variant designed for LFNs, as evaluated over a link that is *not* a LFN
* The performance of your selected TCP variant compared to a TCP
variant *not* designed for LFNs, as evaluated over a link
that is *not* a LFN

However the specific details of your experiment (Which TCP variants?
What kind of characteristics should the link have? What parameters
should you vary? What metrics should you measure?) are up to you.

Note that the object of this lab is to demonstrate that
you can design and execute a meaningful, efficient experiment.
An experiment that indiscriminately uses **every possible metric**
and **every possible parameter** is *not* a good experiment. A
good experiment has a clearly defined, specific, goal with a narrow scope,
and takes just enough measurements to achieve that goal.

Read the `lab2/src/SUBMIT.md` file before proceeding, to get a
better understanding of what is expected from you in this lab exercise.

Some general instructions are given in the next few subsections.

### Slice creation

Log in to the [GENI portal](https://portal.geni.net/) and create a
slice named **lab2-netID** (substituting your own NYU Net ID).

Use this slice for the entire lab 2. Don't create a new slice
when you need different resources, just keep deleting and adding resources
to the *same* slice.

You'll reserve resources using an RSpec file that defines the capacity
of the link between client and server; details follow later in this document.

### Make an experiment plan

Read this entire document, then decide exactly what experiments you need
to run.

Every configuration of parameters you will run constitutes a single **experimental
unit**. For example, if you run

 * Four experiments with `cubic`, a network capacity of 500Mbps, and a delay of 100ms
(with all other parameters set to default)
 * Four experiments with `cubic`, a network capacity of 500Mbps, and a delay of 50ms
(with all other parameters set to default)
 * Four experiments with `highspeed`, a network capacity of 500Mbps, and a delay of 50ms
(with all other parameters set to default)

then you have three experimental units.

Give each experimental unit a name and enumerate what configuration
it describes in your SUBMIT.md (question 6).

### Test each experimental unit to make sure settings are applied

Every time you start running experiments for a new experimental unit,
test to make sure that the parameters you *think* you have set are applied.
(Details on testing are included in the intructions on setting parameters.)

### Store data from several trials for each experimental unit


On your resources, you should clone a copy of your git repository.
First

    sudo apt-get install git

then

    git clone https://URL/OF/YOUR/FORK

where `URL/OF/YOUR/FORK` is the URL shown in Bitbuck for your
individual fork:

![BB url](http://i.imgur.com/NdahOl2.png)

For each experimental unit, run several trials. Store the results of
each trial using meaningful file names that include the name of the
experimental unit and an trial identifier.
(For example: `cubic-500M-100m-1`, `cubic-500M-100m-2`, etc.)


After each experiment trial, move the data file
to the 'lab2/submit' folder inside this working copy of your repository.
(Use the `mv` command to move files - you can learn more about its usage
online or with `mv --help`.)

Then run (from inside the repository, use `cd` to navigate the filesystem):

    git add lab2/submit/*
    git commit -m "Added data from ...."  # insert details in the commit message
    git push -u origin master

to save your data file to Bitbucket. Verify on the Bitbucket
web interface that your file appears there. If you are having trouble
with git, you can learn more about its usage online; it's a very
popular tool.


### Release slice resources

You must delete all resources in your slice at the end of your experiment.

## Available parameters

As an experimenter, you may vary several parameters in your
experiment. The most important of these are explained here.

Note: many of these commands require root (administrative)
privileges to run. Instead of using `sudo` with each command
(which will run it with root privileges), we suggest you instead
"become" root by running `sudo su`. Then, your terminal prompt
will change from a `$` to a `#` and any commands you run
will be run with root privileges.

There are other relevant parameters that are *not* described here. You may use other parameters you already know about or
learn about online, but you must document them (with sources)
in your lab report.


### Link capacity

In this experiment, we'll be varying link capacity at resource
reservation time. We'll do this using an RSpec file, which (you'll
recall from the first lecture) is an XML file that describes the
resources requested for an experiment.

In this repository, you'll see a file called `rspec.xml`. Its
contents are:

```
<rspec xmlns="http://www.geni.net/resources/rspec/3" xmlns:emulab="http://www.protogeni.net/resources/rspec/ext/emulab/1" xmlns:tour="http://www.protogeni.net/resources/rspec/ext/apt-tour/1" xmlns:jacks="http://www.protogeni.net/resources/rspec/ext/jacks/1" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.geni.net/resources/rspec/3    http://www.geni.net/resources/rspec/3/request.xsd" type="request">
  <node xmlns="http://www.geni.net/resources/rspec/3" client_id="client">
    <icon xmlns="http://www.protogeni.net/resources/rspec/ext/jacks/1" url="https://portal.geni.net/images/VM-noTxt-centered.svg"/>
    <site xmlns="http://www.protogeni.net/resources/rspec/ext/jacks/1" id="121"/>
    <sliver_type xmlns="http://www.geni.net/resources/rspec/3" name="default-vm"/>
    <services xmlns="http://www.geni.net/resources/rspec/3"/>
    <interface xmlns="http://www.geni.net/resources/rspec/3" client_id="interface-0">
      <ip xmlns="http://www.geni.net/resources/rspec/3" address="10.1.1.1" type="ipv4" netmask="255.255.255.0"/>
    </interface>
  </node>
  <node xmlns="http://www.geni.net/resources/rspec/3" client_id="server">
    <icon xmlns="http://www.protogeni.net/resources/rspec/ext/jacks/1" url="https://portal.geni.net/images/VM-noTxt-centered.svg"/>
    <site xmlns="http://www.protogeni.net/resources/rspec/ext/jacks/1" id="121"/>
    <sliver_type xmlns="http://www.geni.net/resources/rspec/3" name="default-vm"/>
    <services xmlns="http://www.geni.net/resources/rspec/3"/>
    <interface xmlns="http://www.geni.net/resources/rspec/3" client_id="interface-1">
      <ip xmlns="http://www.geni.net/resources/rspec/3" address="10.1.1.2" type="ipv4" netmask="255.255.255.0"/>
    </interface>
  </node>
  <link xmlns="http://www.geni.net/resources/rspec/3" client_id="link-0">
    <interface_ref xmlns="http://www.geni.net/resources/rspec/3" client_id="interface-0"/>
    <interface_ref xmlns="http://www.geni.net/resources/rspec/3" client_id="interface-1"/>
    <property source_id="interface-0" dest_id="interface-1" capacity="100000" />
    <property source_id="interface-1" dest_id="interface-0" capacity="100000" />
  </link>
</rspec>

```
This RSpec defines an experiment topology *almost* identical
to the one we used in the first lab experiemnt. However,
note the lines near the bottom that have a `capacity="100000"` in them. These lines define the capacity on the link
between the server and client (in kbps). By editing these lines, you can change the requested capacity. (Note that the capacity is set independently in each direction.)

To use this RSpec, save it to a file. In the Slice Jacks editor,
instead of adding elements to the canvas directly, scroll down to where it says "Choose RSpec." Select the "File" option and then upload your file:

![Rspec from file](http://i.imgur.com/haZb6rr.png)

You should immediately see the "This RSpec is valid" message. If
you scroll up now, you should see some elements on the canvas.

You're not finished, though. Scroll back to the cavas, click on the box with the number on it, and set it to your assigned aggregate.

![Select site](http://i.imgur.com/TlrUYLG.png)

Now, when you scroll back down, the RSpec should be shown to be
"valid and bound" and the "Reserve Resources" button should
be clickable.


![Valid and bound](http://i.imgur.com/Qkjz2Cl.png)

When you log on to these resources, you should use `iperf` to test that
the actual capacity of the link is what you expect it to be.
(You learned how to measure link throughput with `iperf` in the previous lab.)

Note that each time you vary link capacity, you will delete your
reserved resources and reserve new ones. Plan the order of your
experiment trials to minimize the number of times you need to
change link capacity.


### Link latency

To emulate latency on a link, we'll use a tool called `netem`.

To try it out, you'll run a command on the resource using
the following syntax

    tc qdisc add dev IFNAME root netem delay DELAYms JITTERms

where `IFNAME` is the name of the data interface,  `DELAY` is the amount of average latency you want to add in milliseconds, and `JITTER` is the amount of variation in
latency you want to add in milliseconds.

For example, to add 100ms of latency with 10ms of jitter
to outgoing packets on eth1, you would run

    tc qdisc add dev eth1 root netem delay 100ms 10ms


Note that the delay here applies to *outgoing* packets on
that interface only, not *incoming* packets. Therefore, if you
want to create symmetric delay, you need to run this command
on both server and client. Also, realize that the total round trip
time between server and client will be the sum of outgoing delay
on the server, outgoing delay on the client, and "real" (not
emulated) latency on the link.

To remove the emulated latency on an interface, run

    tc qdisc del dev IFNAME root

where `IFNAME` is the interface name.

After changing this parameter, use `ping` to verify that you see the expected
latency on the link. (You learned how to use `ping` in the previous lab.)

### TCP variant

Several TCP congestion control variants come built-in
to the Linux kernel. The TCP variants that are currently available may include `cubic`, `bic`, `highspeed`, `hybla`,
`htcp` (Hamilton or H-TCP), `illinois`, `lp` (low priority), `reno`, `scalable`, `vegas`, `veno`, `westwood`, and
`yeah`.

Some of these (such as `highspeed`, `yeah`, and `scalable`), were designed specifically for use on networks
with a high bandwidth-delay product. Others are general-purpose
congestion control variants (`reno` and `veno`)
or are meant for use on other, specific kinds of
networks (i.e. `veno` on wireless networks with random
  packet loss, `hybla` for satellite networks).



To activate a particular TCP variant, run

    modprobe tcp_VARIANT

then

    sysctl -w net.ipv4.tcp_congestion_control=VARIANT

where `VARIANT` is the TCP you are trying to enable (e.g.,
`cubic`, `bic`).

*Note that `reno` does not require the `modprobe` command. You
can enable `reno` with just the `sysctl` command.*

To verify which TCP variant is currently enabled, run

    sysctl net.ipv4.tcp_congestion_control

### TCP buffer size

The Linux network stack sets aside read and write buffers
in memory for each TCP connection. The size of these buffers
affects TCP performance.

You can tune the minimum, default, and
maximum send buffer size with the following command:

    sysctl -w net.ipv4.tcp_wmem="MIN DEF MAX"

where `MIN`, `DEF`, and `MAX` are the minimum, default, and maximum
values, respectively.

You can tune the minimum, default, and
maximum receive buffer size with the following command:

    sysctl -w net.ipv4.tcp_rmem="MIN DEF MAX"

where `MIN`, `DEF`, and `MAX` are the minimum, default, and maximum
values, respectively.

To check the current values, run

    sysctl net.ipv4.tcp_wmem

or

    sysctl net.ipv4.tcp_rmem


### Number of concurrent TCP flows

The `-P` parameter in `iperf` lets you choose the number
of parallel TCP flows to send.

For example, to send 3 parallel flows, you might run

     iperf -c 10.1.1.2 -P 3

(You can learn more about the optional arguments in `iperf` by running `iperf --help`.)

### Link symmetry

All of the parameters described above are set separately for each
direction of the link (client -> server and server -> client).

By setting different values for each direction, you can
therefore vary the symmetry of the link.


## Software and metrics

There are several software tools you can use to evaluate
your selected TCP congestion control variant.
There are different metrics available to each, so
it's up to you to decide what combination of software to use
given your particular experiment goals.

In this section, we describe how to collect and save measurements
from two software tools you may want to use.



### Throughput using `iperf`

From the previous experiment, you should already know
how to install `iperf` on your resources, and how to run it in
client (sender) and server (receiver) mode.

For this lab, you need to store the output of each experiment
trial in a data file. If you run the `iperf` client as follows:

    iperf -c 10.1.1.2 --reportstyle C  -i 1 | tee OUTPUT.txt

where `OUTPUT.txt` is the name of an output file you'd like to
create, it will report throughput at one second intervals,
in a comma-separated values format, and with output
saved to the `OUTPUT.txt` file. (Run `cat OUTPUT.txt` to see
the contents of the file.) Please use meaningful names for your
output files.

Each line in the output will look something like the following:

    20150215191215,10.1.1.1,38878,10.1.1.2,5001,3,0.0-1.0,27131904,217055232

This values in each line are (in order):

 1. Timestamp
 2. Source IP
 3. Source port
 4. Destination IP
 5. Destination port
 6. Begin interval - End interval (in seconds)
 7. Data transferred in this interval (Bytes)
 8. Measured throughput in this interval (bits/second)



You can learn about other `iperf` options by running
`iperf --help`. For example, you may use the `-t` argument
to set the duration of the connection.

### Congestion window using `tinyhttpd`

In addition to (or instead of `iperf`), you may choose to
use the `tinyhttpd` tool. This is a web server that servers files
and also reports detailed information about TCP connections it makes.

To install `tinyhttpd`, first install some prerequisites. Run (as root)

```
apt-get update
apt-get install subversion make gcc
sh -c "echo 'deb http://download.opensuse.org/repositories/home:/cdwertmann:/oml/xUbuntu_14.04/ /' >> /etc/apt/sources.list.d/oml2-apps.list"
wget http://download.opensuse.org/repositories/home:cdwertmann:oml/xUbuntu_14.04/Release.key
apt-key add - < Release.key
apt-get update
apt-get install liboml2-dev
```

Then get the source code for `tinyhttpd`:

    svn co http://witestlab.poly.edu/repos/omlapps/tinyhttpd

Enter the `tinyhttpd` directory, and built the source:

    cd tinyhttpd
    gcc -o tinyhttpd tinyhttpd.c -lpthread -loml2 -locomm -w

Before you can use it, you need to get a large file for the web
server to serve, and place it in the `htdocs` folder. Run

    cd htdocs
    wget http://witestlab.poly.edu/file.txt

to download a large file (~150MB) to use for this purpose.

If you need to make this file larger (i.e. in order to increase
the file transfer time), concatenate the file and itself with

    cat file.txt >> file2.txt
    cat file2.txt >> file.txt

You can run that last command as many times as you need to grow
the file up to its desired size.

To return to the `tinyhttpd` directory, run

    cd ..

Then, to run the `tinyhttpd` web server, run

    ./tinyhttpd PORT --oml-id ID --oml-domain UNITNAME

where `PORT` is the desired port number to listen on,
`ID` is an ID number for this trial, and
`UNITNAME` is the name of the experimental unit.

Look for a line in the output that says something like

    INFO	File_stream: opening local storage file 'tinyhttpd_1_cubic-500M-100m_2015-02-15t20.14.05-0500'

that identifies the name of the output file. You'll need this later to save the results of the experiment.

On the other resource, run

    wget http://IP:PORT/file.txt

where `IP` is the data IP of the resource running the `tinyhttpd` server,
and `PORT` is the port the `tinyhttpd` server is listening on.
This will initiate a file transfer from the `tinyhttpd` server.

After the file transfer is complete, look at the contents of the output
file created by `tinyhttpd` with `cat FILENAME`.

Each line that has a 2 in the second column reports a TCP measurement from
the Linux kernel. For example,

    3.004490	2	1	5	1	0	4	28	10	49	14480	7500	3000	1448	536	204000	40000	00	0	0	0	0


The meaning of each entry is given by the measurement schema earlier in the file:

    schema: 2 tinyhttpd_tcp socket:int32 state:int32 ca_state:int32 last_data_sent:int32 last_data_recv:int32 snd_cwnd:int32 snd_ssthresh:int32 rcv_ssthresh:int32 rtt:int32 rttvar:int32 snd_mss:int32 rcv_mss:int32 rto:int32 ato:int32 unacked:int32 sacked:int32 lost:int32 retrans:int32 fackets:int32 total_retrans:int32




## What to submit

You should answer the questions in 'lab2/submit/SUBMIT.md' and commit them to *your* repository (not my copy!).
You will also need to submit all your data files.

## Appendix A

Please use the aggregate that is assigned to you, according to the following table.

If your last name begins with...  | use this aggregate:
------------- | -------------
A, B, or C  | Clemson InstaGENI
D or E | Cornell InstaGENI
F, G, H, or I  | Kansas InstaGENI
J, K, or L  | Kentucky InstaGENI
M or N  | Missouri InstaGENI
O, P, Q, or R  | NYU InstaGENI
S  | Northwestern InstaGENI
T, U, or V  | UCLA InstaGENI
W, X, Y, or Z  | Wisconsin InstaGENI


If and only if the aggregate assigned to you does not have available resources (i.e. the resource request fails), use one of the following aggregates instead:

 * GPO InstaGENI
 * Stanford InstaGENI
