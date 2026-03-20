SUMMARY = "Realtek RTL8852BE WiFi driver"
DESCRIPTION = "Out-of-tree kernel module for RTL8852BE"
LICENSE = "CLOSED"
LIC_FILES_CHKSUM = ""

SRC_URI = "file://rtl8852be-dev.tar.gz \
		   file://adlink_mtk510.mk \
		   file://Makefile \
           file://firmware/rtl8852bu_config \
           file://firmware/rtl8852bu_fw"

S = "${WORKDIR}/rtl8852be"

inherit module

KERNEL_SRC ?= "${STAGING_KERNEL_BUILDDIR}"

EXTRA_OEMAKE += "ARCH=arm64 CROSS_COMPILE=${TARGET_PREFIX} KSRC=${KERNEL_SRC}"

do_compile:prepend() {
    cp ${WORKDIR}/adlink_mtk510.mk ${S}/platform/adlink_mtk510.mk
    cp ${WORKDIR}/Makefile ${S}/Makefile
}

do_compile() {
    oe_runmake -C ${S} \
        ARCH=arm64 \
        KSRC=${KERNEL_SRC} \
        CROSS_COMPILE=${TARGET_PREFIX} \
        modules
}

do_install() {
    install -d ${D}${nonarch_base_libdir}/modules/${KERNEL_VERSION}/extra
    install -m 0644 ${S}/*.ko ${D}${nonarch_base_libdir}/modules/${KERNEL_VERSION}/extra
}

do_install:append() {
    install -d ${D}${nonarch_base_libdir}/firmware/
    install -m 0644 ${WORKDIR}/firmware/rtl8852bu_config ${D}${nonarch_base_libdir}/firmware/
    install -m 0644 ${WORKDIR}/firmware/rtl8852bu_fw ${D}${nonarch_base_libdir}/firmware/
}

FILES:${PN} += "${nonarch_base_libdir}/modules/${KERNEL_VERSION}/extra"
FILES:${PN} += "${nonarch_base_libdir}/firmware/rtl8852bu_config"
FILES:${PN} += "${nonarch_base_libdir}/firmware/rtl8852bu_fw"


RPROVIDES:${PN} += "kernel-module-8852be kernel-module-8852be-${KERNEL_VERSION}"
RDEPENDS:${PN} += "kernel-module-8852be"
