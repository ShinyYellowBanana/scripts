#!/bin/bash

#Print Commands
set +x
set -o xtrace


cd ~
sudo apt update
sudo apt install python3-pip python3-dev python3-setuptools python3-venv git libyaml-dev build-essential
mkdir OctoPrint && cd OctoPrint
python3 -m venv venv
source venv/bin/activate
pip install pip --upgrade
pip install octoprint
sudo usermod -a -G tty pi
sudo usermod -a -G dialout pi
~/OctoPrint/venv/bin/octoprint serve
