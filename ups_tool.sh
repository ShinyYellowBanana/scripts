#!/bin/bash

# Define the variables
address="192.168.2.4"  # Replace with the desired IP address
command="snmpwalk -v2c -c homelab 192.168.2.4 .1.3.6.1.4.1.8072.1.3.2.4.1.2 | grep -i string | awk -F'\"' '{print \$2}'"
user="labuser"

# Function to display script usage
usage() {
    echo "Usage: $0 [-a <about>] [-v <volts>] [-p <percent>] [-o <on-line>] [-t <time>]"
    echo "Options:"
    echo "  -a     UPS description"
    echo "  -v     Votage of UPS (Healthy: 27v)"
    echo "  -p     Percent of battery left (Full: 100)"
    echo "  -o     On line or Disconnected (Good: "OL")"
    echo "  -t     Seconds estimated left (1620)"
    exit 1
}
# Ping the address to check if it is reachable
if ping -c 1 -W 1 "$address" &> /dev/null; then
    # Parse command line options
    while getopts "avpom" opt; do
        case "$opt" in
            a)
                about="2"
                command="snmpwalk -v2c -c homelab 192.168.2.4 .1.3.6.1.4.1.8072.1.3.2.4.1.2 | grep -i string | awk -F'\"' '{print \$2}' | sed -n '2p'"
                ;;
            v)
                volts="3"
                command="snmpwalk -v2c -c homelab 192.168.2.4 .1.3.6.1.4.1.8072.1.3.2.4.1.2 | grep -i string | awk -F'\"' '{print \$2}' | sed -n '3p' | bc -l" #Save as a float
                ;;
            p)
                percent="6"
                command="snmpwalk -v2c -c homelab 192.168.2.4 .1.3.6.1.4.1.8072.1.3.2.4.1.2 | grep -i string | awk -F'\"' '{print \$2}' | sed -n '6p' | awk '{print \$0+0}'" #Save as an int
                ;;
            o)
                online="5"
                command="snmpwalk -v2c -c homelab 192.168.2.4 .1.3.6.1.4.1.8072.1.3.2.4.1.2 | grep -i string | awk -F'\"' '{print \$2}' | sed -n '5p'"
                ;;
            m)
                time="7"
                command="snmpwalk -v2c -c homelab 192.168.2.4 .1.3.6.1.4.1.8072.1.3.2.4.1.2 | grep -i string | awk -F'\"' '{print \$2}' | sed -n '7p' | awk '{print \$0+0}'" #Save as an int
                ;;
            *)
                usage
                ;;
        esac
    done
  
    # If ping is successful, execute the command over SSH and capture the response
    response=$(ssh "$user"@"$address" $command)
    echo "$response"

else
    echo "Server is not reachable"
fi
