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

DEBIAN_FRONTEND=noninteractive apt-get install iptables-persistent -y

iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE

#iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
#iptables -A FORWARD -i eth0 -o eth1 -m state –state RELATED,ESTABLISHED -j ACCEPT
#iptables -A FORWARD -i eth1 -o eth0 -j ACCEPT

iptables-save >/etc/iptables/rules.v4

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

echo "hostname R2" >> /etc/frr/vtysh.conf

echo " 
ip route 0.0.0.0/0 eth0
!
router ospf
 ospf router-id 1.1.2.2
 network 10.0.2.0/24 area 200
 network 10.0.6.0/24 area 200
 default-information originate always
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

