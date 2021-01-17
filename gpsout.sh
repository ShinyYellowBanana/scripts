#!/bin/sh

sudo gpsd /dev/ttyUSB0 -F /var/run/gpsd.sock
sudo systemctl stop gpsd.socket
sudo systemctl disable gpsd.socket

exec 2>/dev/null
# get positions
gpstmp=/tmp/gps.data
gpspipe -w -n 40 >$gpstmp"1"&
ppid=$!
sleep 10
kill -9 $ppid
cat $gpstmp"1"|grep -om1 "[-]\?[[:digit:]]\{1,3\}\.[[:digit:]]\{9\}" >$gpstmp
size=$(stat -c%s $gpstmp)
if [ $size -gt 10 ]; then
   cat $gpstmp|sed -n -e 1p >/tmp/gps.lat
   cat $gpstmp|sed -n -e 1p
   cat $gpstmp|sed -n -e 2p >/tmp/gps.lon
   cat $gpstmp|sed -n -e 2p
fi
rm $gpstmp $gpstmp"1" 

