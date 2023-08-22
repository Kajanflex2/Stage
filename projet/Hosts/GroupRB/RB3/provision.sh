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

#iptables -t nat -A POSTROUTING -s 30.10.3.0/24 -o eth0 -j MASQUERADE
#iptables -t nat -A POSTROUTING -s 30.10.2.0/24 -o eth0 -j MASQUERADE
#iptables -t nat -A POSTROUTING -s 10.0.3.0/24 -o eth0 -j MASQUERADE


#iptables -A  FORWARD -s 30.10.2.0/24 -d 10.0.3.0/24 -j ACCEPT
#iptables -A  FORWARD -s 30.10.3.0/24 -d 10.0.3.0/24 -j ACCEPT
#iptables -A  FORWARD -m conntrack --ctstate ESTABLISHED -j ACCEPT

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

#Activer BGP
sed -i 's/bgpd=no/bgpd=yes/' /etc/frr/daemons

echo "hostname RB3" >> /etc/frr/vtysh.conf

echo " 
!
ip route 0.0.0.0/0 eth0
!
interface lo
 ip address 90.90.10.10/24
 shutdown
exit
!
router bgp 65300
 bgp router-id 30.65.30.10
 no bgp ebgp-requires-policy
 neighbor 30.10.2.1 remote-as 65300
 neighbor 30.10.3.1 remote-as 65300
 !
 address-family ipv4 unicast
  distance bgp 20 200 200
  network 0.0.0.0/0
  neighbor 30.10.2.1 next-hop-self
  neighbor 30.10.3.1 next-hop-self
 exit-address-family
exit
!
router ospf
 ospf router-id 30.2.1.1
 redistribute bgp metric 100 metric-type 1
 network 30.10.2.0/24 area 300
 network 30.10.3.0/24 area 300
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