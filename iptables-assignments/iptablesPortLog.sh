#!/bin/bash
# This script creates the logfile for particularly when there was new connection to port no. 4444.

iptables -F
iptables -A INPUT -j LOG
iptables -I INPUT -p tcp --dport 4444 --syn -j ACCEPT
iptables -I INPUT -p udp --dport 4444 -j ACCEPT
iptables -I INPUT -p tcp --dport 4444 -j LOG
iptables -I INPUT -p udp --dport 4444 -j LOG
iptables -I INPUT -p tcp --dport 4444 -m state --state NEW -j LOG --log-prefix "New Connection to TCP Port 4444"
iptables -I INPUT -p udp --dport 4444 -m state --state NEW -j LOG --log-prefix "New Connection to UDP Port 4444"
iptables -L -v

read -p "Please Enter the Log file name : " fileName
read -p "Pleae Enter Path Location to store file : " filePath
cat /var/log/syslog | grep 4444 > $filePath/$fileName
