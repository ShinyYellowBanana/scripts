#!/bin/bash
##git clone https://github.com/ShinyYellowBanana/scripts.git
##curl https://raw.githubusercontent.com/ShinyYellowBanana/scripts/master/wifiInstall.sh | bash

#Print Commands
set +x
set -o xtrace

##Distrobution ID
DIS_ID1=`cat /etc/os-release | sed -n 's/ID_LIKE=//p'` ##Ex. (debian,)
DIS_ID2=`lsb_release -i | sed -n 's/Distributor ID:\t//p'` ##Ex. (Raspbian, Ubuntu)
USER=`whoami`
HOSTNAME=`hostname`

#Ensure execute from git branch

if [ -d "/home/$USER/Desktop/scripts" ]; then
	#Exists
	echo "Found: scripts"
	#Check if build is behind
	cd /home/$USER/Desktop/scripts
	git status
	CURRENT_BUILD=`git rev-list --count HEAD` ##Build Number
	LATEST_BUILD=`git rev-list --count origin/HEAD`
	BRANCH=`git rev-parse --abbrev-ref HEAD` ##Branch Name
	if [ "$CURRENT_BUILD" -ne "$LATEST_BUILD" ];then
		git pull
		exit
	fi
else 
	#Skip git pull because update is found
	echo "Found!"
fi


if [ $DIS_ID1 = 'debian' ];then

	#Move To Home Directory
	cd

	#Uninstall Packages
	sudo apt-get --purge remove bluej claws-mail code-the-classics greenfoot-unbundled \
		minecraft-pi mu-editor python-games \
		scratch scratch2 scratch3 sonic-pi \
		smartsim sense-hat nodered -y	

	#Install Important Packages
	sudo apt install xterm bc git dos2unix curl net-tools arp-scan htop nmap -y ##Ubuntu

	sudo apt-get install xinput-calibrator lsb-core -y

	#Update/Upgrade/Remove
	sudo apt update -y
	sudo apt full-upgrade -y
	sudo apt autoremove -y
	sudo apt autoclean -y

	#BrosTrend1200L Installer ##Pass "ENTER" then "q"
	#ID 0bda:b812 Realtek Semiconductor Corp.
	if lsusb | grep -q "Realtek Semiconductor Corp." ;then
		echo -ne '\n q' | sudo sh -c 'wget deb.trendtechcn.com/installer.sh -O /tmp/installer.sh && sh /tmp/installer.sh'
		sudo dpkg --configure -a
	fi
	
	#GPS
	#ID 067b:2303 Prolific Technology, Inc. PL2303 Serial Port
	if lsusb | grep -q "Prolific Technology" ;then
		sudo apt-get install gpsd gpsd-clients -y
		sudo systemctl stop gpsd.socket
		sudo systemctl disable gpsd.socket
		sudo gpsd /dev/ttyUSB0 -F /var/run/gpsd.sock
	fi
	
	#VNC Install
	sudo apt install realvnc-vnc-server realvnc-vnc-viewer -y


		if [ $DIS_ID2 = 'Raspbian' ];then
			#FAN HAT(ARGON)
			curl https://download.argon40.com/argon1.sh | bash

			#BLINKT
			#curl https://get.pimoroni.com/blinkt | bash  ##or
			sudo apt-get install python3-blinkt libwidevinecdm0 -y
			
			#Force HDMI on RPi Devices
			sudo sed -i "s/#hdmi_force_hotplug=1/hdmi_force_hotplug=1/" /boot/config.txt
			sudo sed -i "s/#hdmi_safe=1/hdmi_safe=1/" /boot/config.txt
			
			##Check GPIO
			#RP4 needs manual update.
			cd /tmp
			wget https://project-downloads.drogon.net/wiringpi-latest.deb
			sudo dpkg -i wiringpi-latest.deb


			##TOUCH SCREEN
			if [ -d "/home/$USER/Elcrow-LCD5" ]; then
				cd
				git clone https://github.com/Elecrow-keen/Elecrow-LCD5.git
				cd /home/$USER/Elecrow-LCD5/Elecrow-LCD5
				pwd
				sudo chmod +x Elecrow-LCD5
				sed '$d' Elecrow-LCD5 | bash #Delete Reboot line
				cd
			else 
				echo "Found: Skipping installation of Touchscreen"
			fi

			
			##Enable SSH
			sudo systemctl enable ssh
			sudo systemctl start ssh #Stopped here on fresh install?
			
			##Firmware Update for Raspberry Pi
			#https://www.raspberrypi.org/documentation/raspbian/applications/rpi-update.md
			#sudo SKIP_WARNING=1 rpi-update

		elif [ $DIS_ID2 = 'Ubuntu' ];then
			sudo adduser $USER sudo
			sudo apt install openssh-server -y
			sudo ufw allow ssh
		else
			echo WARNING: Unsupported Distrobution.
		fi
fi

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
    echo "##GIT HUB ENHANCED VIEW" >> ~/.bashrc
	echo "if [ -f "$HOME/.bash-git-prompt/gitprompt.sh" ]; then" >> ~/.bashrc
	echo "	GIT_PROMPT_ONLY_IN_REPO=1" >> ~/.bashrc
	echo "	source $HOME/.bash-git-prompt/gitprompt.sh" >> ~/.bashrc
	echo "fi" >> ~/.bashrc
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
sleep 30

##LOOK UP WHIPTAIL

#Reboot
sudo reboot
