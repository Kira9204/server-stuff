#!/bin/bash
# Network configuration script for Digital Occean
# This is a modified verion of the router/firewall scritp.
# By: Erik Welander
# Version: 2015-07-19
# This script configures both IPV4 and IPv6
#
#Define iptables paths
TABLES4=/sbin/iptables
TABLES6=/sbin/ip6tables
#
#Define interfaces that we work with
WAN=ens3
VPN=tun0
#
#Define subnets
IPV4_SUBNET="193.180.121.0/26"
IPV6_SUBNET="2001:67c:2e74:1::0/64"
IPV4_VPN_SUBNET="10.10.10.0/24"
#
#----------IPv4 configuration----------
#Reset configuration
$TABLES4 -F
$TABLES4 -X
$TABLES4 -t nat -F
$TABLES4 -t nat -X
$TABLES4 -t mangle -F
$TABLES4 -t mangle -X
$TABLES4 -P INPUT ACCEPT
$TABLES4 -P FORWARD ACCEPT
$TABLES4 -P OUTPUT ACCEPT
#
#
#MASQUERADE(NAT) packets from a valid subnet
$TABLES4 -t nat -A POSTROUTING -s $IPV4_VPN_SUBNET -o $WAN -j MASQUERADE
#----INPUT table rules
#By default, DROP all packets that does not match a rule
$TABLES4 -P INPUT DROP
#This rule will reject all packets with invalid headers or checksums,
#invalid TCP flags, invalid ICMP messages (such as a port unreachable when we did not send anything to the host),
# and out of sequence packets which can be caused by sequence prediction or other similar attacks.
$TABLES4 -A INPUT -m conntrack --ctstate INVALID -j REJECT
#Localhost should always be accepted
$TABLES4 -A INPUT -i lo -j ACCEPT
#VPN should always be accepted
#$TABLES4 -A INPUT -i $VPN -j ACCEPT
#Accept DHCP requests
$TABLES4 -A INPUT -p udp --dport 67:68 --sport 67:68 -j ACCEPT
#Accept already established and related connections from any source
$TABLES4 -A INPUT -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
#Allow PING from anywhere
$TABLES4 -A INPUT -p icmp -j ACCEPT
#Allow SSH from anywhere, but with a rate limit
$TABLES4 -A INPUT -p tcp -m conntrack --ctstate NEW --dport 22 -m recent --set --name SSH
$TABLES4 -A INPUT -p tcp -m conntrack --ctstate NEW --dport 22 -m recent --update --seconds 60 --hitcount 4 --rttl --name SSH -j REJECT
$TABLES4 -A INPUT -p tcp -m conntrack --ctstate NEW --dport 22 -j ACCEPT
#Allow HTTP from anywhere
$TABLES4 -A INPUT -p tcp --dport 80 -j ACCEPT
#Allow HTTPS from anywhere
$TABLES4 -A INPUT -p tcp --dport 443 -j ACCEPT
#Allow email protocols
#$TABLES4 -A INPUT -p tcp -m multiport --dport 25,465,110,995,143,993,587,465 -j ACCEPT
#Allow DNS requests
$TABLES4 -A INPUT -p tcp --dport 53 -j ACCEPT
$TABLES4 -A INPUT -p udp --dport 53 -j ACCEPT
#Allow WeeChat clients
$TABLES4 -A INPUT -p tcp --dport 9000 -j ACCEPT
#Allow OpenVPN
$TABLES4 -A INPUT -p udp --dport 9927 -j ACCEPT
#Allow PLEX clients
$TABLES4 -A INPUT -p tcp --dport 32400 -j ACCEPT
$TABLES4 -A INPUT -p udp --dport 32400 -j ACCEPT
#
#----ACCEPT table rules
#By default, DROP all packets that does not match a rule
$TABLES4 -P FORWARD ACCEPT
#Reject invalid packets
$TABLES4 -A FORWARD -m conntrack --ctstate INVALID -j REJECT
#
#----OUTPUT table rules
#By default, ACCEPT all packets that does not match a rule
$TABLES4 -P OUTPUT ACCEPT
#Reject invalid packets
$TABLES4 -A OUTPUT -m conntrack --ctstate INVALID -j REJECT
#
#
#
#
#
#==========PORT FORWARDING==========
#Forward FAF
#$TABLES4 -A INPUT -p udp --dport 6112 -j ACCEPT
#$TABLES4 -A FORWARD -p udp --dport 6112 -j ACCEPT
#$TABLES4 -A PREROUTING -t nat -p udp --dport 6112 -i $WAN -j DNAT --to 10.8.0.6

