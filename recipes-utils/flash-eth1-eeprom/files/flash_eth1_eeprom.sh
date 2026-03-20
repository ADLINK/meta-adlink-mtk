#!/bin/sh

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <new MAC address>"
    exit 1
fi

new_mac="$1"
mac_parts=(${new_mac//:/ })

if [ "${#mac_parts[@]}" -ne 6 ]; then
    echo "Invalid MAC address format."
    exit 1
fi

bin_file="/home/root/tools/EEPROM_7800.bin"

for i in {0..5}; do
    printf "\\x${mac_parts[$i]}" | dd of="$bin_file" bs=1 seek=$((0x01 + i)) count=1 conv=notrunc 2>/dev/null
done

ethtool -E eth1 magic 0x78a5 offset 0 length 512 < "$bin_file"

echo "EEPROM updated with new MAC address: $new_mac"
