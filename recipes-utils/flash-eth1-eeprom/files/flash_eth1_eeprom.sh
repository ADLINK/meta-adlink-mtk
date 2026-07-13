#!/bin/bash

# Program the LAN7800 USB-ethernet EEPROM (MAC + LED/board config).
# Usage: flash_eth1_eeprom.sh <new MAC address> [interface]
#   interface defaults to eth1 (the name udev-lan7800-rename assigns).

if [ "$#" -lt 1 ] || [ "$#" -gt 2 ]; then
    echo "Usage: $0 <new MAC address> [interface]"
    exit 1
fi

new_mac="$1"
iface="${2:-eth1}"
mac_parts=(${new_mac//:/ })

if [ "${#mac_parts[@]}" -ne 6 ]; then
    echo "Invalid MAC address format."
    exit 1
fi

# Look for the EEPROM image next to this script, wherever it is installed.
bin_file="$(dirname "$(readlink -f "$0")")/EEPROM_7800.bin"

if [ ! -f "$bin_file" ]; then
    echo "EEPROM image not found: $bin_file"
    exit 1
fi

for i in {0..5}; do
    printf "\\x${mac_parts[$i]}" | dd of="$bin_file" bs=1 seek=$((0x01 + i)) count=1 conv=notrunc 2>/dev/null
done

ethtool -E "$iface" magic 0x78a5 offset 0 length 512 < "$bin_file"

echo "EEPROM updated with new MAC address: $new_mac on $iface"
