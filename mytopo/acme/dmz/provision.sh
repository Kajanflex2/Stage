#!/bin/bash
set -e

if [ -z $SNSTERGUARD ] ; then exit 1; fi

DIR=`dirname $0`
cd `dirname $0`

###############################################################################

#Met à jour la liste des packages disponibles.
apt-get update

#Installe les outils nécessaires sans interaction utilisateur.
DEBIAN_FRONTEND=noninteractive apt-get install net-tools nano apache2 gedit xfce4 dnsutils wireshark -y

###############################################################################

# Crée une copie de sauvegarde du fichier index.html
cp /var/www/html/index.html /var/www/html/index.html.back  

###############################################################################

# Copie le contenu du répertoire google-clone vers /var/www/html/
cp -rT google-clone/  /var/www/html/

#-r :  permet de copier le répertoire et tout son contenu (sous-répertoires et fichiers).
#-T : permet de copier uniquement les fichiers et les dossiers se trouvant à l'intérieur du répertoire source, mais pas le répertoire source lui-même.

###############################################################################

# Redémarre le service Apache2 pour prendre en compte les changements
systemctl restart apache2

###############################################################################