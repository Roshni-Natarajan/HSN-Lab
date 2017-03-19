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


