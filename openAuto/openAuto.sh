#!/bin/sh

var=1
PID=$!

while(true);do
	if lsusb | grep -q "LG Electronics, Inc." ;then
		echo "LG Phone Plugged in. $var"
		var=$((var+1))
		if [ $var=="2" ];then
			sudo /home/pi/openauto/bin/autoapp
			if lsusb | grep -q "LG Electronics, Inc." ;then
				#Still connected
				echo "$var"
				break
			else
				echo "SHUTDOWN"
				sudo shutdown now
				exit
			fi
		fi
		
	fi
done
