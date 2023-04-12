#!/bin/bash

# Replace MAC address with the value of $2 

echo "[Match]" > /etc/systemd/network/00-$1.link 
echo "OriginalName=$1" >> /etc/systemd/network/00-$1.link 
echo "[Link]" >> /etc/systemd/network/00-$1.link 
echo "MACAddress=$2" >> /etc/systemd/network/00-$1.link
sync
