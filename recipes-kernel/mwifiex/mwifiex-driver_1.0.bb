SUMMARY = "NXP/Marvell WiFi driver"
DESCRIPTION = "Out-of-tree kernel module for NXP/Marvell Wifi"
LICENSE = "CLOSED"
LIC_FILES_CHKSUM = ""

SRC_URI = "file://mwifiex.tar.zst \
           file://firmware/sdiouart8997_combo_v4.bin \    
           file://firmware/ed_mac_ctrl_V3_8997.conf \    
           file://firmware/txpwrlimit_cfg_8997.conf \    
           file://firmware/sdio8997_wlan_v4.bin \    
           file://firmware/uart8997_bt_v4.bin \    
           file://firmware/wifi_mod_para.conf \
           file://modprobe.d/moal.conf \
           file://modprobe.d/mlan.conf \
           file://modules-load.d/moal.conf \
           file://modules-load.d/mlan.conf \
"

S = "${WORKDIR}/mwifiex"

inherit module

EXTRA_OEMAKE += "KERNELDIR=${STAGING_KERNEL_DIR} KBUILD_MODPOST_WARN=1"

do_compile() {
    oe_runmake -C ${S}
}

do_install() {
    install -d ${D}${nonarch_base_libdir}/modules/${KERNEL_VERSION}/extra
    find ${S} -name "*.ko" -exec install -m 0644 {} ${D}${nonarch_base_libdir}/modules/${KERNEL_VERSION}/extra/ \;

    install -d ${D}${nonarch_base_libdir}/firmware/nxp
    install -m 0644 ${WORKDIR}/firmware/sdiouart8997_combo_v4.bin ${D}${nonarch_base_libdir}/firmware/nxp/
    install -m 0644 ${WORKDIR}/firmware/ed_mac_ctrl_V3_8997.conf ${D}${nonarch_base_libdir}/firmware/nxp/
    install -m 0644 ${WORKDIR}/firmware/txpwrlimit_cfg_8997.conf ${D}${nonarch_base_libdir}/firmware/nxp/
    install -m 0644 ${WORKDIR}/firmware/sdio8997_wlan_v4.bin ${D}${nonarch_base_libdir}/firmware/nxp/
    install -m 0644 ${WORKDIR}/firmware/uart8997_bt_v4.bin ${D}${nonarch_base_libdir}/firmware/nxp/
    install -m 0644 ${WORKDIR}/firmware/wifi_mod_para.conf ${D}${nonarch_base_libdir}/firmware/nxp/
    install -d ${D}${sysconfdir}/modprobe.d/
    install -m 0644 ${WORKDIR}/modprobe.d/moal.conf ${D}${sysconfdir}/modprobe.d/
    install -m 0644 ${WORKDIR}/modprobe.d/mlan.conf ${D}${sysconfdir}/modprobe.d/
    install -d ${D}${sysconfdir}/modules-load.d/
    install -m 0644 ${WORKDIR}/modules-load.d/moal.conf ${D}${sysconfdir}/modules-load.d/
    install -m 0644 ${WORKDIR}/modules-load.d/mlan.conf ${D}${sysconfdir}/modules-load.d/
}

FILES:${PN} += "${nonarch_base_libdir}/firmware"
FILES:${PN} += "${nonarch_base_libdir}/firmware/sdiouart8997_combo_v4.bin"
FILES:${PN} += "${nonarch_base_libdir}/firmware/ed_mac_ctrl_V3_8997.conf"
FILES:${PN} += "${nonarch_base_libdir}/firmware/txpwrlimit_cfg_8997.conf"
FILES:${PN} += "${nonarch_base_libdir}/firmware/sdio8997_wlan_v4.bin"
FILES:${PN} += "${nonarch_base_libdir}/firmware/uart8997_bt_v4.bin"
FILES:${PN} += "${nonarch_base_libdir}/firmware/wifi_mod_para.conf"
FILES:${PN} += "${sysconfdir}/modprobe.d"
FILES:${PN} += "${sysconfdir}/modprobe.d/moal.conf"
FILES:${PN} += "${sysconfdir}/modprobe.d/mlan.conf"
FILES:${PN} += "${sysconfdir}/modules-load.d"
FILES:${PN} += "${sysconfdir}/modules-load.d/moal.conf"
FILES:${PN} += "${sysconfdir}/modules-load.d/mlan.conf"

INSANE_SKIP:${PN} += "installed-vs-shipped"

RDEPENDS:${PN} += "kernel-module-mlan kernel-module-moal"

RPROVIDES:${PN} += "kernel-module-mwifiex"
