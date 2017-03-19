

# Lab 1: Hello GENI

This lab exercise is due on 2/11. Instructions on *how* to submit are included in this README. Please read these very carefully, and come to [office hours](http://witestlab.poly.edu/~ffund/el6383/) if you have difficulty.

Before asking any questions, please read this *entire* document. If you still believe you need help after reading the complete document, come to the lab instructor [office hours](https://www.google.com/calendar/embed?mode=WEEK&src=ff524%40nyu.edu&color=%23B1365F).

In this lab exercise, you will:

 1) Use your GENI account for the first time and do some one time setup

   * Login to the GENI Experimenter Portal for the first time

   * Join a project

   * Specify SSH keys for use logging into resources

 2) Learn how to reserve, login to, and release resources in GENI

   * Create and renew a slice

   * Generate and reserve your own topology of GENI resources using Jacks

   * Learn how to delete resources in GENI

 3) Understand the difference between the control and data plane interfaces on each node

   * Use these resources to do a very simple first experiment

   * Use `ifconfig` to identify your data and control plane interfaces

   * Use `ping` and `iperf` to test connectivity between the reserved resources


## Submission instructions

All lab exercises and projects in this GENI lab will be submitted through BitBucket using `git`. Using source control, like `git` or `svn`, is an important part of reproducible research and is also a good working habit in general. It will probably seem like an unnecessary complication for this first lab exercise, but for later labs and the project it will prove to be essential.

For this first lab exercise, you will use `git` via the BitBucket web interface.

