#!/bin/bash

#Print Commands
set +x
set -o xtrace

sudo apt install smbclient cifs-utils

if [ -d "/mnt/NAS/" ]; then
	#Exists
  sudo mount -t cifs -o vers=3.0,username=huser '\\192.168.2.10\BackupMAX' /mnt/NAS/
else 
  sudo mkdir /mnt/NAS/
  sudo mount -t cifs -o vers=3.0,username=huser '\\192.168.2.10\BackupMAX' /mnt/NAS/
fi
