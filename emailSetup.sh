#!/bin/bash

#Print Commands
set +x
set -o xtrace

sudo apt install msmtp
read -p 'Email Address: ' $emailaddy
msmtp --configure $emailaddy > msmtprc
echo "account default : $emailaddy" >> msmtprc
sed -i 's/passwordeval.*/password XXX/g' msmtprc
sed -i 's/# -.*/### Just replace XXX with your app password/g' msmtprc
sed -i 's/#  .*/### and press Ctrl-X to quit and save/g' msmtprc
sudo cp msmtprc /etc/
#APP PASWORD NEEDED FROM GMAIL
sudo pico /etc/msmtprc
echo "test message from honeyPi" | msmtp -vvv $emailaddy