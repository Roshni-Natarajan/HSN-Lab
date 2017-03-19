# Lab 3: Routing and resiliency

This lab exercise is due on 3/29 at 11:59PM. Instructions on *how* to submit are
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

 * Understand basic GENI terminology
 * Log in to the GENI portal
 * Create a slice on GENI
 * Reserve simple resources using Slice Jacks
 * Find out SSH login information for slice resources from the GENI portal
 * Access GENI resources over SSH
 * Use `ifconfig`, `ping`, and `iperf`
 * Use basic Linux tools
 * Follow instructions to reproduce an experiment
 * Release (delete) resources in a slice when you're done with them


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

#### Alternative method

**Note: Since some students are having problems syncing via the Bitbucket online 
interface, here's an alternative method:**

* Clone a copy of your repository (in the terminal on Mac or Linux, or in Git Bash on Windows) and `cd` inside the repository
* Make sure your copy is up to date with changes *you* have made
```
git pull origin
git fetch origin -v
```
* Run these commands to merge the changes from the upstream repository:
```
git remote add --track master upstream https://bitbucket.org/ffund/el6383.git
git fetch upstream -v
git merge upstream/master
```
* Manually fix any merge conflicts, as shown in in-class tutorial
* Commit and push your changes back to your Bitbucket account
```
git commit -m "Merged changes from el6383 upstream"
git push -u origin master
```

#### Original, graphical method

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

Your assignment is to reproduce several simple "experiments" related to Internet routing.

Specifically, you will:

* Practice Dijkstra's algorithm with an experiment that runs on GENI using a "live" long-running experiment setup.
* Demonstrate the resiliency of OSPF to link failure with an experiment that runs on GENI that has been advertised as a reproducible experiment.

You will record your attempts to reproduce these
experiments, and review each experiment with respect to
how reproducible it was. **Before you begin**, please read the SUBMIT.md file to see exactly what you are expected to submit.

### Dijstra's Algorithm

One way to make an experiment reproducible is to leave up
a long-running instance of the experiment setup, and let
others run the experiment on this setup.

In this experiment, you will use a multi-site GENI topology that is already set up and configured for others
to use through a web-based interface. You should be able to run Dijkstra's algorithm ("reproduce" the experiment results) with minimal effort.

#### Experiment Topology