Please complete the following steps before beginning this exercise:

 * Go to [https://bitbucket.org/](https://bitbucket.org/) and create an account (or sign in if you already have an account)
 * Once you are signed in to your account, *fork* the repository for this course by visiting [https://bitbucket.org/ffund/el6383/fork](https://bitbucket.org/ffund/el6383/fork)

  ![BitBucket fork](http://witestlab.poly.edu/~ffund/el6383/lab1/geni-bb-fork.png)

  Name your fork `EL6383-NETID` using your own NYU NetID, as shown above. Check the box that says  "This is a private repository" and the one that says "Inherit repository user/group permissions." The click "Fork repository."

Now you have your own personal copy of the lab repository. Click on "Source" in the side panel and then "lab1":

![BitBucket see source](http://witestlab.poly.edu/~ffund/el6383/lab1/geni-bb-view.png)

and you will see these instructions:

![BitBucket see instructions](http://witestlab.poly.edu/~ffund/el6383/lab1/geni-bb-instructions.png)

After you've finished the experiment, to submit your work for this lab exercise, you will edit the file in `lab1/submit/SUBMIT.md`:

![BitBucket edit](http://witestlab.poly.edu/~ffund/el6383/lab1/geni-bb-edit.png)

This file is written in Markdown format. A Markdown tutorial is available [here](https://bitbucket.org/tutorials/markdowndemo).


After completing the rest of this lab and answering the questions, you'll press "Commit":

![BitBucket commit](http://witestlab.poly.edu/~ffund/el6383/lab1/geni-bb-commit.png)

and change the commit message to "Please grade this lab1 submission" (exactly as written):

![BitBucket grade](http://witestlab.poly.edu/~ffund/el6383/lab1/geni-bb-grade.png)

You may submit as many times as you'd like before the deadline. The last submission before the deadline will be the one that is graded.

Please follow the instructions above very carefully to make sure your work is submitted and graded.


## Use your GENI account for the first time

To use GENI, you must create a GENI account and join a project. This involves a one-time account setup.

First, go to [http://portal.geni.net](http://portal.geni.net) and click on "Use GENI":

![GENI portal](http://witestlab.poly.edu/~ffund/el6383/lab1/geni-portal-home.png)

On the next screen, you will be prompted to choose an Identity Provider. Choose "New York University" and press "Continue":

![Choose NYU](http://witestlab.poly.edu/~ffund/el6383/lab1/geni-login-nyu.png)

Log in with your NYU NetID:

![NYU login](http://witestlab.poly.edu/~ffund/el6383/lab1/geni-nyu-sso.png)

Review the policies on the next page, check both boxes, and click "Activate":

![Accept policies](http://witestlab.poly.edu/~ffund/el6383/lab1/geni-accept.png)

Are you having trouble logging in with your NYU NetID? See [Appendix A](#markdown-header-appendix-a).

Once in the portal, you need to join a project. Click on the "Projects link":

![Projects link](http://witestlab.poly.edu/~ffund/el6383/lab1/geni-projects.png)

You will see a list of projects. Click "Join" next to "EL6383-NYU-S2015":

![Projects list](http://witestlab.poly.edu/~ffund/el6383/lab1/geni-join-project.png)

After submitting your join request, on the portal homepage, you should see the oustanding join request:

![Outstanding project request](http://witestlab.poly.edu/~ffund/el6383/lab1/geni-join-outstanding.png)

After an instructor has approved your project join request, you should see the project listed under "My Projects" on your portal homepage, as follows:

![Joined project](http://witestlab.poly.edu/~ffund/el6383/lab1/geni-joined-project.png)

Next, you must specify SSH keys to use for logging into resources.

First, you must determine what SSH client you are using:

 * All Linux and Mac distributions come with a built-in SSH client. Just open a Terminal and type `ssh` to see the usage for the `ssh` command. You can also find information online on how to use the `ssh` command.

 * If you are using Windows, you will need to install an SSH client. The one that is recommended for this course is part of [Git Bash](https://msysgit.github.io/). This option is most recommended because it is similar to the Mac/Linux environment (so that the commands will be the same for everyone) and because it also includes `git,` which you will need for this course.

In order to use GENI resources, you must set up a cryptographic key pair. The private key should be installed on your machine, and you must use it together with SSH. The public key should be installed on the GENI portal.


To set up your keys, on the GENI portal homepage, click on "Profile" in the top menu and then click on "SSH Keys":

![SSH Keys](http://witestlab.poly.edu/~ffund/el6383/lab1/geni-portal-keypair.png)

If you already have a private/public key pair set up on your machine, you can just upload it to the GENI portal (choose "upload an SSH public key").

Otherwise, choose "generate and download an SSH keypair" and follow instructions to generate a new keypair. Download your private key, install it in an appropriate location on your machine, and make sure to use it when logging in to GENI resources. (If you are using Windows and Git Bash, [this  note](http://serverfault.com/a/198691) may be helpful to you.)

*Note: SSH is a standard tool, used by millions of people. If you are having a problem with SSH or SSH keys, you are probably not the first person to have that problem; please look online for an existing solution before asking for help.*

## Learn how to reserve, login to, and release resources in GENI

Next, you will create a [slice](http://groups.geni.net/geni/wiki/GENIGlossary) for purposes of this lab exercise. On the portal homepage, where it shows your project memberships, click on "Create Slice":

![Create Slice](http://witestlab.poly.edu/~ffund/el6383/lab1/geni-create-slice.png)

Please name your slice `lab1-netid` using your individual NYU NetID, as shown in the image above. You do not need to enter a slice description.

On the page for this slice, press the "Slice Jacks (beta)" button.

![Slice page](http://witestlab.poly.edu/~ffund/el6383/lab1/geni-slice-page.png)


 In the window that opens, click the "Add Resources" button.

 ![Jacks add](http://witestlab.poly.edu/~ffund/el6383/lab1/geni-jacks-add.png)

Wait for Jacks to open in editing mode, as follows:

![Jacks editor](http://witestlab.poly.edu/~ffund/el6383/lab1/geni-jacks-editor.png)

Add resources to your canvas as follows:

1. Click the black VM box and drag it onto the canvas. This icon represents a virtual machine on a GENI rack.
2. Repeat the above step. You should now see two VM boxes on the canvas.
3. Now click near one of the VM boxes on the canvas, then click and drag towards the other VM. Release when you reach the other VM. You should now see a line and a box representing a network link connecting the two VMs.

![Jacks added](http://witestlab.poly.edu/~ffund/el6383/lab1/geni-jacks-added.png)


To change the name of a VM, click on the the VM box.

For the VM labeled `node-0`, click on the VM box and change "Name" to `client`. Repeat for `node-1`, but change the name to `server`.

Next, click on the unlabeled box in the middle of the link. Enter 10.1.1.1 as the IP address under "Interface to node client", with a mask of 255.255.255.0. Set the IP address under "Interface to node server" to 10.1.1.2 with a mask of 255.255.255.0.

Click the "Site 0" box and select the aggregate you've been assigned from the pulldown menu. (The aggregate assignments are in [Appendix B](#markdown-header-appendix-b).)

The "Reserve Resources" button at the bottom of the pane should now be clickable. Click the "Reserve Resources" button near the bottom of the page.

On the next page, you may have to wait for some time before your resources are ready. Once your resources are ready, the "Status" field will say "Finished":

![Resources ready](http://witestlab.poly.edu/~ffund/el6383/lab1/geni-resources-ready.png)

If your resource reservation request fails, try another aggregate according to the instructions in [Appendix B](#markdown-header-appendix-b).

Next, click on the "Slices" option in the top menu. Next to your slice, click on "Details":

![Slice details](http://witestlab.poly.edu/~ffund/el6383/lab1/geni-slice-details.png)


Then choose "Yes."

On the next page, the portal will query the aggregate you are using to find out if your resources are ready for login. When they are ready (this may take 5-15 minutes), you should see a green "READY" next to each resource:

![Resources ready to login](http://witestlab.poly.edu/~ffund/el6383/lab1/geni-resources-ready-to-login.png)

Next to each VM, it will show you the hostname and port to use when logging in to the node.

To `ssh` into a VM from the command line on Linux or Mac machines, do the following (substituting the values given in the portal, and the location of your private key):

    ssh USERNAME@HOSTNAME -p PORT  -i /PATH/TO/PRIVATEKEY

From a Windows machine, follow the instructions for your SSH client, using the values given in the portal.

Use SSH to log in to your `client` machine:

![SSH login](http://witestlab.poly.edu/~ffund/el6383/lab1/geni-ssh-client.png)

In a second terminal, log in to your `server` machine.


## Understand the difference between the control and data plane interfaces on each node

We'll do a simple experiment to verify IP connectivity between your VMs. On each node, (client and server), run the following command to see the network interfaces on the node:

    sudo ifconfig

Here's some sample output from *my* experiment:

```
eth0      Link encap:Ethernet  HWaddr 02:28:58:44:a6:67  
          inet addr:172.17.3.18  Bcast:172.31.255.255  Mask:255.240.0.0
          inet6 addr: fe80::28:58ff:fe44:a667/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:2054 errors:0 dropped:0 overruns:0 frame:0
          TX packets:2102 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:141795 (141.7 KB)  TX bytes:172055 (172.0 KB)
          Interrupt:25

eth1      Link encap:Ethernet  HWaddr 02:87:85:f5:d7:86  
          inet addr:10.1.1.1  Bcast:10.1.1.255  Mask:255.255.255.0
          inet6 addr: fe80::87:85ff:fef5:d786/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:114 errors:0 dropped:0 overruns:0 frame:0
          TX packets:55 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:6436 (6.4 KB)  TX bytes:4918 (4.9 KB)
          Interrupt:26

lo        Link encap:Local Loopback  
          inet addr:127.0.0.1  Mask:255.0.0.0
          inet6 addr: ::1/128 Scope:Host
          UP LOOPBACK RUNNING  MTU:16436  Metric:1
          RX packets:4 errors:0 dropped:0 overruns:0 frame:0
          TX packets:4 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:260 (260.0 B)  TX bytes:260 (260.0 B)
```

You should see at least two interfaces on each node:

 * **The control interface**. This is the interface you use to access the node, e.g. SSH into your host. The control interface is mainly used for control traffic, i.e. traffic for controlling the node and the experiment.
 * **The data interface**. This is the interface that is used for sending experimental traffic. This is the interface that connects to the other hosts of your experiment through GENI. The data interface has an IP address and mask that match what you configured before you reserved your resources.

 In the example output above, the name of the control interface is `eth0` and its IP address is 172.17.3.18. The name of the data interface is `eth1` and its IP address is 10.1.1.1. The nodes in *your* experiment may have different interfaces and IP addresses.

*In the submit/SUBMIT.md file, complete question 1 and 2.*

From the client, ping the server using the IP address of its *data* interface. For example,

```
ffund@client:~$ ping -c 5 10.1.1.2
PING 10.1.1.2 (10.1.1.2) 56(84) bytes of data.
64 bytes from 10.1.1.2: icmp_req=1 ttl=64 time=0.881 ms
64 bytes from 10.1.1.2: icmp_req=2 ttl=64 time=0.522 ms
64 bytes from 10.1.1.2: icmp_req=3 ttl=64 time=0.546 ms
64 bytes from 10.1.1.2: icmp_req=4 ttl=64 time=0.497 ms
64 bytes from 10.1.1.2: icmp_req=5 ttl=64 time=0.559 ms

--- 10.1.1.2 ping statistics ---
5 packets transmitted, 5 received, 0% packet loss, time 4001ms
rtt min/avg/max/mdev = 0.497/0.601/0.881/0.141 ms
```

Then ping the server using the IP address of its *control* interface. For example,

```
ffund@client:~$ ping -c 5 172.17.3.19
PING 172.17.3.19 (172.17.3.19) 56(84) bytes of data.
64 bytes from 172.17.3.19: icmp_req=1 ttl=63 time=254 ms
64 bytes from 172.17.3.19: icmp_req=2 ttl=63 time=0.642 ms
64 bytes from 172.17.3.19: icmp_req=3 ttl=63 time=0.600 ms
64 bytes from 172.17.3.19: icmp_req=4 ttl=63 time=0.614 ms
64 bytes from 172.17.3.19: icmp_req=5 ttl=63 time=0.576 ms

--- 172.17.3.19 ping statistics ---
5 packets transmitted, 5 received, 0% packet loss, time 3999ms
rtt min/avg/max/mdev = 0.576/51.456/254.850/101.697 ms
```

For the next part of this experiment we'll use `iperf`, a utility that generates network traffic. On each node (client and server), run

    sudo apt-get install iperf

to install `iperf`.

On the server node, run `iperf` in server mode:

    iperf -s

On the client, run `iperf` using the data plane IP of the server:

    iperf -c SERVERDATAIP

(replace `SERVERDATAIP` in the command above with the data plane IP address of your server).

Then run it again with the control plane IP of the server:

        iperf -c SERVERCONTROLIP

(replace `SERVERCONTROLIP` in the command above with the data plane IP address of your server).

*Record the bandwidth of each link in question 3 in submit/SUBMIT.md. Also answer question 4.*

We're done with this part of the experiment, so you can exit both of your nodes now.


## Release resources

The last thing you must do after completing your experiment is delete reserved resources so that they become available to others.
In the portal, click on "Slices" in the top menu bar and choose "Delete" next to your slice name.

![Delete resources](http://witestlab.poly.edu/~ffund/el6383/lab1/geni-delete-resources.png)

In order to get credit for this assignment, you must release your resources. Confirm that you have release your resources by clicking on "Slices" and then "Details." You should get a message like the following:

![No known resources](http://witestlab.poly.edu/~ffund/el6383/lab1/geni-no-known.png)


## Appendix A

If you can't log in to the GENI Portal with your NYU NetID, you can request a login from the GENI Project Office instead. Here's how.

Visit https://shib-idp.geni.net/geni/request.html and fill out the form there:

![GPO request](http://witestlab.poly.edu/~ffund/el6383/lab1/geni-request-account.png)

Wait for an email confirming your account creation from the GENI Project Office. (This may take a couple of days.)

Once you receive the email, visit the [GENI portal](http://portal.geni.net) and click "Use GENI." When asked to choose an Identity Provider, select "GENI Project Office" and press "Continue":

![Choose GPO](http://witestlab.poly.edu/~ffund/el6383/lab1/geni-choose-account.png)

Log in with the GENI account you created in the previous step, and press "Continue." From now on, you will use this account every time you log in to the portal:

![GPO login](http://witestlab.poly.edu/~ffund/el6383/lab1/geni-portal-login.png)

At this stage, you can return to the regular instructions and proceed from there.


## Appendix B

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


## References

This lab exercise is based on [Lab Zero: A First Experiment Using GENI and Jacks Tool](http://groups.geni.net/geni/wiki/GENIExperimenter/Tutorials/jacks/GettingStarted_PartI/Procedure)
