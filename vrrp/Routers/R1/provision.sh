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

# Ajoute des configurations au fichier '/etc/sysctl.conf' pour:
# - Activer la protection contre les attaques de type "source IP spoofing"
# - Activer le routage des paquets IP
# - Enregistrer les paquets martiens (paquets avec des adresses impossibles)

echo "
net.ipv4.conf.default.rp_filter=1
net.ipv4.conf.all.rp_filter=1
net.ipv4.ip_forward=1
net.ipv4.conf.all.log_martians = 1
" >> /etc/sysctl.conf

# Applique les modifications récentes à sysctl.conf
sysctl -p

###############################################################################

DEBIAN_FRONTEND=noninteractive apt-get install iptables-persistent -y

iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE

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
#sed -i 's/vrrpd=no/vrrpd=yes/' /etc/frr/daemons

#set hostname
echo "hostname R1" >> /etc/frr/vtysh.conf

echo " 
!
ip route 0.0.0.0/0 eth0
!
interface eth3
 ip ospf priority 110
exit
!
router ospf
 ospf router-id 20.10.30.20
 network 20.20.10.0/24 area 400
 network 20.20.20.0/24 area 400
 network 20.20.30.0/24 area 400
 default-information originate
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