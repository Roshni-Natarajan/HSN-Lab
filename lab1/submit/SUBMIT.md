
## Submission

Please answer the following questions in Markdown. Push your code to
BitBucket to submit this assignment.

1) The following shows the `ifconfig` command and its output for the client and server in *my* experiment. Replace these blocks with the `ifconfig` output of the client and server from *your* experiment.

```
rn979@client:~$ ifconfig 
eth0      Link encap:Ethernet  HWaddr 02:f7:e7:ba:b6:52  
          inet addr:172.17.2.13  Bcast:172.31.255.255  Mask:255.240.0.0
          inet6 addr: fe80::f7:e7ff:feba:b652/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:354 errors:0 dropped:0 overruns:0 frame:0
          TX packets:386 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000 
          RX bytes:53731 (53.7 KB)  TX bytes:46219 (46.2 KB)
          Interrupt:25 

eth1      Link encap:Ethernet  HWaddr 02:08:29:bc:6b:90  
          inet addr:10.1.1.1  Bcast:10.1.1.255  Mask:255.255.255.0
          inet6 addr: fe80::8:29ff:febc:6b90/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:18 errors:0 dropped:0 overruns:0 frame:0
          TX packets:9 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000 
          RX bytes:1080 (1.0 KB)  TX bytes:978 (978.0 B)
          Interrupt:26 

lo        Link encap:Local Loopback  
          inet addr:127.0.0.1  Mask:255.0.0.0
          inet6 addr: ::1/128 Scope:Host
          UP LOOPBACK RUNNING  MTU:16436  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0 
          RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)

rn979@client:~$ 

```

```
rn979@server:~$ ifconfig 
eth0      Link encap:Ethernet  HWaddr 02:bb:37:ba:6a:62  
          inet addr:172.17.2.14  Bcast:172.31.255.255  Mask:255.240.0.0
          inet6 addr: fe80::bb:37ff:feba:6a62/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:369 errors:0 dropped:0 overruns:0 frame:0
          TX packets:398 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000 
          RX bytes:55973 (55.9 KB)  TX bytes:47439 (47.4 KB)
          Interrupt:25 

eth1      Link encap:Ethernet  HWaddr 02:ce:0b:70:95:b3  
          inet addr:10.1.1.2  Bcast:10.1.1.255  Mask:255.255.255.0
          inet6 addr: fe80::ce:bff:fe70:95b3/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:24 errors:0 dropped:0 overruns:0 frame:0
          TX packets:11 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000 
          RX bytes:1756 (1.7 KB)  TX bytes:1390 (1.3 KB)
          Interrupt:26 

lo        Link encap:Local Loopback  
          inet addr:127.0.0.1  Mask:255.0.0.0
          inet6 addr: ::1/128 Scope:Host
          UP LOOPBACK RUNNING  MTU:16436  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0 
          RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)

rn979@server:~$
```


2)  Fill out the missing cells in the following table, using the results
of your individual experiment:

Node    | control interface name | control IP  | data interface name | data IP
------- | ---------------------- | ----------- | ------------------- | --------
client  |         eth0           | 172.17.2.13 |        eth1         | 10.1.1.1
server  |         eth0           | 172.17.2.14 |        eth1         | 10.1.1.2

3)  Fill out the missing cells in the following table, using the results
of your individual experiment:

Link     |  Bandwidth (Mbits/sec)
-------- | ----------------------
control  | 2.93 Gbits/sec
data     | 100  Mbits/sec


4) What happens if you bring down the data interface of your node using the command

    " sudo ifconfig DATAIFNAME down " 
    
    DATAIFNAME - eth1
    The above command brings down the interface. Post this command no packets can be sent or received on this interface (was checked using ping).
    
    sudo ifconfig eth1 up
    The above command brings the interface back up. Post this command packets can be sent and received on this interface again (checked using ping).
    
    If the control interface of the node was brought down using this command, all communication to the VM is lost, presumable because no packets can
    be sent or received on this interface.

 where `DATAIFNAME` is the name of the data interface (i.e. `eth0` or `eth1`)? What happens if you bring down the control interface of your node? Why?
