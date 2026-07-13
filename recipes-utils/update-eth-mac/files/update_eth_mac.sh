#!/bin/bash

# Check if the user provided a MAC address
if [ -z "$1" ]; then
    echo "Usage: $0 <MAC address>"
    exit 1
fi

# Set the I2C bus number and the EEPROM slave address
I2C_BUS=4
EEPROM_SLAVE_ADDR=0x52

# Parse the MAC address and remove colons
MAC_ADDRESS=$(echo $1 | tr -d ':')

# Check if the MAC address has the correct length
if [ ${#MAC_ADDRESS} -ne 12 ]; then
    echo "Error: Invalid MAC address length."
    exit 1
fi

# Write the MAC address to the EEPROM
for i in {0..5}; do
    BYTE=$(echo $MAC_ADDRESS | cut -c $(($i*2+1))-$(($i*2+2)))
    i2cset -f -y $I2C_BUS $EEPROM_SLAVE_ADDR $i 0x$BYTE
    sleep 0.1
done

echo "Successfully updated MAC address in EEPROM."
