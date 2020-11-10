#!/bin/bash

echo -n "Starting" 
for i in {1..3} 
do
	sleep 0.5 
	echo -n . 
done 
while(true) 
do 
	IP=`hostname -I | awk '{print $1}'`
	TIME=`date` 
	HOSTNAME=`hostname` 
	while (( $(echo	"$TEMP == 192.168.2.2") )) 
	do
		echo $IP
		sleep 60 
	done 
	echo "ERROR: Flag Triggered"
	#curl -X POST https://textbelt.com/text --data-urlencode phone='7726315244' --data-urlencode message='Machine ${HOSTNAME} reached a temperture of ${TEMP}' -d key=textbelt
done
