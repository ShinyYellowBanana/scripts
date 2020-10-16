#!/bin/sh

#Print Commands
set +x
set -o xtrace

##Distrobution ID
DIS_ID1=`cat /etc/os-release | sed -n 's/ID_LIKE=//p'` ##Ex. (debian,)
DIS_ID2=`lsb_release -i | sed -n 's/Distributor ID:\t//p'` ##Ex. (Raspbian,)
USER=`whoami`

if [ $DIS_ID1 == 'debian' ];then
	
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
	sudo apt-get install lsb-core

	#BrosTrend1200L Installer
	sudo sh -c 'wget deb.trendtechcn.com/installer.sh -O /tmp/installer.sh && sh /tmp/installer.sh'
	sudo dpkg --configure -a

	#VNC Install
	sudo apt install realvnc-vnc-server reallvnc-vnc-viewer


		#FAN HAT(ARGON)
		if [ $DIS_ID2 == 'Raspbian' ];then
			curl https://download.argon40.com/argon1.sh | bash
		fi
fi
#TOUCH SCREEN

#BLNKT LED

#BASH GIT PROMPT
cd ~
if [ -d "/home/$USER/.bash-git-prompt" ];then
	git clone https://github.com/magicmonty/bash-git-prompt.git ~/.bash-git-prompt --depth=1
fi

if grep -q "bash-git-prompt" .bashrc; then
    #echo found
	exit
else
    echo "if [ -f "$HOME/.bash-git-prompt/gitprompt.sh" ]; then\n    GIT_PROMPT_ONLY_IN_REPO=1\n    source $HOME/.bash-git-prompt/gitprompt.sh\nfi" >> ~/.bashrc
fi




#Install Personal GIT HUB
cd Desktop/
git clone https://github.com/ShinyYellowBanana/scripts.git

#Reboot
#sudo reboot