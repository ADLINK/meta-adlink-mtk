#!/bin/bash

SD_DEV="/dev/mmcblk1p1"
MOUNT_POINT="/media/sd_card"
TMP_EXEC_DIR="/tmp/test"

if [ ! -b "$SD_DEV" ]; then
  echo "Error: SD Card($SD_DEV) not found, please insert SD Card."
  exit 1
fi

echo "Mounting SD Card ..."
rm -rf "$MOUNT_POINT"
mkdir -p "$MOUNT_POINT"
mount -o remount,exec "$MOUNT_POINT" 2>/dev/null || mount -o exec "$SD_DEV" "$MOUNT_POINT"

if [ $? -ne 0 ]; then
  echo "Error: Mounting failed!"
  exit 1
fi

echo "Deploying programs to memory ..."
rm -rf "$TMP_EXEC_DIR"
mkdir -p "$TMP_EXEC_DIR"
cp -r "$MOUNT_POINT/." "$TMP_EXEC_DIR"

echo "Unmount SD Card ..."
umount "$MOUNT_POINT"
rm -rf "$MOUNT_POINT"

cd "$TMP_EXEC_DIR"
chmod +x -R .
