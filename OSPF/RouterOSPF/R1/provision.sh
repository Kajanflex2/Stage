#!/bin/bash
set -e

if [ -z $SNSTERGUARD ] ; then exit 1; fi
DIR=`dirname $0`
cd `dirname $0`

###############################################################################
apt-get update

DEBIAN_FRONTEND=noninteractive apt-get install net-tools nano gedit wireshark openssh-server  xfce4 dnsutils -y

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

###############################################################################

# Configurer eth0 avec une adresse IP statique
sed -i '/iface eth0 inet dhcp/ c\iface eth0 inet static\n  address 172.16.111.254/24' /etc/network/interfaces

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

echo "hostname R1" >> /etc/frr/vtysh.conf

echo " 
!
interface eth2
 ip ospf priority 110
exit
!
router ospf
 ospf router-id 1.1.1.1
 network 10.0.1.0/24 area 200
 network 10.0.2.0/24 area 200
 network 172.16.111.0/24 area 200
exit
!
" >> /etc/frr/frr.conf

###############################################################################

# Activer le service FRR au démarrage
systemctl enable frr.service

# Redémarrer le service FRR
service frr restart

systemctl restart frr.service

###############################################################################


