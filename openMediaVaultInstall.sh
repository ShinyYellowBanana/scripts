#!/bin/bash

#Print Commands
set +x
set -o xtrace

##Distrobution ID
DIS_ID1=`cat /etc/os-release | sed -n 's/ID_LIKE=//p'` ##Ex. (debian,)
DIS_ID2=`lsb_release -i | sed -n 's/Distributor ID:\t//p'` ##Ex. (Raspbian, Ubuntu)
USER=`whoami`
HOSTNAME=`hostname`


cd ..
wget https://github.com/OpenMediaVault-Plugin-Developers/installScript/raw/master/install
chmod +x install
sudo bash ./install

#Abort reboot then remove install file then reboot
#rm -rf install


##MORE INFO
#https://linuxhint.com/raspberry_pi_open_media_vault/
#https://www.howtoforge.com/tutorial/install-open-media-vault-nas/
