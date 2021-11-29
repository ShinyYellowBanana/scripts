#!/bin/bash

sudo docker pull portainer/portainer-ce:latest
sudo docker run -d -p 9000:9000 --name=portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:latest

until [ "$(curl --silent --show-error --connect-timeout 1 -I http://localhost:9000 | grep '200 OK')" ];
do
  echo --- Waiting for portainer, please wait...
  sleep 10
done
echo "Site is up at http://localhost:9000"
