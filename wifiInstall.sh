#!/bin/sh
##git clone https://github.com/ShinyYellowBanana/scripts.git
##curl https://raw.githubusercontent.com/ShinyYellowBanana/scripts/master/wifiInstall.sh | bash

#Print Commands
set +x
set -o xtrace

##Distrobution ID
DIS_ID1=`cat /etc/os-release | sed -n 's/ID_LIKE=//p'` ##Ex. (debian,)
DIS_ID2=`lsb_release -i | sed -n 's/Distributor ID:\t//p'` ##Ex. (Raspbian, Ubuntu)
USER=`whoami`

if [ $DIS_ID1 = 'debian' ];then
	
	#Update/Upgrade/Remove
	sudo apt update -y
	sudo apt full-upgrade -y
	sudo apt autoremove -y
	sudo apt autoclean -y

	#Install Important Packages
	sudo apt install xterm -y
	sudo apt-get install xinput-calibrator -y
	sudo apt install bc -y
	sudo apt install git -y
	sudo apt-get install lsb-core -y
	sudo apt install dos2unix -y
	sudo apt install curl -y
	sudo apt install net-tools -y ##Ubuntu

	#BrosTrend1200L Installer ##Pass "ENTER" then "q"
	echo -ne '\n q' | sudo sh -c 'wget deb.trendtechcn.com/installer.sh -O /tmp/installer.sh && sh /tmp/installer.sh'
	sudo dpkg --configure -a

	#VNC Install
	sudo apt install realvnc-vnc-server reallvnc-vnc-viewer


		
		if [ $DIS_ID2 = 'Raspbian' ];then
			#FAN HAT(ARGON)
			curl https://download.argon40.com/argon1.sh | bash
			#Force HDMI on RPi Devices
			sudo sed -i "s/#hdmi_force_hotplug=1/hdmi_force_hotplug=1/" /boot/config.txt
			sudo sed -i "s/#hdmi_safe=1/hdmi_safe=1/" /boot/config.txt
		
		elif [ $DIS_ID2 = 'Ubuntu' ];then
			sudo apt install openssh-server -y
			sudo ufw allow ssh
		else
			echo WARNING: Unsupported Distrobution.
		fi
		
		
fi
#TOUCH SCREEN

#BLNKT LED

#BASH GIT PROMPT
cd ~
if [ -d "/home/$USER/.bash-git-prompt" ]; then
	echo "Found: Skipping installation of Enhanced GitHub"
else
	git clone https://github.com/magicmonty/bash-git-prompt.git ~/.bash-git-prompt --depth=1
fi

if grep -q "bash-git-prompt" .bashrc; then
	echo "Found: Skipping edit"
else
    echo "##GIT HUB ENHANCED VIEW\nif [ -f "$HOME/.bash-git-prompt/gitprompt.sh" ]; then\n    GIT_PROMPT_ONLY_IN_REPO=1\n    source $HOME/.bash-git-prompt/gitprompt.sh\nfi" >> ~/.bashrc
fi

git config --global user.email "matthew.steven.welch@gmail.com"
git config --global user.name "Matthew Welch"

#Remove script ./wifiInstal on Desktop
if [ -f "/home/$USER/Desktop/wifiInstall.sh" ]; then
	echo "Found: Removeing file (wifiInstall.sh)"
	rm -rf /home/$USER/Desktop/wifiInstall.sh
else
	echo "Not Found: Skipping removal of file (wifiInstall.sh)"
fi

#Install Personal GIT HUB
if [ -d "/home/$USER/Desktop/scripts" ]; then
	echo "Found: Skipping installation of personal GitHub"
else
	cd /home/$USER/Desktop/
	git clone https://github.com/ShinyYellowBanana/scripts.git
fi





#Sleep
sleep 15

#Reboot
sudo reboot