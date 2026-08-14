SUMMARY = "Rename Genio520/510 ethernet interface to eth0"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

SRC_URI = "file://70-persistent-net.rules"

S = "${WORKDIR}"

do_install() {
    install -d ${D}${sysconfdir}/udev/rules.d
    install -m 0644 ${WORKDIR}/70-persistent-net.rules \
        ${D}${sysconfdir}/udev/rules.d/70-persistent-net.rules
}

FILES:${PN} = "${sysconfdir}/udev/rules.d/70-persistent-net.rules"
