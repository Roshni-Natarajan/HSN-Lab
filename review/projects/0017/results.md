From the graphs shown below we can conclude following things: 
$$$$$$$$$$$$ OVS LOCAL FLOW $$$$$$$$$$$$$$$$$$
![ovs] (https://bytebucket.org/abhinav1586/el6383-av1586geniproject/raw/fe8a05f094aee1273b571c877049d8f74c6cb015/project/final_OVS/ovs.png?token=614fd2c6463ea8fa66d19f588f6800bce1ddc36e)

This is a graph for OVS with local flow router. It shows that almost 97 of the total packets (100) experience a very small delay (0.00003-0.00004s) ,that is,
processing time for almost 97% packets is between 0.00003s to 0.00004s. Very few packets experience th delay of 0.00050 sec to 0.00080 sec.

$$$$$$$$$$$$ Linux $$$$$$$$$$$$$$$$$

![linux] (https://bytebucket.org/abhinav1586/el6383-av1586geniproject/raw/0df8bafadf0f5d31356e5c9bce744a1d4e927258/project/final_linux/linux.png?token=df682f11422c6464335fed36d5a64d662c05082c)

From the CDF, it can easily observed that all the packets are processed within 0.00004sec. Moreover 98 out of 100 packets were processed in 0.00002 sec.

![xorp] (https://bytebucket.org/abhinav1586/el6383-av1586geniproject/raw/0df8bafadf0f5d31356e5c9bce744a1d4e927258/project/final_Xorp/abhinav_xorp.png?token=b8a1624071e448c75ef869b9c1af826fc2101ed8)

This plot shows that almost 97% of the packets were processed in 0.00003-0.00004sec. While some packet took almosst 0.0001sec to get processed.


