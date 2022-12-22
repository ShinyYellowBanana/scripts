#!/bin/bash

#Print Commands
set +x
set -o xtrace

if [ -z "$1" ]
then
  read -t 1 MESSAGE
else
  MESSAGE=$1
fi
NAME=`hostname`
IP=`ifconfig eth0 | head -n 2 | tail -n 1 | grep -o -P '(?<=inet).*(?=netmask)' | xargs echo -n`

# -H "Content-Type: application/json" - adds header that tells server you're sending JSON data.
# -d '{"username": "test", "content": "hello"}' - sets request data.
# Using -d also sets method to POST, so -X POST can be ommited.
curl -H "Content-Type: application/json" -d '{"username": "test", "content": "hello"}' "https://discord.com/api/webhooks/123/w3bh00k_t0k3n"


# To make command more readable you can split it to multiple lines using backslash `\`
# and set webhook url as variable, so you don't need to paste it over and over again.
# Also you can add the variable to your `.*rc` file, so it persists on console reloads.
export WEBHOOK_URL="https://discord.com/api/webhooks/1055317749825536052/Ktdq23SGpHr9UXVlbQXJQGLg786CFroLqcTXv-0hDxn71Vz9xliUE5_IBS4ssoju4a58"
curl \
  -H "Content-Type: application/json" \
  -d "{\"username\": \"${NAME} (${IP})\", \"content\": \"$MESSAGE\"}" \
  $WEBHOOK_URL