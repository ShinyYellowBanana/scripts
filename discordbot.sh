#!/bin/bash

#Print Commands
set +x
set -o xtrace

if [ -z "$1" ]
then
  read -t 5 MESSAGE
  echo $MESSAGE
else
  MESSAGE=$1
fi
NAME=`hostname`
IP=`ifconfig eth0 | head -n 2 | tail -n 1 | grep -o -P '(?<=inet).*(?=netmask)' | xargs echo -n`
API_KEY1="1055639875153571894/7Ki33IopVprYYxkd-p4hUDn18Fl_"
API_KEY2="1lpkHW-ZnDHYzm8OYJKGwIsHXy5l3eBV5hPZbb4h"
API_KEY=$(echo -e "$API_KEY1\c")$API_KEY2
echo $AP
export WEBHOOK_URL="https://discord.com/api/webhooks/"+$API_KEY
curl \
  -H "Content-Type: application/json" \
  -d "{\"username\": \"${NAME} (${IP})\", \"content\": \"$MESSAGE\"}" \
  $WEBHOOK_URL
