#!/bin/bash

# Get the network interface from the output of ip addr show
INTERFACE=$(ip addr show | grep -F ': ' | awk 'NR==2{split($2, a, ":"); print a[1]}')

# Check if the ethtool command is available
if ! command -v ethtool &>/dev/null; then
  echo "ethtool is not installed. Please install it and try again."
  exit 1
fi

# Check if the network interface exists
if ! ip link show "$INTERFACE" &>/dev/null; then
  echo "Network interface $INTERFACE does not exist."
  exit 1
fi

# Check if Wake-on-LAN is already enabled
ethtool "$INTERFACE" | grep -q "Wake-on: g"
if [ $? -eq 0 ]; then
  echo "Wake-on-LAN is already enabled for $INTERFACE."
else
  # Enable Wake-on-LAN
  ethtool -s "$INTERFACE" wol g
  if [ $? -eq 0 ]; then
    echo "Wake-on-LAN has been enabled for $INTERFACE."
  else
    echo "Failed to enable Wake-on-LAN for $INTERFACE. Make sure you have sudo privileges."
  fi
fi
