#!/bin/bash
set -e

if [ -z $SNSTERGUARD ] ; then exit 1; fi
DIR=`dirname $0`
cd `dirname $0`

###############################################################################

# do something visible
#ip route add 0.0.0.0/0 via 192.168.1.254

apt-get update

DEBIAN_FRONTEND=noninteractive apt-get install net-tools nano gedit curl wget xfce4 dnsutils wireshark -y

###############################################################################

echo "172.16.111.10     www.snsterproject.fr" >> /etc/hosts

#curl --max-time 2 -f -I http://172.16.110.10/

###############################################################################

echo " 
nameserver 1.1.1.1
" > /etc/resolv.conf

###############################################################################

sed -i '/iface eth0 inet dhcp/ c\iface eth0 inet static\n  address 192.168.111.30/24\n  gateway 192.168.111.254' /etc/network/interfaces

###############################################################################