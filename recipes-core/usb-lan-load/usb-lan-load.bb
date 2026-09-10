SUMMARY = "Delayed module loading to prevent network interface swapping"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

SRC_URI = " \
    file://blacklist-lan78xx.conf \
    file://load-usblan.service \
"

S = "${WORKDIR}"

inherit systemd

SYSTEMD_PACKAGES = "${PN}"
SYSTEMD_SERVICE:${PN} = "load-usblan.service"

do_install() {
    # Install modprobe blacklist
    install -d ${D}${sysconfdir}/modprobe.d
    install -m 0644 ${WORKDIR}/blacklist-lan78xx.conf ${D}${sysconfdir}/modprobe.d/

    # Install systemd service
    install -d ${D}${systemd_system_unitdir}
    install -m 0644 ${WORKDIR}/load-usblan.service ${D}${systemd_system_unitdir}/
}

FILES:${PN} += " \
    ${sysconfdir}/modprobe.d/blacklist-lan78xx.conf \
    ${systemd_system_unitdir}/load-usblan.service \
"
