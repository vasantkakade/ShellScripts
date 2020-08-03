#!/bin/bash
# This script scans for Alive Hosts in the subnet by pinging each host in given Class 'C' IP Network ID Range(e.g. 192.168.74)
# Then it pings all the hosts in the subnetwork 192.168.74.0/24 and the host which are running will give echo-reply.
# And the hosts which give echo-reply there IP address will be captured by using grep utility.
read -p "Enter Class 'C' IP Network ID Range(e.g. 192.168.74): " var1
echo 'Alive Hosts in the Network' $var1'.0/24 are: '
for var2 in `seq 1 254`;do
	ping -c 1 $var1.$var2 | grep "64 bytes from" | grep -oE "\b([0-9]{1,3}\.){3}[0-9]{1,3}\b" | uniq #>> AliveHosts.txt
done
