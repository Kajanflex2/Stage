#!/bin/bash
set -e
if [ -z $SNSTERGUARD ] ; then exit 1; fi
DIR=`dirname $0`
cd `dirname $0`

apt-get update

#Installer les paquets nécessaires
DEBIAN_FRONTEND=noninteractive apt-get install net-tools nano gedit curl wget xfce4 dnsutils -y

###############################################################################

# Activer la vérification du chemin retour (RP Filter) par défaut pour éviter le spoofing d'adresse IP.
# Activer la vérification du chemin retour pour toutes les interfaces.
# Autoriser le routage de paquets IP (IP forwarding) sur cette machin.
# Enregistrer  les paquets avec des adresses source qui ne devraient pas être routables (martians).

echo "
net.ipv4.conf.default.rp_filter=1
net.ipv4.conf.all.rp_filter=1
net.ipv4.ip_forward=1
net.ipv4.conf.all.log_martians = 1
" >> /etc/sysctl.conf

#Appliquer les modifications sysctl
sysctl -p

#sysctl -w net.ipv4.conf.eth0.ignore_routes_with_linkdown=1

###############################################################################

# Crée l'interface vrrp4-2-3 comme une macvlan en mode bridge sur l'interface eth0
# Définit l'adresse MAC de l'interface vrrp4-2-3
# Attribue une adresse IP à l'interface vrrp4-2-3
# Active l'interface vrrp4-2-3

echo "

auto vrrp4-2-3
iface vrrp4-2-3 inet static
    pre-up ip link add vrrp4-2-3 link eth0 addrgenmode random type macvlan mode bridge
    pre-up ip link set dev vrrp4-2-3 address 00:00:5e:00:01:05
    address 192.168.1.254/24
    up ip link set dev vrrp4-2-3 up
" >> /etc/network/interfaces

# Active l'interface vrrp4-2-3
ifup vrrp4-2-3

###############################################################################

# Configurer eth0 avec une adresse IP statique
sed -i '/iface eth0 inet dhcp/ c\iface eth0 inet static\n  address 192.168.1.250/24' /etc/network/interfaces

###############################################################################

# Ajouter la clé GPG pour le dépôt FRR
#__add GPG key
curl -s https://deb.frrouting.org/frr/keys.gpg | tee /usr/share/keyrings/frrouting.gpg > /dev/null

# Configurer le dépôt pour FRR
#__possible values for FRRVER: frr-6 frr-7 frr-8 frr-stable
#__frr-stable will be the latest official stable release
FRRVER="frr-8"
echo deb '[signed-by=/usr/share/keyrings/frrouting.gpg]' https://deb.frrouting.org/frr $(lsb_release -s -c) $FRRVER | tee -a /etc/apt/sources.list.d/frr.list

###############################################################################

# Mettre à jour la liste des paquets
apt-get update

# Installer FRR
#__update and install FRR
DEBIAN_FRONTEND=noninteractive apt-get install frr frr-pythontools -y

###############################################################################

# Activer OSPFv2 dans la configuration des démons FRR
sed -i 's/ospfd=no/ospfd=yes/' /etc/frr/daemons

#Activer VRRP dans la configuration des démons FRR
sed -i 's/vrrpd=no/vrrpd=yes/' /etc/frr/daemons

#Configurer le nom d'hôte pour VTYSH
echo "hostname R4" >> /etc/frr/vtysh.conf

echo " 
!
interface eth0
 vrrp 5 version 3
 vrrp 5 priority 250
 vrrp 5 advertisement-interval 1000
 vrrp 5 ip 192.168.1.254
exit
!
router ospf
 ospf router-id 20.30.50.1
 network 20.20.30.0/24 area 400
 network 20.20.50.0/24 area 400
 network 20.20.60.0/24 area 400
 network 192.168.1.0/24 area 400
exit
!
" >> /etc/frr/frr.conf

###############################################################################

# Activer le service FRR au démarrage
systemctl enable frr.service

###############################################################################

# Redémarrer le service FRR

service frr restart

systemctl restart frr.service

###############################################################################

# Configure le kernel pour ignorer les routes associées à l'interface eth0 lorsque le lien est inactif
sysctl -w net.ipv4.conf.eth0.ignore_routes_with_linkdown=1

###############################################################################