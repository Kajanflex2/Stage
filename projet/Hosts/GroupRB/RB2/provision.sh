#!/bin/bash
set -e

if [ -z $SNSTERGUARD ] ; then exit 1; fi
DIR=`dirname $0`
cd `dirname $0` 

###############################################################################

apt-get update

DEBIAN_FRONTEND=noninteractive apt-get install net-tools nano gedit wireshark openssh-server xfce4 dnsutils -y

###############################################################################

echo "
net.ipv4.conf.default.rp_filter=1
net.ipv4.conf.all.rp_filter=1
net.ipv4.ip_forward=1
net.ipv4.conf.all.log_martians = 1
" >> /etc/sysctl.conf

sysctl -p

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

#Acitver BGP
sed -i 's/bgpd=no/bgpd=yes/' /etc/frr/daemons

echo "hostname RB2" >> /etc/frr/vtysh.conf

echo " 
!
router bgp 65300
 bgp router-id 11.65.32.1
 no bgp ebgp-requires-policy
 neighbor 11.10.2.2 remote-as 65200
 neighbor 30.10.1.2 remote-as 65300
 neighbor 30.10.3.2 remote-as 65300
 !
 address-family ipv4 unicast
  distance bgp 20 200 200
  neighbor 30.10.1.2 next-hop-self
  neighbor 30.10.3.2 next-hop-self
 exit-address-family
exit
!
router ospf
 ospf router-id 30.2.3.1
 redistribute bgp metric 100 metric-type 1
 network 30.10.1.0/24 area 300
 network 30.10.3.0/24 area 300
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