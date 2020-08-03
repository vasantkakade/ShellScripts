#!/bin/bash
# This script blocks all incoming packets and packets routing through (forwared from) the host,
# but allows outgoing connection and incoming connections from the connection already established by the host.
# Also allows incoming connections for the connection related to outgoing connection from host.

# Flush the previous iptables rules.
iptables -F

# Blocks incoming connection to host.
iptables -P INPUT DROP

# Blocks the packets routing through (forwared from) the host.
iptables -P FORWARD DROP

# Allows outgoing connection from the host.
iptables -P OUTPUT ACCEPT

# Allows incoming connection on loopback interface.
iptables -A INPUT -i lo -j ACCEPT

# Allows incoming connections from the connection already established by the host.
# Also allows incoming connections for the connection related to outgoing connection from host.
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

# Lists all the iptables rules.
iptables -L
