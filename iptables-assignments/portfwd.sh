#!/bin/bash
# Considering Public webserver is on IP 192.168.200.101
# Considering Client is on IP 192.168.100.101
# This script does DNAT, Port Forwarding from WAN to Public webserver
# And also does DNAT, Port Forwarding from Public webserver to client.
# Enable IP forwarding on host.
echo 1 > /proc/sys/net/ipv4/ip_forward
LAN="ens33" # IP: 192.168.100.254
WAN="ens37" # IP: 192.168.200.254
iptables -F
iptables -t nat -F
iptables -P INPUT ACCEPT
iptables -P OUTPUT DROP
iptables -P FORWARD DROP

# Allow routing packets from Private LAN to Public WAN
iptables -A FORWARD -i $LAN -o $WAN -j ACCEPT
# Allow routing packets from Public WAN to Private LAN for Established, Related connection.
iptables -A FORWARD -i $WAN -o $LAN -m state --state RELATED,ESTABLISHED -j ACCEPT

# Allow LAN nodes with private IP addresses to communicate with external public networks i.e. WAN
iptables -t nat -A POSTROUTING -o $WAN -j MASQUERADE

iptables -t nat -A PREROUTING -p tcp -d 192.168.200.101 --dport 80 -j DNAT --to-destination 192.168.100.101
iptables -t nat -A PREROUTING -p tcp -d 192.168.200.254 --dport 80 -j DNAT --to-destination 192.168.200.101
iptables -t nat -A POSTROUTING -o $WAN -j MASQUERADE
iptables -t nat -L -v
iptables -L -v
