#!/bin/bash

sudo apt-get install apt-transport-https ca-certificates software-properties-common -y
curl -fsSL get.docker.com -o get-docker.sh && sh get-docker.sh
sudo usermod -aG docker pi
sudo curl https://download.docker.com/linux/raspbian/gpg
sudo echo "deb https://download.docker.com/linux/raspbian/ stretch stable" >> sudo  /etc/apt/sources.list sudo apt-get update
sudo apt-get upgrade -y
systemctl start docker.service
docker info
docker run hello-world
sudo rm -rf get-docker.sh
