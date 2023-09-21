#!/bin/bash
# OSPF router template
set -e

if [ -z $SNSTERGUARD ] ; then exit 1; fi
DIR=`dirname $0`
cd `dirname $0`

###############################################################################

apt-get update 

DEBIAN_FRONTEND=noninteractive apt-get install net-tools nano gedit wireshark openssh-server  xfce4 dnsutils -y

###############################################################################

echo "
net.ipv4.conf.default.rp_filter=1
net.ipv4.conf.all.rp_filter=1
net.ipv4.ip_forward=1
net.ipv4.conf.all.log_martians = 1
" >> /etc/sysctl.conf
sysctl -p

###############################################################################

#apt-get update
apt-get update 

#__add GPG key
curl -s https://deb.frrouting.org/frr/keys.gpg | tee /usr/share/keyrings/frrouting.gpg > /dev/null

#__possible values for FRRVER: frr-6 frr-7 frr-8 frr-stable
#__frr-stable will be the latest official stable release
FRRVER="frr-8"
echo deb '[signed-by=/usr/share/keyrings/frrouting.gpg]' https://deb.frrouting.org/frr $(lsb_release -s -c) $FRRVER | tee -a /etc/apt/sources.list.d/frr.list

###############################################################################


#__update and install FRR
DEBIAN_FRONTEND=noninteractive apt-get update && apt-get install frr frr-pythontools -y

#apt-get update --fix-missing

apt-get update

###############################################################################

#Activer OSPFv2
sed -i "s/ospfd=no/ospfd=$ospf_enable/" /etc/frr/daemons

echo "hostname $hostname" >> /etc/frr/vtysh.conf

# Internal Field Separator (IFS)
IFS=';'

#default route
echo "
!
ip route 0.0.0.0/0 $default_route_int
!
" >> /etc/frr/frr.conf

interfaces=($ospf_interface)
priorities=($ospf_priority)

length=${#interfaces[@]}

for (( i=0; i<$length; i++ ));
do
    int=${interfaces[$i]}
    prio=${priorities[$i]}
    
    echo "
    !
    interface $int
     ip ospf priority $prio
    exit
    !
    " >> /etc/frr/frr.conf
done

###############################################################################

ospfnetwork=($ospf_network)

netlength=${#ospfnetwork[@]}

echo "
!
router ospf
ospf router-id $ospf_routerid
" >> /etc/frr/frr.conf

for ((i=0; i<$netlength; i++));
do
    net=${ospfnetwork[$i]}
    echo "network $net" >> /etc/frr/frr.conf
done

if [[ $ospf_default_information == "yes" ]]; then
    echo "default-information originate always" >> /etc/frr/frr.conf
fi

echo "
exit
!
" >> /etc/frr/frr.conf


###############################################################################

systemctl enable frr.service

service frr restart

systemctl restart frr.service

###############################################################################
