#!/bin/bash

##while :; do echo `date +"%Y-%m-%d %T"`','`vcgencmd measure_temp | tail -c +6`; sleep 1; done

TEMPALARM=75
TIME=`date` 
HOSTNAME=`hostname` 

echo -n "Starting" 
for i in {1..3} 
do
	sleep 0.5 
	echo -n . 
done 
while(true) 
do 
	TEMP=`vcgencmd measure_temp | egrep -o '[0-9]*\.[0-9]*'`
	while (( $(echo	"$TEMP <= $TEMPALARM" | bc -l) )) 
	do
		TIME=`date`
		TEMP=`vcgencmd measure_temp | egrep -o '[0-9]*\.[0-9]*'` 
		echo "" 
		echo $TIME 
		echo $TEMP
		echo "--------------------" 
		sleep 20 
	done 
	curl -X POST https://textbelt.com/text --data-urlencode phone='7726315244' --data-urlencode message="Machine ${HOSTNAME} reached a temperture of ${TEMP}" -d key=textbelt
	#sudo shutdown now
done

#This only works for Raspbian

#For UbuntuW
#sudo apt install hddtemp lm-sensors
#(parse) sensors