![dijkstra-topology](http://i.imgur.com/QyaF3Re.png)

Nodes are located at multiple GENI aggregates and are connected to one another over the public Internet, via the control interface.

#### Expected Results

You are expected to submit as the "result" of this experiment, a screenshot of a network topology and a table showing
the shortest path from the "gold" node in the topology to all other nodes, like the following:

![dijkstra-results](http://i.imgur.com/MnKrktt.png)

(Note that your topology may be different from the one shown here.)

#### Experiment Procedure

To run this experiment, you should:

1. Register for an account on [hyperion.poly.edu](http://hyperion.poly.edu/register).
2. Sign up for the [Internet Routing](http://hyperion.poly.edu/courses/GENI/GENI105/2014T1/about) module.
3. Read the material in the [About the experiment](http://hyperion.poly.edu/courses/GENI/GENI105/2014T1/courseware/038cca33bd884e619043149830ac6ccf/8b1bf581ba6141ae8575c007da49bda0/) section.
4. [Run the experiment](http://hyperion.poly.edu/courses/GENI/GENI105/2014T1/courseware/038cca33bd884e619043149830ac6ccf/bd3c2c713749477e81389fee4fe53060/)

#### Experiment Setup

Most of this experiment was already prepared for you by the experiment designers - you didn't have to go through all the setup steps because you ran it on a live, long-running experiment setup.

The *process* of preparing this experiment is documented by the experiment designers [here](http://witestlab.poly.edu/repos/genimooc/internet_routing/README) and all the code and other materials for this experiment are given in [this repository](http://witestlab.poly.edu/repos/genimooc/internet_routing/).

Review these materials. Do you think you would be able to reproduce the steps necessary to prepare the experiment? In other words, if hyperion.poly.edu would disappear, do you think you could follow those instructions to set up a topology on GENI and run Dijkstra's alogorithm on that topology? How long do you think it would take you to do this setup?

### OSPF Convergence


Another way to make an experiment reproducible is to make the experiment *artifacts* (e.g. disk image, RSpec, router configurations) publicly available, and give detailed instructions for how to set up and run the experiment.

In this experiment, you will follow instructions to set up and run an experiment on OSPF convergence.

#### Experiment Topology

There are multiple versions of this experiment. You should do the one with four routers, as shown here:

![](http://i.imgur.com/iCkdVVM.png)

(I used Cornell InstaGENI; you should use your assigned aggregate, per the aggregate assignment table.)

#### Expected Results

You are expected to submit as the "result" of this experiment:

 * Traceroute from client to server with all links active
 * OSPF table on router-1 with all links active
 * Traceroute from client to server with the router-2 link down
 * OSPF table on router-1 with the router-2 link down

like the following.

Traceroute from client to server with all links active:

```
ffund01@client:~$ traceroute server
traceroute to server (192.168.20.10), 30 hops max, 60 byte packets
 1  router-1-lan5 (192.168.10.10)  0.568 ms  0.509 ms  0.483 ms
 2  router-2-lan0 (192.168.1.2)  0.958 ms  0.945 ms  0.963 ms
 3  router-3-lan2 (192.168.3.2)  1.556 ms  1.517 ms  1.475 ms
 4  server-lan6 (192.168.20.10)  1.805 ms  1.785 ms  1.792 ms
```

OSPF table on router-1 with all links active:

```
root@router-1.lab3-ff524.ch-geni-net.instageni.rnoc.gatech.edu> show route table ipv4 unicast ospf
192.168.2.0/24	[ospf(110)/20]
		> to 192.168.1.2 via eth1/eth1
192.168.3.0/24	[ospf(110)/20]
		> to 192.168.4.1 via eth2/eth2
192.168.5.0/24	[ospf(110)/20]
		> to 192.168.4.1 via eth2/eth2
192.168.20.0/24	[ospf(110)/30]
		> to 192.168.1.2 via eth1/eth1
```
Traceroute from client to server with the router-2 link down:

```
ffund01@client:~$ traceroute server
traceroute to server (192.168.20.10), 30 hops max, 60 byte packets
 1  router-1-lan5 (192.168.10.10)  0.712 ms  0.685 ms  0.663 ms
 2  router-4-lan3 (192.168.4.1)  1.158 ms  1.150 ms  1.129 ms
 3  router-3-lan2 (192.168.3.2)  1.501 ms  1.489 ms  1.472 ms
 4  server-lan6 (192.168.20.10)  1.786 ms  1.766 ms  1.758 ms
```

OSPF table on router-1 with the router-2 link down:

```
root@router-1.lab3-ff524.ch-geni-net.instageni.rnoc.gatech.edu> show route table ipv4 unicast ospf
192.168.2.0/24	[ospf(110)/30]
		> to 192.168.4.1 via eth2/eth2
192.168.3.0/24	[ospf(110)/20]
		> to 192.168.4.1 via eth2/eth2
192.168.5.0/24	[ospf(110)/20]
		> to 192.168.4.1 via eth2/eth2
192.168.20.0/24	[ospf(110)/30]
		> to 192.168.4.1 via eth2/eth2

```

#### Experiment Procedure

The experiment is described in [this paper](http://mescal.imag.fr/membres/arnaud.legrand/research/readings/acm_sigops_si_rsea/p90-edwards.pdf).

The paper includes a link to a [page on the GENI wiki](http://groups.geni.net/geni/wiki/PaperOSRMethodology) that describes how to reproduce the experiment
described in the paper - you should find everything you need there, and on the linked pages.

Some things have changed in GENI since this experiment was designed - for example, the resource reservation tool described there (Flacks) is now deprecated and you should not use it. You'll have to determine how to achieve an equivalent setup given the other tools available to you. Also, please use your assigned aggregate (per the aggregate assignment table at the end of this document).

Note that since this assignment is about reproducing experiments, you are supposed to figure out on your own how to proceed if you get stuck (not email me).  If you aren't able to get experiment results (i.e. you fail to reproduce the experiment), your report should describe *in detail* what issues you encountered, and how you attempted to fix them. (This should go in the part of the report on extra steps and changes.)

## What to submit

You should answer the questions in 'lab3/submit/SUBMIT.md' and commit them to *your* repository (not my copy!).


## Release resources

Please release all your GENI resources once you have finished the experiment and submitted your report.

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

 * NYSERNet InstaGENI
 * SoX InstaGENI
 * Illinois InstaGENI
 * Kettering InstaGENI
