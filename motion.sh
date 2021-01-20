#!/bin/sh/

sudo modprobe bcm2835-v4l2
sudo apt install motion
sudo service motion start
sudo nano /etc/motion/motion.conf
##Daemon = OFF to ON
##webcam_localhost = ON to OFF
##webcam_port = desired port number or 8088
##control_port = desired port number or 8089
sudo nano /etc/default/motion
##start_motion_daemon=no to yes
sudo service motion restart


#https://raspberry-valley.azurewebsites.net/Streaming-Video-with-Motion/
