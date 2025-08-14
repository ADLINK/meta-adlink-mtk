SUMMARY = "Realtek RTL8852B Bluetooth driver"
DESCRIPTION = "Out-of-tree kernel module for RTL8852B Bluetooth"
LICENSE = "CLOSED"
LIC_FILES_CHKSUM = ""

SRC_URI = "file://20220110_LINUX_BT_DRIVER_RTL8852B_COEX_v0606.tar.gz \
           file://Makefile \
           file://firmware/rtlbt/rtl8852bs_config \
           file://firmware/rtlbt/rtl8852bs_fw \
           file://firmware/rtl_bt/rtl8852bs_config \
           file://firmware/rtl_bt/rtl8852bs_fw"

S = "${WORKDIR}/20220110_LINUX_BT_DRIVER_RTL8852B_COEX_v0606/usb/bluetooth_usb_driver"

inherit module

KERNEL_SRC ?= "${STAGING_KERNEL_BUILDDIR}"
EXTRA_OEMAKE += "ARCH=arm64 CROSS_COMPILE=${TARGET_PREFIX} KDIR=${KERNEL_SRC}"

do_compile:prepend() {
    cp ${WORKDIR}/Makefile ${S}/Makefile
}

do_compile() {
    oe_runmake
}

do_install() {
    install -d ${D}${nonarch_base_libdir}/modules/${KERNEL_VERSION}/extra
    install -m 0644 ${S}/*.ko ${D}${nonarch_base_libdir}/modules/${KERNEL_VERSION}/extra

    install -d ${D}${nonarch_base_libdir}/firmware/
    cp -r ${WORKDIR}/firmware/rtlbt ${D}${nonarch_base_libdir}/firmware/
    cp -r ${WORKDIR}/firmware/rtl_bt ${D}${nonarch_base_libdir}/firmware/
}

FILES:${PN} += "${nonarch_base_libdir}/modules/${KERNEL_VERSION}/extra"
FILES:${PN} += "${nonarch_base_libdir}/firmware"
FILES:${PN} += "${nonarch_base_libdir}/firmware/rtlbt"
FILES:${PN} += "${nonarch_base_libdir}/firmware/rtl_bt"


RPROVIDES:${PN} += "kernel-module-rtk-btusb"
RPROVIDES:${PN} += "kernel-module-rtk-btusb-${KERNEL_VERSION}"