#==========BLOCKLIST==========
#Add domains or IP addresses that we should deny any incomming traffic from.
#Domains will be automatically converted to IP addresses by DNS.
#Use INPUT to deny anything TO YOU
#Use OUTPUT to deny anything FROM YOU
#USe FORWARD to deny anthing going THRU you (routing)
#
#
#
#----------IPv6 configuration----------
#My only IPV6 access is thru an unstable 6to4 relay,
# this was created becuse i wanted to learn how to properly set up an IPV6 relay/router
# with similar security as an private ipv4 network
#Reset configuration
$TABLES6 -F
$TABLES6 -X
$TABLES6 -t nat -F
$TABLES6 -t nat -X
$TABLES6 -t mangle -F
$TABLES6 -t mangle -X
$TABLES6 -P INPUT ACCEPT
$TABLES6 -P FORWARD ACCEPT
$TABLES6 -P OUTPUT ACCEPT
#PREROUTING table rules.i
#----INPUT table rules
$TABLES6 -P INPUT DROP
#Reject invalid packets
$TABLES6 -A INPUT -m conntrack --ctstate INVALID -j REJECT
#Localhost should always be accepted
#$TABLES6 -A INPUT -i lo -j ACCEPT
#Allow packets related to existing connections
$TABLES6 -A INPUT -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
#Allow link-local (for neighbour discovery)
$TABLES6 -A INPUT -s fe80::/10 -j ACCEPT
#Allow multicast
$TABLES6 -A INPUT -d ff00::/8 -j ACCEPT
#Accept new sessions from our subnet
#$TABLES6 -A INPUT -i $WAN -s $IPV6_SUBNET -j ACCEPT
#Allow PING from anywher
$TABLES6 -A INPUT -p ipv6-icmp -j ACCEPT
#Allow SSH from anywhere, but with a rate limit
$TABLES6 -A INPUT -p tcp -m conntrack --ctstate NEW --dport 22 -m recent --set --name SSH
$TABLES6 -A INPUT -p tcp -m conntrack --ctstate NEW --dport 22 -m recent --update --seconds 60 --hitcount 4 --rttl --name SSH -j REJECT
$TABLES6 -A INPUT -p tcp -m conntrack --ctstate NEW --dport 22 -j ACCEPT
#Allow HTTP from anywhere
$TABLES6 -A INPUT -p tcp --dport 80 -j ACCEPT
#Allow HTTPS from anywhere
$TABLES6 -A INPUT -p tcp --dport 443 -j ACCEPT
#Allow email protocols
#$TABLES6 -A INPUT -p tcp -m multiport --dport 25,465,110,995,143,993,587,465 -j ACCEPT
#Allow Mumble server
#$TABLES6 -A INPUT -p tcp --dport 64738 -j ACCEPT
#$TABLES6 -A INPUT -p udp --dport 64738 -j ACCEPT
#Allow WeeChat clients
$TABLES6 -A INPUT -p tcp --dport 9000 -j ACCEPT
#Allow OpenVPN
#$TABLES6 -A INPUT -p udp --dport 2799 -j ACCEPT
#Allow PLEX clients
$TABLES6 -A INPUT -p tcp --dport 32400 -j ACCEPT
$TABLES6 -A INPUT -p udp --dport 32400 -j ACCEPT
#
#
#----FORWARD table rules
#By default, DROP all packets that does not match a rule
$TABLES6 -P FORWARD ACCEPT
#Reject invalid packets
$TABLES6 -A FORWARD -m conntrack --ctstate INVALID -j REJECT
#----OUTPUT table rules
#By default, ACCEPT all packets that does not match a rule
$TABLES6 -P OUTPUT ACCEPT
#Reject invalid packets
$TABLES6 -A OUTPUT -m conntrack --ctstate INVALID -j REJECT
#
##==========BLOCKLIST==========
#
