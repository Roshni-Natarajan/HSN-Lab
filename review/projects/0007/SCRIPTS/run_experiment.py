#!/usr/bin/python

from resource import *
import paramiko
import time

#############################################################################################
#############################################################################################


#####  Open connection to controller and returnt he connection handle  #####
def open_connection_to_controller():
	key = paramiko.RSAKey.from_private_key_file( KEY_LOCATION , password=KEY_PASSWORD)
	conn = paramiko.SSHClient()
	conn.set_missing_host_key_policy(paramiko.AutoAddPolicy())

	print( "Connecting to Controller....")
	conn.connect(hostname = HOST_NAME_CONT, username = USER_NAME, pkey = key)
	print( "Connected to Controller.... \n")

	return conn

#####  Open connection to OVS-Switch and returnt he connection handle  #####
def open_connection_to_ovs():
	key = paramiko.RSAKey.from_private_key_file( KEY_LOCATION , password=KEY_PASSWORD)
	conn = paramiko.SSHClient()
	conn.set_missing_host_key_policy(paramiko.AutoAddPolicy())

	print( "Connecting to OVS Switch....")
	conn.connect(hostname = HOST_NAME_OVS, username = USER_NAME, pkey = key)
	print( "Connected to OVS Switch.... \n")

	return conn

#####  Open connection to Host1 and returnt he connection handle  #####
def open_connection_to_host1():
	key = paramiko.RSAKey.from_private_key_file( KEY_LOCATION , password=KEY_PASSWORD)
	conn = paramiko.SSHClient()
	conn.set_missing_host_key_policy(paramiko.AutoAddPolicy())

	print( "Connecting to Host1....")
	conn.connect(hostname = HOST_NAME_H1, username = USER_NAME, pkey = key, port = HOST_1_PORT)
	print( "Connected to Host1.... \n")

	return conn

#####  Open connection to Host2 and returnt he connection handle  #####
def open_connection_to_host2():
	key = paramiko.RSAKey.from_private_key_file( KEY_LOCATION , password=KEY_PASSWORD)
	conn = paramiko.SSHClient()
	conn.set_missing_host_key_policy(paramiko.AutoAddPolicy())

	print( "Connecting to Host2....")
	conn.connect(hostname = HOST_NAME_H2, username = USER_NAME, pkey = key, port = HOST_2_PORT)
	print( "Connected to Host2.... \n")

	return conn

##### Get the IP Address #####
def get_ip( conn ):
	stdin, stdout, stderr = conn.exec_command("ifconfig eth0 | grep \"inet addr\"")
	ip = ((stdout.read()).split()[1]).lstrip("addr:")

	return ip

##### Get the host IP Address #####
def get_host_ip( conn ):
	stdin, stdout, stderr = conn.exec_command("ifconfig eth1 | grep \"inet addr\"")
	ip = ((stdout.read()).split()[1]).lstrip("addr:")

	return ip

def configure_ovs_switch( conn , cont_ip ):
	print("Configuring the OVS-Switch.... \n")
	stdin, stdout, stderr = conn.exec_command("sudo ifconfig eth1 0");
	stdin, stdout, stderr = conn.exec_command("sudo ifconfig eth2 0");
	stdin, stdout, stderr = conn.exec_command("sudo ovs-vsctl add-port br0 eth1");
	stdin, stdout, stderr = conn.exec_command("sudo ovs-vsctl add-port br0 eth2");
	command = "sudo ovs-vsctl set-controller br0 tcp:"+cont_ip+":6633"
	stdin, stdout, stderr = conn.exec_command(command);
	stdin, stdout, stderr = conn.exec_command("sudo ovs-vsctl set-fail-mode br0 secure");

	# Checking if the OVS Switch is configured properly
	print "OVS-Switch config check. Show bridge (br0) output : "
	stdin, stdout, stderr = conn.exec_command("sudo ovs-ofctl show br0");
	print stdout.read()

	return

def config_start_controller( conn , pox_code ):
	print("Running the "+pox_code+" code on the controller....")
	stdin, stdout, stderr = conn.exec_command("cd /tmp/pox ; ./pox.py --verbose forwarding."+pox_code)
	return

##### Install Iperf on the hosts #####
def install_iperf( conn1 , conn2 ):
	print "\nInstalling Iperf on the hosts...."
	stdin, stdout, stderr = conn1.exec_command("sudo apt-get install iperf")
	stdin, stdout, stderr = conn2.exec_command("sudo apt-get install iperf")

	# Sleeping for 30 seconds
	print "Sleeping for 45 seconds until the installation completes"
	time.sleep(45)

	print "\nCheck if Iperf is installed....\n"
	stdin, stdout, stderr = conn1.exec_command("iperf -v")
	print "Host1 : "+stderr.read()

	stdin, stdout, stderr = conn2.exec_command("iperf -v")
	print "Host2 : "+stderr.read()

	return

