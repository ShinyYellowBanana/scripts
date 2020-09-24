#!/bin/sh

#Update/Upgrade/Remove
sudo apt update -y
sudo apt upgrade -y
sudo apt autoremove -y
sudo apt autoclean -y

#Install Important Packages
sudo apt install xterm
sudo apt-get install xinput-calibrator
sudo apt install bc
sudo apt install git

#BrosTrend1200L Installer
sudo sh -c 'wget deb.trendtechcn.com/installer.sh -O /tmp/installer.sh && sh /tmp/installer.sh'
sudo dpkg --configure -a

#VNC Install
sudo apt install realvnc-vnc-server reallvnc-vnc-viewer
sudo raspi-config

#FAN HAT(ARGON)
curl https://download.argon40.com/argon1.sh | bash

#TOUCH SCREEN

#BLNKT LED

#Reboot
sudo reboot