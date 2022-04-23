#!/bin/bash

# definition of MAC addresses
TrueNAS=00:25:90:B9:E8:EF
Proxmox=18:C0:4D:90:49:B9
countdown=0

echo "Which PC to wake?"
echo "a) TrueNAS (192.168.2.10)"
echo "b) Proxmox (192.168.2.8)"
echo "c) quit"
read input1
case $input1 in
  a)
    echo -e $(echo $(printf 'f%.0s' {1..12}; printf "$(echo $TrueNAS | sed 's/://g')%.0s" {1..16}) | sed -e 's/../\\x&/g') | nc -w1 -u -b 255.255.255.255 4000
    echo -ne "TrueNAS BOOTING "
    while true
    do 
      ping -c1 192.168.2.10 > /dev/null && break;
      echo -ne "."
      let countdown++
      if [ $countdown -gt 10 ]
      then
        exit
      fi
    done
    ;;
  b)
    echo -e $(echo $(printf 'f%.0s' {1..12}; printf "$(echo $Proxmox | sed 's/://g')%.0s" {1..16}) | sed -e 's/../\\x&/g') | nc -w1 -u -b 255.255.255.255 4000
    echo -ne "Proxmox BOOTING "
    while true
    do 
      ping -c1 192.168.2.8 > /dev/null && break;
      echo -ne "."
      let countdown++
      if [ $countdown -gt 10 ]
      then
        exit
      fi
    done
    ;;
  c|C)
    break
    ;;
esac
