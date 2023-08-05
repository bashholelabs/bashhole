#!/bin/bash

#truncate -s 0 output-log.txt
echo "------------------------------------------" >> output-log.txt

ping-nas() {
# Ping the first IP address
ping -c 1 $1 > /dev/null 2>&1
}

ping-server() {
ping-nas 172.168.1.83
# Check the exit status of the ping command
if [ $? -eq 0 ]; then
    echo "Ping to NAS  successful." >> output-log.txt

    # Check if the other IPs are running
    ping -c 1 $1 > /dev/null 2>&1
    ping_status_1=$?
    if [ $ping_status_1 -ne 0 ]; then
        echo "Server with address $1 is not running. Starting qm..." >> output-log.txt
        /usr/sbin/qm start $2
    else
        echo "$1 is running. Quitting." >> output-log.txt
    fi
else
    echo "Ping to $IP_ADDRESS failed. qm will not be started." >> output-log.txt

fi

now=$(date)

echo "$now" >> output-log.txt
echo "-------------------------------------------" >> output-log.txt
}

ping-server 172.168.1.247 156
ping-server 172.168.1.23 3000
ping-server 172.168.1.56 135
