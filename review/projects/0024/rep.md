Experiment design:  
    The goal of the experiment is to compare the speed of UDT(UDP-based Data Transfer) and FTP(TCP-based Data Transfer) under bandwidth, link delay and packet loss.   
    The parameters are bandwidth, link delay and the packet loss.  
    The metrics are the througputs achieved by FTP and UDT under the certain parameters.  
====================================================================================================================================================================  

Implementation of the experiment design:  
    The following picture shows the sliver.  
    ![](https://lh3.googleusercontent.com/-GfKtLy2x_1g/VTGg5GTap-I/AAAAAAAAADU/_tlj3F5y_nc/w496-h358-no/3.png)  
    File transfer using UDT:  
        On PC1, start a UDT file transfer server, using this command:  
            /local/udt4/app/sendfile  
        On PC2, start a UDT file transfer client, using this command:  
            /local/udt4/app/recvfile pc1 9000 /local/datafiles/lg.1G /dev/null  
    File transfer using FTP:  
        There is a already a FTP server running on pc1. So we need only to log into pc2 and start an ftp client, using this command:  
            ftp pc1  
        Using the username anonymous and any password.  
        Requesting a file transfer on pc2.  
            get lg.1G /dev/null  
    The output of UDP will be like this:  
        new connection: 192.168.2.2:37391  
        speed = 563.996Mbits/sec  
    Here we think that 563.996 is the throughput.  
    The output of FTP will be like this:  
        200 PORT command successful. Consider using PASV.  
        150 Opening BINARY mode data connection for lg.1G (1048576000 bytes).  
        226 Transfer complete.  
        1048576000 bytes received in 9.67 secs (105927.6 kB/s)  
    Here we think that 105927.6 is the throuput.
    Logging into the delay node to change the characteristics of the link.  
    To show the current parameters, using the command:  
        sudo ipfw pipe show  
    The output will be like this:  
        60111: 100.000 Mbit/s    1 ms   50 sl. 1 queues (1 buckets) droptail  
        mask: 0x00 0x00000000/0x0000 -> 0x00000000/0x0000  
        BKT Prot ___Source IP/port____ ____Dest. IP/port____ Tot_pkt/bytes Pkt/Byte Drp  
          0 ip    207.167.175.72/0       195.123.216.8/6        7     1060  0    0   0  
        60121: 100.000 Mbit/s    1 ms   50 sl. 1 queues (1 buckets) droptail  
        mask: 0x00 0x00000000/0x0000 -> 0x00000000/0x0000  
        BKT Prot ___Source IP/port____ ____Dest. IP/port____ Tot_pkt/bytes Pkt/Byte Drp  
          0 ip   207.167.176.224/0         195.124.8.8/6        8     1138  0    0   0  
    Here we can see that the bandwidth is 100.000Mbit/s, delay is 1ms and there is no packet loss. The packet loss parameter will be shown after the 'sl.' if non-zero.  
    To change the link parameters, using this command:  
        sudo ipfw pipe 60111 config bw 10M delay 0 plr 0  
        sudo ipfw pipe 60111 config bw 10M delay 0 plr 0  
    Here we set the bandwidth to be 10M, delay to be 0ms and packet loss to be 0  
=======================================================================================================================================================================  

The parameters we choose in this experiment:  
    Bandwidth: 100M, 500M and 1000M  
    delay: 0 and 50ms  
    packet loss: 0 and 0.01  
=============================================  

We do each transmission five times and calculate the average value. Then we use MATLAB to process the data.  
    Here shows the data we get.  
    ![](https://lh3.googleusercontent.com/-kmPsNSM8l1Y/VTF3njXzDyI/AAAAAAAAAC4/uWa1AzCIxnA/w560-h493-no/1.png)  
    ![](https://lh5.googleusercontent.com/-Ql9ceCV7eF0/VTF3nvxQmbI/AAAAAAAAAC8/s_CV7dwgues/w560-h493-no/2.png)  
As shown above, we can say that line delay has less effect in UDP than packet loss does while line delay has more effect in FTP than packet loss does.  
We can also say that under the same parameters, UDT has a better speed than the FTP.  