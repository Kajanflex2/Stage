#!/bin/bash
set -e

if [ -z $SNSTERGUARD ] ; then exit 1; fi
DIR=`dirname $0`
cd `dirname $0`

apt-get update

DEBIAN_FRONTEND=noninteractive apt-get install net-tools nano gedit wireshark openssh-server isc-dhcp-server xfce4 dnsutils -y

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

iptables-save >/etc/iptables/rules.v4

##############################################################################

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

echo "hostname RA2" >> /etc/frr/vtysh.conf

echo " 
!
router ospf
 ospf router-id 1.2.1.3
 network 10.10.2.0/24 area 100
 network 10.10.1.0/24 area 100
 network 192.168.1.0/24 area 100
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

sed -i '/iface eth0 inet dhcp/ c\iface eth0 inet static\n  address 192.168.1.254/24' /etc/network/interfaces

###############################################################################
################################# DHCP ########################################

sed -i 's/INTERFACESv4=""/INTERFACESv4="eth0"/' /etc/default/isc-dhcp-server

echo "
# Notre configuration pour le réseau 192.168.1.0/24

subnet 192.168.1.0 netmask 255.255.255.0 {
    range 192.168.1.10 192.168.1.50;
    option domain-name-servers 172.16.110.20;
    option domain-name \"tonytechstore.tech\";
    option routers 192.168.1.254;
    option broadcast-address 192.168.1.255;
    default-lease-time 600;
    max-lease-time 7200;
}
" >> /etc/dhcp/dhcpd.conf

#########################################################################################################

#Il faut activer le serveur DHCP une fois que la machine est démarrée en utilisant la commande suivante :

#systemctl start isc-dhcp-server.service

#########################################################################################################

#systemctl enable isc-dhcp-server.service

#rm /etc/init/isc-dhcp-server.override
#sleep 10

#/etc/init.d/isc-dhcp-server start

#service isc-dhcp-server start
#journalctl -xe

#tail –n 40 /var/log/syslog

#systemctl restart isc-dhcp-server.service

###############################################################################

