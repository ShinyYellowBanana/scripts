#!/bin/sh

#GET YOUR IP
IPADDRESS=`ifconfig | sed -n 2p | sed -n -e 's/^.*inet //p' | sed 's/ .*//'`


echo -n "Starting" 
for i in {1..3} 
do
	sleep 0.5 
	echo -n . 
done 

echo "${IPADDRESS}"


if (( $( curl -k https://192.168.1.1 | grep -c "floorplanDeps" ) != 1 )) ;
then 
	echo "Investigating Issue"; 
	#curl -X POST https://textbelt.com/text --data-urlencode phone='7726315244' --data-urlencode message='Machine ${HOSTNAME} reached a temperture of ${TEMP}' -d key=textbelt
else 
	echo "Fully Operational"; 
	echo "${IPADDRESS}"
fi
	#curl -X POST https://textbelt.com/text --data-urlencode phone='7726315244' --data-urlencode message='Machine ${HOSTNAME} reached a temperture of ${TEMP}' -d key=textbelt











