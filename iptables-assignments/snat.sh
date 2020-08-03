#!/bin/bash
# This script does Source Network Address Translation (SNAT) 
# where Source address of Private LAN gets changed when it tries to connect to Public WAN.

echo 1 > /proc/sys/net/ipv4/ip_forward

LAN="ens33"
WAN="ens37"

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
iptables -t nat -L -v
iptables -L -v