##### Start the iperf server service #####
def start_iperf_server( conn , ip ):
	print ("\nStart iperf server on %s" % ip )
	stdin, stdout, stderr = conn.exec_command("iperf -s")
	return

##### Start the iperf client service and send packets to the server #####
def start_iperf_client( conn , client_ip , server_ip , exp_no ):
	print ("\nStart iperf client on %s. Experiment no. : %d" % (client_ip , int(exp_no)) )
	stdin, stdout, stderr = conn.exec_command("iperf -c "+server_ip+" --reportstyle C -i 1 | tee output_"+exp_no)

	# Sleep until the command execution is done
	print "Sleep for 15 seconds until the command execution is done"
	time.sleep(15)

##### Open sftp connection to remote machine #####
def open_sftp_conn( conn ):
	sftp_conn = conn.open_sftp()
	return sftp_conn

##### Get file from remote machine using sftp #####
def get_output_file( sftp_conn , file_name ):
	sftp_conn.get( "/users/"+USER_NAME+"/"+file_name , "./"+file_name )
	return

##### Send file to remote machine using sftp #####
def send_file( conn , sftp_conn , file_name ):
	print "Transfering "+file_name+".py onto the controller...."
	sftp_conn.put( "./"+file_name+".py" , "/users/"+USER_NAME+"/"+file_name+".py" )
	stdin, stdout, stderr = conn.exec_command("sudo cp "+file_name+".py /tmp/pox/pox/forwarding/")
	time.sleep(5)
	return

##### Kill the pox controller process #####
def kill_pox_process( conn ):
	print "\nKilling the pox controller process.... "
	stdin, stdout, stderr = conn.exec_command("ps -elf | grep pox")
	
	pid_1 = stdout.readline().split()[3]
	pid_2 = stdout.readline().split()[3]

	stdin, stdout, stderr = conn.exec_command("kill -9 "+pid_1)
	stdin, stdout, stderr = conn.exec_command("kill -9 "+pid_2)

	return

##### Fetch the files from the host #####
def get_files( conn ):
	print "\nGetting the files from the host"
	
	sftp = open_sftp_conn( conn )
	for i in range(1,9):
		get_output_file( sftp , "output_"+str(i) )   		# Get iperf output files
		get_output_file( sftp , "ping_output_"+str(i) )  	# Get iperf output files
	sftp.close()

	return

def run_ping( conn , server , exp_no ):
	print "\nRunning ping and storing the output.... Experiment : "+exp_no
	stdin, stdout, stderr = conn.exec_command("ping "+server+" -c 10 > ping_output_"+exp_no)
	
	print "Sleep for 15 seconds until the command execution is done"
	time.sleep(15)

	return

#############################################################################################
#############################################################################################


### main method ###
def main():

	#########################
	##### Setting it up #####
	#########################

	# Open connections to the devices
	controller 	= open_connection_to_controller()
	ovs 		= open_connection_to_ovs()
	host1 		= open_connection_to_host1()
	host2 		= open_connection_to_host2()

	# Get the IP addresses of the devices
	controller_ip 	= get_ip( controller )
	ovs_ip 			= get_ip( ovs )
	host1_ip 		= get_host_ip( host1 )
	host2_ip 		= get_host_ip( host2 )

	print "Controller IP address : "+controller_ip
	print "OVS IP address : "+ovs_ip
	print "Host1 IP address : "+host1_ip
	print "Host2 IP address : "+host2_ip
	print "\n"

	# Configure the OVS Switch
	configure_ovs_switch( ovs , controller_ip )

	# Transfer the POX Controller python code-1
	cont_sftp = open_sftp_conn( controller )
	send_file( controller , cont_sftp , POX_CODE_1 )
	send_file( controller , cont_sftp , POX_CODE_2 )
	cont_sftp.close()

	# Configure the Controller with first pox code
	config_start_controller( controller , POX_CODE_1 )

	################################
	##### Running experiment 1 #####
	################################

	# Install Iperf on the hosts
	install_iperf( host1 , host2 )

	# Start iperf server on host-1
	start_iperf_server( host1 , host1_ip )

	# Start iperf client and the ping commands on host-2
	for i in range(1,5):
		start_iperf_client( host2 , host2_ip , host1_ip , str(i) )
		run_ping( host2 , host1_ip , str(i) )

	kill_pox_process( controller )

	################################
	##### Running experiment 2 #####
	################################

	# Configure the Controller with seond pox code
	config_start_controller( controller , POX_CODE_2 )

	# Start iperf client on host-2
	for i in range(5,9):
		start_iperf_client( host2 , host2_ip , host1_ip , str(i) )
		run_ping( host2 , host1_ip , str(i) )

	kill_pox_process( controller )
	
	#######################################
	##### Fetch the files from host-2 #####
	#######################################

	get_files( host2 )

	# Close the opened connections
	controller.close()
	ovs.close()
	host1.close()
	host2.close()

	return

main()