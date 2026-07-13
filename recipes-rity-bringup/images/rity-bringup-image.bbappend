# OSM-520 bringup image contents. Kept osm-520 scoped (and separate from
# rity-image-adlink.inc) so bringup images for other machines are not
# affected.
IMAGE_INSTALL:append:osm-520 = " mtd-utils mdio-tool pciutils canutils atecc-util eltt2 update-eth-mac resize-script hdparm dhrystone mmc-utils udev-lan7800-rename lmsensors modemmanager python3 python3-core python3-modules python3-misc"
IMAGE_INSTALL:append:osm-520-ufs = " mwifiex-driver flash-eth1-eeprom"
IMAGE_INSTALL:append:osm-520-emmc = " mwifiex-driver flash-eth1-eeprom"
