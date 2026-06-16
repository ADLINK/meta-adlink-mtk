#LEC-MTK1200
# Tools
# Removed resize-script as same script provided by base-files as expand-rootfs by MTK
IMAGE_INSTALL:append:lec-mtk1200 = " mtd-utils mdio-tool pciutils canutils atecc-util eltt2 update-eth-mac "
#IMAGE_INSTALL += " linux-firmware-iwlwifi "
#IMAGE_INSTALL += " docker python3-docker-compose "

#DISTRO_FEATURES:append = " virtualization"

#OSM-MTK510
# Tools
IMAGE_INSTALL:append:osm-mtk510 = " hdparm mdio-tool pciutils canutils atecc-util eltt2 dhrystone"
# Extar driver
IMAGE_INSTALL:append:osm-mtk510 = " rtl8852be-driver rtl8852be-bt-driver "

