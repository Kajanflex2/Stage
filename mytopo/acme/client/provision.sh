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

# Ajoute une entrée pour www.goclone.fr avec l'adresse IP 172.16.110.10 au fichier /etc/hosts
echo "172.16.110.10     www.goclone.fr" >> /etc/hosts

#curl --max-time 2 -f -I http://172.16.110.10/

###############################################################################