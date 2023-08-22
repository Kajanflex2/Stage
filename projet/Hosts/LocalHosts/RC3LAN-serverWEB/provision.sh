#!/bin/bash
set -e

if [ -z $SNSTERGUARD ] ; then exit 1; fi
DIR=`dirname $0`
cd `dirname $0`

#####################################################################################

apt-get update

DEBIAN_FRONTEND=noninteractive apt-get install net-tools dnsutils nano gedit curl wget dnsutils xfce4 php -y

#echo "172.16.110.10     www.snsterproject.fr" >> /etc/hosts

#curl --max-time 2 -f -I http://172.16.110.10/

#####################################################################################

# do something visible
apt-get update

DEBIAN_FRONTEND=noninteractive apt-get install apache2 -y

#curl --max-time 2 -f -I http://172.16.110.10/

# manage isp-a.milxc zone
#DEBIAN_FRONTEND=noninteractive apt-get install -y certbot python3-certbot-apache

#DEBIAN_FRONTEND=noninteractive apt-get install -y unbound
mv /var/www/html/index.html /var/www/html/index.html.back  

cp -r watchmovies/  /var/www/html/watchmovies

#####################################################################################

#mkdir /etc/apache2/sites-available/tonytechstore

echo -e "
# Ecouter sur toutes les interfaces réseau sur le port 80
<VirtualHost *:80>
    # Répertoire des pages Web du site
    # Ce répertoire doit exister ...
    DocumentRoot \"/var/www/html/watchmovies\"
    # Nom de domaine du site
    ServerName www.watchmovies.movie
    # Configuration du répertoire
    <Directory \"/var/www/html/watchmovies\">
        Options Indexes FollowSymLinks
        AllowOverride None
        Require all granted
    </Directory>
</VirtualHost>
" > /etc/apache2/sites-available/watchmovies.conf

#####################################################################################

a2ensite watchmovies.conf

#####################################################################################

chmod  -R  755 /var/www/html/watchmovies/

#####################################################################################

systemctl reload apache2

#####################################################################################

systemctl restart apache2

#####################################################################################