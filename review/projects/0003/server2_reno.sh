sudo apt-get update && sudo apt-get install iperf && sudo sysctl -w net.ipv4.tcp_congestion_control=reno && sudo iperf -s