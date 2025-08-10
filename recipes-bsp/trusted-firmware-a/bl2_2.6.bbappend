FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI:append = " \
        file://0001-Enable-VCC-for-Ethernet-PHY-and-USB-hub.patch \
"
SRC_URI:append:lec-mtk-i1200-qspi = " ${BL2_SRC_PATCHES} "
