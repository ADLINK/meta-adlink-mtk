SUMMARY = "Realtek RTL8852BE WiFi driver https://github.com/HRex39/rtl8852be.git"
DESCRIPTION = "Out-of-tree kernel module for RTL8852BE"
LICENSE = "CLOSED"
LIC_FILES_CHKSUM = ""

SRC_URI = "file://rtl8852be-dev.tar.gz \
		   file://Makefile \
           file://firmware/rtl8852bu_config \
           file://firmware/rtl8852bu_fw"

S = "${WORKDIR}/rtl8852be"

inherit module


do_configure:prepend() {
    cp ${WORKDIR}/Makefile ${S}/Makefile
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
