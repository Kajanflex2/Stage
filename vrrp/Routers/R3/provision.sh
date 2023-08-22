#!/bin/bash
set -e
if [ -z $SNSTERGUARD ] ; then exit 1; fi
DIR=`dirname $0`
cd `dirname $0`

# do something visible
#ip route add 0.0.0.0/0 via 192.168.1.254

apt-get update

DEBIAN_FRONTEND=noninteractive apt-get install net-tools nano gedit curl wget xfce4 dnsutils -y

###############################################################################

echo "
net.ipv4.conf.default.rp_filter=1
net.ipv4.conf.all.rp_filter=1
net.ipv4.ip_forward=1
net.ipv4.conf.all.log_martians = 1
" >> /etc/sysctl.conf

sysctl -p

#sysctl -w net.ipv4.conf.eth0.ignore_routes_with_linkdown=1

###############################################################################

echo "

auto vrrp4-2-2
iface vrrp4-2-2 inet static
    pre-up ip link add vrrp4-2-2 link eth0 addrgenmode random type macvlan mode bridge
    pre-up ip link set dev vrrp4-2-2 address 00:00:5e:00:01:05
    address 192.168.1.254/24
    up ip link set dev vrrp4-2-2 up
" >> /etc/network/interfaces

ifup vrrp4-2-2

###############################################################################

sed -i '/iface eth0 inet dhcp/ c\iface eth0 inet static\n  address 192.168.1.200/24' /etc/network/interfaces

###############################################################################

#__add GPG key
curl -s https://deb.frrouting.org/frr/keys.gpg | tee /usr/share/keyrings/frrouting.gpg > /dev/null

#__possible values for FRRVER: frr-6 frr-7 frr-8 frr-stable
#__frr-stable will be the latest official stable release
FRRVER="frr-8"
echo deb '[signed-by=/usr/share/keyrings/frrouting.gpg]' https://deb.frrouting.org/frr $(lsb_release -s -c) $FRRVER | tee -a /etc/apt/sources.list.d/frr.list

###############################################################################

apt-get update

#__update and install FRR
DEBIAN_FRONTEND=noninteractive apt-get install frr frr-pythontools -y

###############################################################################

#Activer OSPFv2
sed -i 's/ospfd=no/ospfd=yes/' /etc/frr/daemons

#Activer VRRP
sed -i 's/vrrpd=no/vrrpd=yes/' /etc/frr/daemons

echo "hostname R3" >> /etc/frr/vtysh.conf

echo " 
!
interface eth0
 vrrp 5 version 3
 vrrp 5 priority 150
 vrrp 5 advertisement-interval 1000
 vrrp 5 ip 192.168.1.254
exit
!
router ospf
 ospf router-id 20.20.60.1
 network 20.20.20.0/24 area 400
 network 20.20.60.0/24 area 400
 network 192.168.1.0/24 area 400
exit
!
" >> /etc/frr/frr.conf

###############################################################################

systemctl enable frr.service

###############################################################################

service frr restart

###############################################################################

systemctl restart frr.service

###############################################################################

sysctl -w net.ipv4.conf.eth0.ignore_routes_with_linkdown=1

###############################################################################
