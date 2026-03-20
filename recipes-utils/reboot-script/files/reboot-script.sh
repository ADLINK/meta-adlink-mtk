#!/bin/bash

# Path to the boottimes file
BOOTTIMES_FILE="/home/root/tools/boottimes"
SERVICE_NAME="reboot-script.service"

# Initialize boottimes file if it does not exist
if [ ! -f "$BOOTTIMES_FILE" ]; then
    echo "0" > "$BOOTTIMES_FILE"
fi

# Increment the boot count
BOOT_COUNT=$(awk '{print $1}' ${BOOTTIMES_FILE})
BOOT_COUNT=$((BOOT_COUNT + 1))
echo "$BOOT_COUNT" > "$BOOTTIMES_FILE"

# Display the current boot count
echo "Current boot count: $BOOT_COUNT"

# Check if the device does not exist
if [ ! -e "/dev/sdd1" ]; then
    # Check if the boot count exceeds 1000
    if [ "$BOOT_COUNT" -gt 1000 ]; then
        # Disable the reboot-script.service
        systemctl disable ${SERVICE_NAME}
    else
        # Wait for a few seconds and reboot the system
        sleep 3
        reboot
    fi
fi

