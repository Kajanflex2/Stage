#!/bin/bash
set -e

if [ -z $SNSTERGUARD ] ; then exit 1; fi
DIR=`dirname $0`
cd `dirname $0`

###############################################################################

# do something visible
apt-get update

DEBIAN_FRONTEND=noninteractive apt-get install net-tools nano apache2 gedit  xfce4 dnsutils wireshark -y

###############################################################################

# manage isp-a.milxc zone
#DEBIAN_FRONTEND=noninteractive apt-get install -y certbot python3-certbot-apache

#DEBIAN_FRONTEND=noninteractive apt-get install -y unbound
cp /var/www/html/index.html /var/www/html/index.html.back  

cp -rT google-clone/  /var/www/html/

systemctl restart apache2

###############################################################################

echo " 
nameserver 1.1.1.1
" > /etc/resolv.conf

###############################################################################

sed -i '/iface eth0 inet dhcp/ c\iface eth0 inet static\n  address 172.16.111.10/24\n  gateway 172.16.111.254' /etc/network/interfaces

###############################################################################
