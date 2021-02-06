#!/bin/sh

#Print Commands
set +x
set -o xtrace

sudo apt install msmtp -y
read -p 'Email Address(Gmail Only): ' emailaddy
echo $emailaddy
read -p 'APP Pasword: ' appPassword
echo $appPassword
msmtp --configure $emailaddy > msmtprc
echo "account default : $emailaddy" >> msmtprc
sed -i "s/passwordeval.*/password ${appPassword}/g" msmtprc
sudo mv msmtprc /etc/
#APP PASWORD NEEDED FROM GMAIL
###########################################sudo pico /etc/msmtprc
echo -e "Subject: Setup Complete\r\n\r\nThis is a test mail to confirm the completion of email setup." | msmtp $emailaddy