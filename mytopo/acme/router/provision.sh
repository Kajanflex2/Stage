#!/bin/sh

# Arrête le script si une commande échoue et activez l'utilisation non autorisée des variables non définies
set -eu

# Vérifie si la variable SNSTERGUARD est définie, sinon quittez avec une erreur
if [ -z $SNSTERGUARD ] ; then exit 1; fi

# Obtenant le répertoire du script et changez de répertoire pour ce répertoire
DIR=`dirname $0`
cd `dirname $0`

###############################################################################

# Activer le routage IP
echo "net.ipv4.ip_forward=1" >> /etc/sysctl.conf

sysctl -p

###############################################################################

## Mise à jour les packages du système
apk update

# Installe des packages supplémentaires
apk add nano net-tools iptables

#Load the iptables kernel modules
#modprobe -v ip_tables
#modprobe -v iptable_nat
#insmod /lib/modules/5.4.43-1-virt/kernel/net/ipv4/netfilter/ip_tables.ko

#/var/lib/lxc/

# Configuration d'iptables pour démarrer au démarrage
#Autostart the firewall at boot time and autoload the Linux kernel modules 
rc-update add iptables

#Ajouter une règle de translation d'adresse
acme_router="eth0"
acme_dmz="172.16.110.0/24"
acme_client="192.168.1.0/24"

#les règles NAT
iptables -t nat -A POSTROUTING -s $acme_dmz -o $acme_router  -j MASQUERADE
iptables -t nat -A POSTROUTING -s $acme_client -o $acme_router  -j MASQUERADE

###############################################################################

#Sauvegarde les règles iptables
/etc/init.d/iptables save

###############################################################################

#Redémarre le service iptables pour appliquer les changements
/etc/init.d/iptables restart

###############################################################################

#Démarre le service iptables 
rc-service iptables start

###############################################################################