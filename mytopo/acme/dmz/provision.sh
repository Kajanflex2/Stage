#!/bin/bash
set -e

if [ -z $SNSTERGUARD ] ; then exit 1; fi

DIR=`dirname $0`
cd `dirname $0`

###############################################################################

apt-get update

DEBIAN_FRONTEND=noninteractive apt-get install net-tools nano apache2 gedit fce4 dnsutils wireshark -y

###############################################################################

# manage isp-a.milxc zone
#DEBIAN_FRONTEND=noninteractive apt-get install -y certbot python3-certbot-apache

#DEBIAN_FRONTEND=noninteractive apt-get install -y unbound


# Crée une copie de sauvegarde du fichier index.html
cp /var/www/html/index.html /var/www/html/index.html.back  

###############################################################################

# Copie le contenu du répertoire google-clone vers /var/www/html/
cp -rT google-clone/  /var/www/html/

###############################################################################

# Redémarre le service Apache2 pour prendre en compte les changements
systemctl restart apache2

###############################################################################