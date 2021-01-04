#!/bin/sh

#Print Commands
set +x
set -o xtrace

##Distrobution ID
DIS_ID1=`cat /etc/os-release | sed -n 's/ID_LIKE=//p'` ##Ex. (debian,)
DIS_ID2=`lsb_release -i | sed -n 's/Distributor ID:\t//p'` ##Ex. (Raspbian, Ubuntu)
USER=`whoami`

#Python3 packages
sudo pip3 install adafruit-circuitpython-ssd1306
sudo pip3 install adafruit-circuitpython-framebuf
sudo pip3 install adafruit-circuitpython-rfm9x

#Font file
wget -O font5x8.bin https://github.com/adafruit/Adafruit_CircuitPython_framebuf/blob/master/examples/font5x8.bin?raw=true
