#!/bin/bash
# This script blocks incoming icmp packets to the host, but allows pinging other machines.

# To Flush out the previous iptables entries
iptables -F

# To allow pinging to loopback interface ip range
#iptables -A INPUT -p icmp -s 127.0.0.0/8 -j ACCEPT
#iptables -A OUTPUT -p icmp -s 127.0.0.0/8 -j ACCEPT

# To allow incoming connection or request to loopback interface
iptables -A INPUT -i lo -j ACCEPT
# To allow establised and related connections
iptables -A INPUT -m state --sate RELATED,ESTABLISHED -j ACCEPT

# To deny incoming icmp echo request packets
iptables -A INPUT -p icmp --icmp-type echo-request -j DROP
# To deny outgoing icmp echo reply packets
#iptables -A OUTPUT -p icmp --icmp-type echo-reply -j DROP

# To allow outgoing icmp echo request packets to ping others
iptables -A OUTPUT -p icmp --icmp-type echo-request -j ACCEPT
# To allow incoming icmp echo reply packets to get echo reply to ping
iptables -A INPUT -p icmp --icmp-type echo-reply -j ACCEPT

# To List and see iptables Chain Policy filters
iptables -L
