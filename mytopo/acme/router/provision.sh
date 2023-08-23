#!/bin/sh

# Arrête le script si une commande échoue et active l'utilisation non autorisée des variables non définies. 
set -eu

# Vérifie si la variable SNSTERGUARD est définie, sinon quitte avec une erreur.
if [ -z $SNSTERGUARD ] ; then exit 1; fi

# Obtient le répertoire du script et change pour ce répertoire.
DIR=`dirname $0`
cd `dirname $0`

###############################################################################

# Permet d’activer le routage IP sous linux.
echo "net.ipv4.ip_forward=1" >> /etc/sysctl.conf

sysctl -p

###############################################################################

# Permet de mettre à jour les packages du système.
apk update

# Permet d'installer des packages supplémentaires.
apk add nano net-tools iptables

# Permet de configurer iptables pour qu'il démarre au démarrage.
rc-update add iptables

# Définir les variables à ajouter dans la règle de translation d'adresse. Carte réseau du routeur relié à l'internet (via lxcbr0).

acme_router="eth0"
acme_dmz="172.16.110.0/24"
acme_client="192.168.1.0/24"

#les règles NAT
iptables -t nat -A POSTROUTING -s $acme_dmz -o $acme_router  -j MASQUERADE
iptables -t nat -A POSTROUTING -s $acme_client -o $acme_router  -j MASQUERADE

###############################################################################

# Permet de sauvegarder les règles iptables
/etc/init.d/iptables save

###############################################################################

# Permet de redémarrer le service iptables pour appliquer les changements
/etc/init.d/iptables restart

###############################################################################

# Permet de démarre le service iptables.
rc-service iptables start

###############################################################################