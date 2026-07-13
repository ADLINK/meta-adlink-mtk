#!/bin/sh
# Replace /dev/sdc with the actual device you want to operate on
DEVICE=/dev/sdc
NUM=10
PARTITION=${DEVICE}${NUM}
SERVICE_NAME=resize.service
PATTERN="Disk ${DEVICE}"

# Check if the partition is already expanded
PARTITION_END=$(parted ${DEVICE} unit GB print | awk '/'${NUM}' / {print $3}')
DEVICE_SIZE=$(parted ${DEVICE} unit GB print | awk -v pattern="$PATTERN" '$0 ~ pattern {print $3}')

if [ "${PARTITION_END}" == "${DEVICE_SIZE}" ]; then
    # If the partition is already expanded, disable the service
    systemctl disable ${SERVICE_NAME}
else
    # If not, fix partition table and expand the filesystem
    yes Fix | parted ---pretend-input-tty ${DEVICE} print
    touch /forcefsck
    parted ${DEVICE} resizepart ${NUM} 100%
    resize2fs ${PARTITION}
fi
