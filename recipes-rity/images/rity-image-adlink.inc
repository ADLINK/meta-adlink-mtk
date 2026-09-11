# Tools
IMAGE_INSTALL += " mtd-utils mdio-tool pciutils canutils atecc-util eltt2 update-eth-mac resize-script"
#IMAGE_INSTALL += " linux-firmware-iwlwifi "
#IMAGE_INSTALL += " docker python3-docker-compose "

#DISTRO_FEATURES:append = " virtualization"

# OSM-MTK520
IMAGE_INSTALL:append:osm-mtk520 = " hdparm dhrystone mmc-utils udev-lan7800-rename"
IMAGE_INSTALL:append:osm-mtk520-ufs = " mwifiex-driver flash-eth1-eeprom"
IMAGE_INSTALL:append:osm-mtk520-emmc = " mwifiex-driver flash-eth1-eeprom"

#OSM-MTK10
IMAGE_INSTALL:append:osm-mtk510 = " mwifiex-driver hdparm dhrystone mmc-utils udev-eth-rename-mtk510 usb-lan-load "
