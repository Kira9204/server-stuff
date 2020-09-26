#!/bin/bash
#Define iptables paths
TABLES4=/sbin/iptables
TABLES6=/sbin/ip6tables
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
#----------IPv6 configuration----------
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
