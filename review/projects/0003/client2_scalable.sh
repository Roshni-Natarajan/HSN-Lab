sudo apt-get update && sudo apt-get install iperf && sudo modprobe tcp_scalable && sudo sysctl -w net.ipv4.tcp_congestion_control=scalable