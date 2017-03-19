# The absolute path to the private key that we created in Step-7
KEY_LOCATION 	= "/users/skr334/el6383-hsn-project/SCRIPTS/id_geni_ssh_rsa"
# Passkey for the Private Key that you use to generate the SSH-Key-Pair 
KEY_PASSWORD 	= "roshni" 		
# Username used to login to your resources
USER_NAME 	= "skr334" 	

# The details for the following parameters can be found from the Details tab of your Slices

# Host name of the Controller VM
HOST_NAME_CONT	 	= "pcvm5-16.instageni.ku.gpeni.net" 

# Host name of the OVS VM
HOST_NAME_OVS 		= "pcvm1-34.genirack.nyu.edu" 

# Host name of the Host-1 VM
HOST_NAME_H1 		= "pc1.genirack.nyu.edu"
HOST_1_PORT 		= 41531		

# Host name of the Host-2 VM
HOST_NAME_H2 		= "pc1.genirack.nyu.edu"
HOST_2_PORT 		= 41532

# DONOT CHANGE THIS !!!
# POX Controller python code
POX_CODE_1 		= "decision_at_controller"
POX_CODE_2		= "decision_at_switch"
