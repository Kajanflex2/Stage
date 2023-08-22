#!/bin/bash
set -e

if [ -z $SNSTERGUARD ] ; then exit 1; fi
DIR=`dirname $0`
cd `dirname $0`

# do something visible
#ip route add 0.0.0.0/0 via 192.168.1.254

#####################################################################################

apt-get update

DEBIAN_FRONTEND=noninteractive apt-get install net-tools dnsutils nano gedit curl wget dnsutils xfce4 php -y

#echo "172.16.110.10     www.snsterproject.fr" >> /etc/hosts

#curl --max-time 2 -f -I http://172.16.110.10/

#####################################################################################

# do something visible
apt-get update

DEBIAN_FRONTEND=noninteractive apt-get install apache2 -y

# manage isp-a.milxc zone
#DEBIAN_FRONTEND=noninteractive apt-get install -y certbot python3-certbot-apache

#DEBIAN_FRONTEND=noninteractive apt-get install -y unbound
mv /var/www/html/index.html /var/www/html/index.html.back  

cp -rT tonytechstore/  /var/www/html/tonytechstore

chmod  -R  755 /var/www/html/tonytechstore/

#####################################################################################

#mkdir /etc/apache2/sites-available/tonytechstore

echo -e "
# Ecouter sur toutes les interfaces réseau sur le port 80
<VirtualHost *:80>
    # Répertoire des pages Web du site
    # Ce répertoire doit exister ...
    DocumentRoot \"/var/www/html/tonytechstore/pages\"
    # Nom de domaine du site
    ServerName www.tonytechstore.tech
    # Spécifiez acceuil.php comme la page d'accueil par défaut
    DirectoryIndex acceuil.php
    # Configuration du répertoire
    <Directory \"/var/www/html/tonytechstore/pages\">
        Options Indexes FollowSymLinks
        AllowOverride None
        Require all granted
    </Directory>
    #Alias
    Alias /css \"/var/www/html/tonytechstore/css\"
</VirtualHost>
" > /etc/apache2/sites-available/tonytechstore.conf

#####################################################################################

a2ensite tonytechstore.conf

#####################################################################################

systemctl reload apache2

#####################################################################################

systemctl restart apache2

#####################################################################################
