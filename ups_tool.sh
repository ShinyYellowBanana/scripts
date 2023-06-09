#!/bin/bash

# Define the variables
address="192.168.2.4"  # Replace with the desired IP address
command="snmpwalk -v2c -c homelab 192.168.2.4 .1.3.6.1.4.1.8072.1.3.2.4.1.2 | grep -i string | awk -F'\"' '{print \$2}' | tail -2 | head -1 | awk '{print \$0+0}'"
user="labuser"

# Ping the address to check if it is reachable
if ping -c 1 -W 1 "$address" &> /dev/null; then
    # If ping is successful, execute the command over SSH and capture the response
    response=$(ssh "$user"@"$address" "$command")
    exit_code=$?
    # Check the exit code of the SSH command
    if [ "$exit_code" -ne 0 ]; then
        echo "Error executing SSH command. Exit code: $exit_code"
    else
        echo "$response"
    fi
else
    echo "Server is not reachable"
fi
