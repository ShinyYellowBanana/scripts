#!/bin/bash

#Print Commands
set +x
set -o xtrace

sudo apt install msmtp
read -p 'Email Address(Gmail Only): ' emailaddy
echo $emailaddy
read -p 'APP Pasword: ' appPassword
echo $appPassword
msmtp --configure $emailaddy > msmtprc
echo "account default : $emailaddy" >> msmtprc
sed -i 's/passwordeval.*/password ${appPassword}/g' msmtprc
sudo mv msmtprc /etc/
#APP PASWORD NEEDED FROM GMAIL
sudo pico /etc/msmtprc
echo "Email has been set up on device" | msmtp -v $emailaddy