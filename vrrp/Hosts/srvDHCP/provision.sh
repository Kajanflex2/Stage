#!/bin/bash
set -e

if [ -z $SNSTERGUARD ] ; then exit 1; fi
DIR=`dirname $0`
cd `dirname $0`

###############################################################################

# do something visible
#ip route add 0.0.0.0/0 via 192.168.1.254

apt-get update

DEBIAN_FRONTEND=noninteractive apt-get install net-tools nano gedit curl wget isc-dhcp-server  xfce4 dnsutils -y

###############################################################################

echo " 
nameserver 1.1.1.1
" > /etc/resolv.conf

###############################################################################

sed -i '/iface eth0 inet dhcp/ c\iface eth0 inet static\n  address 192.168.1.199/24\n  gateway 192.168.1.254' /etc/network/interfaces

###############################################################################

################################# DHCP ########################################

sed -i 's/INTERFACESv4=""/INTERFACESv4="eth0"/' /etc/default/isc-dhcp-server

echo "
# Notre configuration pour le réseau 192.168.1.0/24

subnet 192.168.1.0 netmask 255.255.255.0 {
    range 192.168.1.2 192.168.1.100;
    option domain-name-servers 1.1.1.1;
    option domain-name \"vrrp.tech\";
    option routers 192.168.1.254;
    option broadcast-address 192.168.1.255;
    default-lease-time 600;
    max-lease-time 7200;
}
" >> /etc/dhcp/dhcpd.conf

###############################################################################


#Il faut activer le serveur DHCP une fois que la machine est démarrée en utilisant la commande suivante :

#systemctl start isc-dhcp-server.service

###############################################################################