#!/bin/sh
# Replace /dev/sdc with the actual device you want to operate on
DEVICE=/dev/sdc
PARTITION=${DEVICE}3
SERVICE_NAME=resize.service

# Check if the partition is already expanded
PARTITION_END=$(parted ${DEVICE} unit GB print | awk '/ 3 / {print $3}')
DEVICE_SIZE=$(parted ${DEVICE} unit GB print | awk '/Disk/ {print $3}')

if [ "${PARTITION_END}" == "${DEVICE_SIZE}" ]; then
    # If the partition is already expanded, disable the service
    systemctl disable ${SERVICE_NAME}
else
    # If not, fix partition table and expand the filesystem
    yes Fix | parted ---pretend-input-tty ${DEVICE} print
    parted ${DEVICE} resizepart 3 100%
    resize2fs ${PARTITION}
fi

